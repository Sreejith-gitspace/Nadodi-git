import express from 'express';
import { getPlaces } from '../controllers/place.controller.js';

const router = express.Router();

// GET /api/places
router.get('/', getPlaces);

export default router;
