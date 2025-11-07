import express, { Request, Response } from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import swaggerUi from 'swagger-ui-express';
import authRoutes from './routes/auth.routes';
import reservationRoutes from './routes/reservation.routes';
import tableRoutes from './routes/table.routes';
import { swaggerSpec } from './config/swagger';

dotenv.config();

const app = express();

// Middleware
app.use(cors());
app.use(express.json());

// Swagger Documentation
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec, {
  customCss: '.swagger-ui .topbar { display: none }',
  customSiteTitle: 'Restaurant API Documentation',
}));

// Swagger JSON endpoint
app.get('/api-docs.json', (req: Request, res: Response) => {
  res.setHeader('Content-Type', 'application/json');
  res.send(swaggerSpec);
});

// Health check route
app.get('/', (req: Request, res: Response) => {
  res.json({
    message: 'Restaurant Reservation API',
    version: '1.0.0',
    documentation: '/api-docs',
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
  console.log(`📝 API Documentation available at http://localhost:${PORT}/api-docs`);
  console.log(`📄 Swagger JSON available at http://localhost:${PORT}/api-docs.json`);
});
