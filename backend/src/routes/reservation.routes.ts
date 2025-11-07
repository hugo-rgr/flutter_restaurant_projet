import { Router } from 'express';
import reservationController from '../controllers/reservation.controller';
import { authMiddleware } from '../middlewares/auth.middleware';
import { roleMiddleware } from '../middlewares/roles.middleware';

const router = Router();

// All routes require authentication
router.use(authMiddleware);

// GET /reservations/availability - Check availability
router.get('/availability', reservationController.checkAvailability);

// GET /reservations/availability-summary - Get availability summary
router.get('/availability-summary', reservationController.getAvailabilitySummary);

// POST /reservations - Create a new reservation (authenticated users)
router.post('/', reservationController.createReservation);

// GET /reservations - Get all reservations
router.get('/', reservationController.getAllReservations);

router.get('/all', roleMiddleware(['hote', 'admin']),reservationController.getAllReservationToManage);

// GET /reservations/:id - Get a single reservation
router.get('/:id', reservationController.getReservationById);

// PUT /reservations/:id - Update a reservation (owner only)
router.put('/:id', reservationController.updateReservation);

// PATCH /reservations/:id/status - Update reservation status (hote/admin only)
router.patch(
  '/:id/status',
  roleMiddleware(['hote', 'admin']),
  reservationController.updateReservationStatus
);

// DELETE /reservations/:id - Delete a reservation (owner only)
router.delete('/:id', reservationController.deleteReservation);

export default router;
