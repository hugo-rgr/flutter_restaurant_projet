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

type tableSlot = {
    id        :number
    startTime :string
    endTime   :string
    available :boolean
}

// Normalisation des heures (format HH:MM)
const initialTimeSlots: tableSlot[] = [
    { id: 1, startTime: '08:00', endTime: '09:00', available: true },
    { id: 2, startTime: '10:00', endTime: '11:00', available: true },
    { id: 3, startTime: '12:00', endTime: '13:00', available: true },
    { id: 4, startTime: '14:00', endTime: '15:00', available: true },
    { id: 5, startTime: '18:00', endTime: '19:00', available: true },
    { id: 6, startTime: '19:00', endTime: '20:00', available: true },
];

export class TableService {
  static getTimeSlots() { return initialTimeSlots; }
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
          timeSlot: initialTimeSlots
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

  // get available table

    async getAvailableTables(seats: number, date: Date, timeSlotId: string) {
        // Validation timeSlotId connu
        const slot = initialTimeSlots.find(ts => String(ts.id) === String(timeSlotId));
        if (!slot) {
            throw new Error(`Unknown timeSlotId '${timeSlotId}'`);
        }

        // Construit les Date réelles du créneau (slotStart / slotEnd)
        const day = new Date(date);
        if (isNaN(day.getTime())) {
            throw new Error('Invalid date');
        }
        // On force à minuit pour partir proprement
        day.setHours(0,0,0,0);
        const [slotStartHour, slotStartMin] = slot.startTime.split(':').map(n => parseInt(n,10));
        const [slotEndHour, slotEndMin]     = slot.endTime.split(':').map(n => parseInt(n,10));
        const slotStart = new Date(day);
        slotStart.setHours(slotStartHour, slotStartMin, 0, 0);
        const slotEnd = new Date(day);
        slotEnd.setHours(slotEndHour, slotEndMin, 0, 0);

        // Tables candidates (sièges suffisants)
        const candidateTables = await prisma.table.findMany({
            where: { seats: { gte: seats } },
            orderBy: { number: 'asc' }
        });
        if (candidateTables.length === 0) return [];
        const candidateIds = candidateTables.map(t => t.id);

        // Conflits: réservations non annulées qui chevauchent l'intervalle
        // Chevauchement: startDate < slotEnd AND endDate > slotStart
        const conflictingReservations = await prisma.reservation.findMany({
            where: {
                tableId: { in: candidateIds },
                status: { not: 'cancelled' },
                // Filtrage rapide sur la journée pour limiter: startDate >= day - 1 jour ? On s'en tient au chevauchement direct.
                AND: [
                  { startDate: { lt: slotEnd } },
                  { endDate: { gt: slotStart } },
                ],
                timeSlotId: String(timeSlotId) // garde la sémantique du créneau demandé
            },
            select: { tableId: true }
        });

        const blockedIds = new Set(conflictingReservations.map(r => r.tableId));
        return candidateTables.filter(t => !blockedIds.has(t.id));
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
