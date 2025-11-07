import { PrismaClient, ReservationStatus } from '@prisma/client';
import {sendReservationAcceptedEmail, sendReservationRejectedEmail, sendReservationRequestDone} from "../config/emails";

const prisma = new PrismaClient();

export interface CreateReservationData {
  userId: number;
  tableId: number;
  timeSlotId: string;
  numberOfGuests: number;
  startDate: Date;
  endDate: Date;
}

export interface UpdateReservationData {
  tableId?: number;
  numberOfGuests?: number;
  startDate?: Date;
  endDate?: Date;
  status?: ReservationStatus;
}

export interface AvailabilityQuery {
  startDate: Date;
  endDate: Date;
  numberOfGuests: number;
}

export class ReservationService {
  // Create a new reservation
  async createReservation(data: CreateReservationData) {
      console.log('merdddddddde 111111');

      // Check if table exists
    const table = await prisma.table.findUnique({
      where: { id: data.tableId },
    });

    if (!table) {
      throw new Error('Table not found');
    }

    // Check if table has enough seats
    if (table.seats < data.numberOfGuests) {
      throw new Error(`Table only has ${table.seats} seats, but ${data.numberOfGuests} guests requested`);
    }

    // Check availability
    const isAvailable = await this.checkTableAvailability(
      data.tableId,
      data.startDate,
      data.endDate
    );

    if (!isAvailable) {
      throw new Error('Table is not available for the selected time slot');
    }

    // Create reservation
    const reservation = await prisma.reservation.create({
      data: {
        userId: data.userId,
        tableId: data.tableId,
        timeSlotId: data.timeSlotId,
        numberOfGuests: data.numberOfGuests,
        startDate: data.startDate,
        endDate: data.endDate,
      },
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
        table: true,
      },
    });

    return reservation;
  }

  // Get all reservations (with optional filters)
  async getAllReservations(userId?: number, status?: ReservationStatus) {
    const where: any = {};

    if (userId) {
      where.userId = userId;
    }

    if (status) {
      where.status = status;
    }

    const reservations = await prisma.reservation.findMany({
      where,
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
        table: true,
      },
      orderBy: {
        startDate: 'asc',
      },
    });

    return reservations;
  }



  // Admin or hst getting all reservation

  // Get a single reservation by ID
  async getAllReservationToManage() {

    return  prisma.reservation.findMany({
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
        table: true,
      },
      orderBy: {
        startDate: 'asc',
      },

    });

    }

    async getReservationById(id: number) {
        const reservation = await prisma.reservation.findUnique({
            where: { id },
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
                table: true,
            },
        });

        if (!reservation) {
            throw new Error('Reservation not found');
        }

        return reservation;
    }


  // Update a reservation
  async updateReservation(id: number, userId: number, data: UpdateReservationData) {
    // Check if reservation exists
    const existingReservation = await prisma.reservation.findUnique({
      where: { id },
    });

    if (!existingReservation) {
      throw new Error('Reservation not found');
    }

    // Check if user owns the reservation
    if (existingReservation.userId !== userId) {
      throw new Error('You are not authorized to update this reservation');
    }

    // If updating table or date, check availability
    if (data.tableId || data.startDate || data.endDate) {
      const tableId = data.tableId || existingReservation.tableId;
      const startDate = data.startDate || existingReservation.startDate;
      const endDate = data.endDate || existingReservation.endDate;

      const isAvailable = await this.checkTableAvailability(
        tableId,
        startDate,
        endDate,
        id // exclude current reservation from check
      );

      if (!isAvailable) {
        throw new Error('Table is not available for the selected time slot');
      }
    }

    // If updating numberOfGuests, check table capacity
    if (data.numberOfGuests) {
      const tableId = data.tableId || existingReservation.tableId;
      const table = await prisma.table.findUnique({
        where: { id: tableId },
      });

      if (table && table.seats < data.numberOfGuests) {
        throw new Error(`Table only has ${table.seats} seats, but ${data.numberOfGuests} guests requested`);
      }
    }

    // Update reservation
    const reservation = await prisma.reservation.update({
      where: { id },
      data,
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
        table: true,
      },
    });

    return reservation;
  }

  // Update reservation status (for hosts/admins)
  async updateReservationStatus(id: number, status: ReservationStatus) {
    const reservation = await prisma.reservation.update({
      where: { id },
      data: { status },
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
        table: true,
      },
    });


    const user = reservation.user;

      const reservationDate: string = new Date(reservation.startDate).toDateString();

      const reservationTime: string = (new Date(reservation.startDate).getHours() -1).toString().padStart(2, '0') + ':' + new Date(reservation.startDate).getMinutes().toString().padStart(2, '0');

      if(status===ReservationStatus.confirmed){
          await sendReservationAcceptedEmail(user.email,reservationDate, reservationTime )
      }else {
            await sendReservationRejectedEmail(user.email,reservationDate, reservationTime )
      }



    return reservation;
  }

  // Delete a reservation
  async deleteReservation(id: number, userId: number) {
    // Check if reservation exists
    const reservation = await prisma.reservation.findUnique({
      where: { id },
    });

    if (!reservation) {
      throw new Error('Reservation not found');
    }

    // Check if user owns the reservation
    if (reservation.userId !== userId) {
      throw new Error('You are not authorized to delete this reservation');
    }

    await prisma.reservation.delete({
      where: { id },
    });

    return { message: 'Reservation deleted successfully' };
  }

  // Check table availability
  async checkTableAvailability(
    tableId: number,
    startDate: Date,
    endDate: Date,
    excludeReservationId?: number
  ): Promise<boolean> {
    const where: any = {
      tableId,
      status: { not: ReservationStatus.cancelled },
      OR: [
        {
          // New reservation starts during an existing reservation
          startDate: { lte: startDate },
          endDate: { gt: startDate },
        },
        {
          // New reservation ends during an existing reservation
          startDate: { lt: endDate },
          endDate: { gte: endDate },
        },
        {
          // New reservation completely covers an existing reservation
          startDate: { gte: startDate },
          endDate: { lte: endDate },
        },
      ],
    };

    if (excludeReservationId) {
      where.id = { not: excludeReservationId };
    }

    const conflictingReservations = await prisma.reservation.findMany({
      where,
    });

    return conflictingReservations.length === 0;
  }

  // Get available tables for a time slot
  async getAvailableTables(query: AvailabilityQuery) {
    // Get all tables
    const allTables = await prisma.table.findMany({
      where: {
        seats: { gte: query.numberOfGuests },
      },
    });

    // Check availability for each table
    const availableTables = [];
    for (const table of allTables) {
      const isAvailable = await this.checkTableAvailability(
        table.id,
        query.startDate,
        query.endDate
      );

      if (isAvailable) {
        availableTables.push(table);
      }
    }

    return availableTables;
  }

  // Get availability summary for a date range
  async getAvailabilitySummary(startDate: Date, endDate: Date) {
    const allTables = await prisma.table.findMany();

    const reservations = await prisma.reservation.findMany({
      where: {
        status: { not: ReservationStatus.cancelled },
        OR: [
          {
            startDate: { lte: startDate },
            endDate: { gt: startDate },
          },
          {
            startDate: { lt: endDate },
            endDate: { gte: endDate },
          },
          {
            startDate: { gte: startDate },
            endDate: { lte: endDate },
          },
        ],
      },
    });

    const totalSeats = allTables.reduce((sum, table) => sum + table.seats, 0);
    const reservedSeats = reservations.reduce((sum, res) => sum + res.numberOfGuests, 0);
    const availableSeats = totalSeats - reservedSeats;

    return {
      totalTables: allTables.length,
      totalSeats,
      reservedSeats,
      availableSeats,
      reservedTables: reservations.length,
      availableTables: allTables.length - reservations.length,
    };
  }
}

export default new ReservationService();
