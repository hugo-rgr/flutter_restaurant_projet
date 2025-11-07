import { Router } from 'express';
import tableController from '../controllers/table.controller';
import { authMiddleware } from '../middlewares/auth.middleware';
import { roleMiddleware } from '../middlewares/roles.middleware';

const router = Router();

/**
 * @swagger
 * tags:
 *   name: Tables
 *   description: Gestion des tables du restaurant
 */

/**
 * @swagger
 * /tables:
 *   get:
 *     summary: Obtenir toutes les tables
 *     tags: [Tables]
 *     responses:
 *       200:
 *         description: Liste des tables
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Table'
 */
router.get('/', tableController.getAllTables);

/**
 * @swagger
 * /tables/available:
 *   get:
 *     summary: Obtenir les tables disponibles
 *     tags: [Tables]
 *     responses:
 *       200:
 *         description: Liste des tables disponibles
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Table'
 */
router.get('/available', tableController.getAvailableTables);

/**
 * @swagger
 * /tables/{id}:
 *   get:
 *     summary: Obtenir une table par ID
 *     tags: [Tables]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: ID de la table
 *     responses:
 *       200:
 *         description: Table trouvée
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Table'
 *       404:
 *         description: Table non trouvée
 */
router.get('/:id', tableController.getTableById);

// All routes below require authentication
router.use(authMiddleware);

/**
 * @swagger
 * /tables/{id}/statistics:
 *   get:
 *     summary: Obtenir les statistiques d'une table (hôte/admin)
 *     tags: [Tables]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: ID de la table
 *     responses:
 *       200:
 *         description: Statistiques de la table
 *       401:
 *         description: Non authentifié
 *       403:
 *         description: Accès refusé - Rôle requis (hôte ou admin)
 *       404:
 *         description: Table non trouvée
 */
router.get(
  '/:id/statistics',
  roleMiddleware(['hote', 'admin']),
  tableController.getTableStatistics
);

/**
 * @swagger
 * /tables:
 *   post:
 *     summary: Créer une nouvelle table (hôte/admin)
 *     tags: [Tables]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - tableNumber
 *               - capacity
 *             properties:
 *               tableNumber:
 *                 type: integer
 *                 description: Numéro de la table
 *               capacity:
 *                 type: integer
 *                 description: Capacité de la table
 *               location:
 *                 type: string
 *                 description: Emplacement de la table
 *               isAvailable:
 *                 type: boolean
 *                 description: Disponibilité de la table
 *     responses:
 *       201:
 *         description: Table créée avec succès
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Table'
 *       400:
 *         description: Données invalides
 *       401:
 *         description: Non authentifié
 *       403:
 *         description: Accès refusé - Rôle requis (hôte ou admin)
 */
router.post(
  '/',
  roleMiddleware(['hote', 'admin']),
  tableController.createTable
);

/**
 * @swagger
 * /tables/{id}:
 *   put:
 *     summary: Mettre à jour une table (hôte/admin)
 *     tags: [Tables]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: ID de la table
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               tableNumber:
 *                 type: integer
 *               capacity:
 *                 type: integer
 *               location:
 *                 type: string
 *               isAvailable:
 *                 type: boolean
 *     responses:
 *       200:
 *         description: Table mise à jour
 *       401:
 *         description: Non authentifié
 *       403:
 *         description: Accès refusé - Rôle requis (hôte ou admin)
 *       404:
 *         description: Table non trouvée
 */
router.put(
  '/:id',
  roleMiddleware(['hote', 'admin']),
  tableController.updateTable
);

/**
 * @swagger
 * /tables/{id}:
 *   delete:
 *     summary: Supprimer une table (admin uniquement)
 *     tags: [Tables]
 *     security:
 *       - bearerAuth: []
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: string
 *         description: ID de la table
 *     responses:
 *       200:
 *         description: Table supprimée
 *       401:
 *         description: Non authentifié
 *       403:
 *         description: Accès refusé - Admin uniquement
 *       404:
 *         description: Table non trouvée
 */
router.delete(
  '/:id',
  roleMiddleware(['admin']),
  tableController.deleteTable
);

export default router;
