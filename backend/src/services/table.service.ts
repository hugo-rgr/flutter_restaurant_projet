import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();

export interface CreateTableData {
  number: number;
  seats: number;
}

export interface UpdateTableData {
  number?: number;
  seats?: number;
}

export class TableService {
  // Create a new table
  async createTable(data: CreateTableData) {
    // Check if table number already exists
    const existingTable = await prisma.table.findUnique({
      where: { number: data.number },
    });

    if (existingTable) {
      throw new Error(`Table number ${data.number} already exists`);
    }

    const table = await prisma.table.create({
      data: {
        number: data.number,
        seats: data.seats,
      },
    });

    return table;
  }

  // Get all tables
  async getAllTables() {
    const tables = await prisma.table.findMany({
      orderBy: {
        number: 'asc',
      },
      include: {
        _count: {
          select: {
            reservations: true,
          },
        },
      },
    });

    return tables;
  }

  // Get a single table by ID
  async getTableById(id: number) {
    const table = await prisma.table.findUnique({
      where: { id },
      include: {
        reservations: {
          include: {
            user: {
              select: {
                id: true,
                email: true,
                name: true,
                phone: true,
                role: true,
              },
            },
          },
          orderBy: {
            startDate: 'asc',
          },
        },
      },
    });

    if (!table) {
      throw new Error('Table not found');
    }

    return table;
  }

  // Update a table
  async updateTable(id: number, data: UpdateTableData) {
    // Check if table exists
    const existingTable = await prisma.table.findUnique({
      where: { id },
    });

    if (!existingTable) {
      throw new Error('Table not found');
    }

    // If updating number, check if new number is already in use
    if (data.number && data.number !== existingTable.number) {
      const tableWithSameNumber = await prisma.table.findUnique({
        where: { number: data.number },
      });

      if (tableWithSameNumber) {
        throw new Error(`Table number ${data.number} already exists`);
      }
    }

    // If reducing seats, check if it affects existing reservations
    if (data.seats && data.seats < existingTable.seats) {
      const futureReservations = await prisma.reservation.findMany({
        where: {
          tableId: id,
          startDate: { gte: new Date() },
          status: { not: 'cancelled' },
        },
      });

      const conflictingReservations = futureReservations.filter(
        (res) => res.numberOfGuests > data.seats!
      );

      if (conflictingReservations.length > 0) {
        throw new Error(
          `Cannot reduce seats: ${conflictingReservations.length} future reservation(s) have more guests than the new seat count`
        );
      }
    }

    const table = await prisma.table.update({
      where: { id },
      data,
    });

    return table;
  }

  // Delete a table
  async deleteTable(id: number) {
    // Check if table exists
    const table = await prisma.table.findUnique({
      where: { id },
    });

    if (!table) {
      throw new Error('Table not found');
    }

    // Check if table has future reservations
    const futureReservations = await prisma.reservation.findMany({
      where: {
        tableId: id,
        startDate: { gte: new Date() },
        status: { not: 'cancelled' },
      },
    });

    if (futureReservations.length > 0) {
      throw new Error(
        `Cannot delete table: it has ${futureReservations.length} future reservation(s)`
      );
    }

    await prisma.table.delete({
      where: { id },
    });

    return { message: 'Table deleted successfully' };
  }

  // Get table statistics
  async getTableStatistics(id: number) {
    const table = await prisma.table.findUnique({
      where: { id },
      include: {
        reservations: true,
      },
    });

    if (!table) {
      throw new Error('Table not found');
    }

    const totalReservations = table.reservations.length;
    const confirmedReservations = table.reservations.filter(
      (res) => res.status === 'confirmed'
    ).length;
    const pendingReservations = table.reservations.filter(
      (res) => res.status === 'pending'
    ).length;
    const cancelledReservations = table.reservations.filter(
      (res) => res.status === 'cancelled'
    ).length;

    return {
      tableId: table.id,
      tableNumber: table.number,
      seats: table.seats,
      totalReservations,
      confirmedReservations,
      pendingReservations,
      cancelledReservations,
    };
  }
}

export default new TableService();
