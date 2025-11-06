import { Router } from 'express';
import authController from '../controllers/auth.controller';

const router = Router();

// POST /auth/register - Register a new user
router.post('/register', authController.register);

// POST /auth/login - Login user
router.post('/login', authController.login);

// GET /auth/verify - Verify token
router.get('/verify', authController.verifyToken);

export default router;
