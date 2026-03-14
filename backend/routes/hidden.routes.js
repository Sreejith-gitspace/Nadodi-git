import express from 'express';
import { getHiddenSpots } from '../controllers/place.controller.js';

const router = express.Router();

// GET /api/hidden-spots
router.get('/', getHiddenSpots);

export default router;
