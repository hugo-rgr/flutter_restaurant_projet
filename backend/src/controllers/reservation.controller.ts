import { Request, Response } from 'express';
import reservationService from '../services/reservation.service';
import { ReservationStatus } from '@prisma/client';

export class ReservationController {
  // Create a new reservation
  async createReservation(req: Request, res: Response): Promise<void> {
    try {
      const { tableId, timeSlotId, numberOfGuests, startDate, endDate } = req.body;
      const userId = (req as any).user.userId;

      // Validation
      if (!tableId || !timeSlotId || !numberOfGuests || !startDate || !endDate) {
        res.status(400).json({
          error: 'tableId, timeSlotId, numberOfGuests, startDate, and endDate are required',
        });
        return;
      }

      const reservation = await reservationService.createReservation({
        userId,
        tableId: parseInt(tableId),
        timeSlotId: timeSlotId,
        numberOfGuests: parseInt(numberOfGuests),
        startDate: new Date(startDate),
        endDate: new Date(endDate),
      });

      res.status(201).json(reservation);
    } catch (error) {
      if (error instanceof Error) {
        res.status(400).json({ error: error.message });
      } else {
        res.status(500).json({ error: 'An unknown error occurred' });
      }
    }
  }

  // Get all reservations
  async getAllReservations(req: Request, res: Response): Promise<void> {
    try {
      const { userId, status } = req.query;
      const currentUser = (req as any).user;

      // If user is a client, only show their own reservations
      let userIdFilter = undefined;
      if (currentUser.role === 'client') {
        userIdFilter = currentUser.userId;
      } else if (userId) {
        userIdFilter = parseInt(userId as string);
      }

      const statusFilter = status as ReservationStatus | undefined;

      const reservations = await reservationService.getAllReservations(
        userIdFilter,
        statusFilter
      );

      res.status(200).json( reservations);
    } catch (error) {
      if (error instanceof Error) {
        res.status(500).json({ error: error.message });
      } else {
        res.status(500).json({ error: 'An unknown error occurred' });
      }
    }
  }

  // Get a single reservation
  async getReservationById(req: Request, res: Response): Promise<void> {
    try {
      const { id } = req.params;
      const currentUser = (req as any).user;

      const reservation = await reservationService.getReservationById(
        parseInt(id)
      );

      // Check authorization
      if (
        currentUser.role === 'client' &&
        reservation.userId !== currentUser.userId
      ) {
        res.status(403).json({
          error: 'You are not authorized to view this reservation',
        });
        return;
      }

      res.status(200).json(reservation);
    } catch (error) {
      if (error instanceof Error) {
        if (error.message === 'Reservation not found') {
          res.status(404).json({ error: error.message });
          return;
        }
        res.status(500).json({ error: error.message });
      } else {
        res.status(500).json({ error: 'An unknown error occurred' });
      }
    }
  }

  // Update a reservation
  async updateReservation(req: Request, res: Response): Promise<void> {
    try {
      const { id } = req.params;
      const userId = (req as any).user.userId;
      const { tableId, numberOfGuests, startDate, endDate, status } = req.body;

      const data: any = {};
      if (tableId) data.tableId = parseInt(tableId);
      if (numberOfGuests) data.numberOfGuests = parseInt(numberOfGuests);
      if (startDate) data.startDate = new Date(startDate);
      if (endDate) data.endDate = new Date(endDate);
      if (status) data.status = status as ReservationStatus;

      const reservation = await reservationService.updateReservation(
        parseInt(id),
        userId,
        data
      );

      res.status(200).json(reservation);
    } catch (error) {
      if (error instanceof Error) {
        if (error.message === 'Reservation not found') {
          res.status(404).json({ error: error.message });
          return;
        }
        if (error.message === 'You are not authorized to update this reservation') {
          res.status(403).json({ error: error.message });
          return;
        }
        res.status(400).json({ error: error.message });
      } else {
        res.status(500).json({ error: 'An unknown error occurred' });
      }
    }
  }

  // Update reservation status (for hosts/admins)
  async updateReservationStatus(req: Request, res: Response): Promise<void> {
    try {
      const { id } = req.params;
      const { status } = req.body;

      if (!status) {
        res.status(400).json({ error: 'Status is required' });
        return;
      }

      const reservation = await reservationService.updateReservationStatus(
        parseInt(id),
        status as ReservationStatus
      );

      res.status(200).json(reservation);
    } catch (error) {
      if (error instanceof Error) {
        res.status(400).json({ error: error.message });
      } else {
        res.status(500).json({ error: 'An unknown error occurred' });
      }
    }
  }

  // Delete a reservation
  async deleteReservation(req: Request, res: Response): Promise<void> {
    try {
      const { id } = req.params;
      const userId = (req as any).user.userId;

      const result = await reservationService.deleteReservation(
        parseInt(id),
        userId
      );

      res.status(200).json(result);
    } catch (error) {
      if (error instanceof Error) {
        if (error.message === 'Reservation not found') {
          res.status(404).json({ error: error.message });
          return;
        }
        if (error.message === 'You are not authorized to delete this reservation') {
          res.status(403).json({ error: error.message });
          return;
        }
        res.status(400).json({ error: error.message });
      } else {
        res.status(500).json({ error: 'An unknown error occurred' });
      }
    }
  }

  // Check availability
  async checkAvailability(req: Request, res: Response): Promise<void> {
    try {
      const { startDate, endDate, numberOfGuests } = req.query;

      if (!startDate || !endDate || !numberOfGuests) {
        res.status(400).json({
          error: 'startDate, endDate, and numberOfGuests are required',
        });
        return;
      }

      const availableTables = await reservationService.getAvailableTables({
        startDate: new Date(startDate as string),
        endDate: new Date(endDate as string),
        numberOfGuests: parseInt(numberOfGuests as string),
      });

      res.status(200).json({
        available: availableTables.length > 0,
        tables: availableTables,
      });
    } catch (error) {
      if (error instanceof Error) {
        res.status(500).json({ error: error.message });
      } else {
        res.status(500).json({ error: 'An unknown error occurred' });
      }
    }
  }

  // Get availability summary
  async getAvailabilitySummary(req: Request, res: Response): Promise<void> {
    try {
      const { startDate, endDate } = req.query;

      if (!startDate || !endDate) {
        res.status(400).json({
          error: 'startDate and endDate are required',
        });
        return;
      }

      const summary = await reservationService.getAvailabilitySummary(
        new Date(startDate as string),
        new Date(endDate as string)
      );

      res.status(200).json(summary);
    } catch (error) {
      if (error instanceof Error) {
        res.status(500).json({ error: error.message });
      } else {
        res.status(500).json({ error: 'An unknown error occurred' });
      }
    }
  }
}

export default new ReservationController();
