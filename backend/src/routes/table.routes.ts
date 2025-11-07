import { Router } from 'express';
import tableController from '../controllers/table.controller';
import { authMiddleware } from '../middlewares/auth.middleware';
import { roleMiddleware } from '../middlewares/roles.middleware';

const router = Router();

// GET /tables - Get all tables (public or authenticated)
router.get('/', tableController.getAllTables);

//GET /tables/available - Get available tables (public or authenticated)
router.get('/available', tableController.getAvailableTables);

// GET /tables/:id - Get a single table (public or authenticated)
router.get('/:id', tableController.getTableById);

// All routes below require authentication
router.use(authMiddleware);

// GET /tables/:id/statistics - Get table statistics (hote/admin only)
router.get(
  '/:id/statistics',
  roleMiddleware(['hote', 'admin']),
  tableController.getTableStatistics
);

// POST /tables - Create a new table (hote/admin only)
router.post(
  '/',
  roleMiddleware(['hote', 'admin']),
  tableController.createTable
);

// PUT /tables/:id - Update a table (hote/admin only)
router.put(
  '/:id',
  roleMiddleware(['hote', 'admin']),
  tableController.updateTable
);

// DELETE /tables/:id - Delete a table (admin only)
router.delete(
  '/:id',
  roleMiddleware(['admin']),
  tableController.deleteTable
);

export default router;
