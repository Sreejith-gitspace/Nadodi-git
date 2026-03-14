import express from 'express';
import { getHotels } from '../controllers/place.controller.js';

const router = express.Router();

// GET /api/hotels
router.get('/', getHotels);

export default router;
