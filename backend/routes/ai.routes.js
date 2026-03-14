import express from 'express';
import { createTripPlan, chatAi } from '../controllers/ai.controller.js';

const router = express.Router();

// POST /api/ai/trip-plan
router.post('/trip-plan', createTripPlan);

// POST /api/ai/chat
router.post('/chat', chatAi);

export default router;
