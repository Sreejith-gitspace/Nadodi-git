import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import mongoose from 'mongoose';
import path from 'path';
import { fileURLToPath } from 'url';

import authRoutes from './routes/auth.routes.js';
import placeRoutes from './routes/place.routes.js';
import hiddenRoutes from './routes/hidden.routes.js';
import restaurantRoutes from './routes/restaurant.routes.js';
import hotelRoutes from './routes/hotel.routes.js';
import aiRoutes from './routes/ai.routes.js';
import userRoutes from './routes/user.routes.js';
import { verifyFirebaseToken } from './middlewares/auth.middleware.js';

dotenv.config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

app.use(cors());
app.use(express.json({ limit: '4mb' }));
app.use(express.urlencoded({ extended: true }));

app.get('/', (req, res) => {
  res.json({ status: 'ok', version: '2.0', message: 'Nadodi backend is running' });
});

app.use('/api/auth', authRoutes);
app.use('/api/places', placeRoutes);
app.use('/api/hidden-spots', hiddenRoutes);
app.use('/api/restaurants', restaurantRoutes);
app.use('/api/hotels', hotelRoutes);
app.use('/api/ai', aiRoutes);
app.use('/api/users', verifyFirebaseToken, userRoutes);

const PORT = process.env.PORT || 5000;

async function start() {
  try {
    if (!process.env.MONGO_URI) {
      throw new Error('MONGO_URI is not configured');
    }

    await mongoose.connect(process.env.MONGO_URI, {
      serverSelectionTimeoutMS: 5000,
    });

    console.log('MongoDB connected');

    app.listen(PORT, () => {
      console.log(`Nadodi backend listening on port ${PORT}`);
    });
  } catch (error) {
    console.error('Unable to start server', error);
    process.exit(1);
  }
}

start();
