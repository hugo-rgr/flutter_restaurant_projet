import { Router } from 'express';
import reservationController from '../controllers/reservation.controller';
import { authMiddleware } from '../middlewares/auth.middleware';
import { roleMiddleware } from '../middlewares/roles.middleware';

const router = Router();

/**
 * @swagger
 * tags:
 *   name: Reservations
 *   description: Gestion des réservations de restaurant
 */

// All routes require authentication
router.use(authMiddleware);

/**
 * @swagger
 * /reservations/availability:
 *   get:
 *     summary: Vérifier la disponibilité pour une réservation
 *     tags: [Reservations]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: query
 *         name: date
 *         required: true
 *         schema:
 *           type: string
 *           format: date-time
 *         description: Date et heure de la réservation
 *       - in: query
 *         name: numberOfGuests
 *         required: true
 *         schema:
 *           type: integer
 *         description: Nombre de personnes
 *     responses:
 *       200:
 *         description: Disponibilité trouvée
 *       401:
 *         description: Non authentifié
 */
router.get('/availability', reservationController.checkAvailability);

/**
 * @swagger
 * /reservations/availability-summary:
 *   get:
 *     summary: Obtenir un résumé de disponibilité
 *     tags: [Reservations]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Résumé de disponibilité
 *       401:
 *         description: Non authentifié
 */
router.get('/availability-summary', reservationController.getAvailabilitySummary);

/**
 * @swagger
 * /reservations:
 *   post:
 *     summary: Créer une nouvelle réservation
 *     tags: [Reservations]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - tableId
 *               - date
 *               - numberOfGuests
 *             properties:
 *               tableId:
 *                 type: string
 *                 description: ID de la table
 *               date:
 *                 type: string
 *                 format: date-time
 *                 description: Date et heure de la réservation
 *               numberOfGuests:
 *                 type: integer
 *                 minimum: 1
 *                 description: Nombre de personnes
 *               specialRequests:
 *                 type: string
 *                 description: Demandes spéciales
 *     responses:
 *       201:
 *         description: Réservation créée avec succès
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Reservation'
 *       400:
 *         description: Données invalides
 *       401:
 *         description: Non authentifié
 */
router.post('/', reservationController.createReservation);

/**
 * @swagger
 * /reservations:
 *   get:
 *     summary: Obtenir toutes les réservations de l'utilisateur connecté
 *     tags: [Reservations]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Liste des réservations
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Reservation'
 *       401:
 *         description: Non authentifié
 */
router.get('/', reservationController.getAllReservations);

/**
 * @swagger
 * /reservations/all:
 *   get:
 *     summary: Obtenir toutes les réservations à gérer (hôte/admin)
 *     tags: [Reservations]
 *     security:
 *       - bearerAuth: []
 *     responses:
 *       200:
 *         description: Liste de toutes les réservations
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Reservation'
 *       401:
 *         description: Non authentifié
 *       403:
 *         description: Accès refusé - Rôle requis (hôte ou admin)
 */
router.get('/all', roleMiddleware(['hote', 'admin']),reservationController.getAllReservationToManage);

/**
 * @swagger
 * /reservations/{id}:
 *   get:
 *     summary: Obtenir une réservation par ID
 *     tags: [Reservations]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: ID de la réservation
 *     responses:
 *       200:
 *         description: Réservation trouvée
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Reservation'
 *       401:
 *         description: Non authentifié
 *       404:
 *         description: Réservation non trouvée
 */
router.get('/:id', reservationController.getReservationById);

/**
 * @swagger
 * /reservations/{id}:
 *   put:
 *     summary: Mettre à jour une réservation (propriétaire uniquement)
 *     tags: [Reservations]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: ID de la réservation
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               tableId:
 *                 type: string
 *               date:
 *                 type: string
 *                 format: date-time
 *               numberOfGuests:
 *                 type: integer
 *               specialRequests:
 *                 type: string
 *     responses:
 *       200:
 *         description: Réservation mise à jour
 *       401:
 *         description: Non authentifié
 *       403:
 *         description: Accès refusé
 *       404:
 *         description: Réservation non trouvée
 */
router.put('/:id', reservationController.updateReservation);

/**
 * @swagger
 * /reservations/{id}/status:
 *   patch:
 *     summary: Mettre à jour le statut d'une réservation (hôte/admin)
 *     tags: [Reservations]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: ID de la réservation
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - status
 *             properties:
 *               status:
 *                 type: string
 *                 enum: [pending, confirmed, cancelled, completed]
 *                 description: Nouveau statut de la réservation
 *     responses:
 *       200:
 *         description: Statut mis à jour
 *       401:
 *         description: Non authentifié
 *       403:
 *         description: Accès refusé - Rôle requis (hôte ou admin)
 *       404:
 *         description: Réservation non trouvée
 */
router.patch(
  '/:id/status',
  roleMiddleware(['hote', 'admin']),
  reservationController.updateReservationStatus
);

/**
 * @swagger
 * /reservations/{id}:
 *   delete:
 *     summary: Supprimer une réservation (propriétaire uniquement)
 *     tags: [Reservations]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: ID de la réservation
 *     responses:
 *       200:
 *         description: Réservation supprimée
 *       401:
 *         description: Non authentifié
 *       403:
 *         description: Accès refusé
 *       404:
 *         description: Réservation non trouvée
 */
router.delete('/:id', reservationController.deleteReservation);

export default router;
