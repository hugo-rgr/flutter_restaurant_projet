import express, { Request, Response } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import authRoutes from './routes/auth.routes';
import reservationRoutes from './routes/reservation.routes';
import tableRoutes from './routes/table.routes';

dotenv.config();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Health check route
app.get('/', (req: Request, res: Response) => {
  res.json({
    message: 'Restaurant Reservation API',
    version: '1.0.0',
    endpoints: {
      auth: '/auth',
      reservations: '/reservations',
      tables: '/tables',
    },
  });
});

// Routes
app.use('/auth', authRoutes);
app.use('/reservations', reservationRoutes);
app.use('/tables', tableRoutes);

// 404 handler
app.use((req: Request, res: Response) => {
  res.status(404).json({ error: 'Route not found' });
});

const PORT = process.env.PORT ?? 3000;

app.listen(PORT, async () => {
  console.log(`✅ Server is running on port ${PORT}`);
  console.log(`📝 API Documentation available at http://localhost:${PORT}/`);
});
