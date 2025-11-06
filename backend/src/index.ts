import express, { Request, Response } from 'express';

import cors from 'cors';
import dotenv from 'dotenv';
//import authRoutes from './routes/auth.routes';
//import userRoutes from './routes/user.routes';
//import userListRoutes from './routes/user-lists.routes';

dotenv.config();

const app = express();

app.use(cors());
app.use(express.json());

// Routes
//app.use('/auth', authRoutes);
//app.use('/list', userListRoutes);
//app.use('/info', userRoutes);

const PORT = process.env.PORT ?? 3000;

app.listen(PORT, async () => {
    console.log(`Server is running on port ${PORT}`);
});
