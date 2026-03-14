import express from 'express';
import User from '../models/user.model.js';
import Place from '../models/place.model.js';

const router = express.Router();

// GET /api/users/me
router.get('/me', async (req, res) => {
  try {
    const uid = req.user?.uid;
    if (!uid) {
      return res.status(400).json({ message: 'Missing user UID in token' });
    }

    let user = await User.findOne({ uid }).populate('savedPlaces');
    if (!user) {
      user = await User.create({ uid });
    }

    res.json({ data: user });
  } catch (error) {
    res.status(500).json({ message: 'Unable to fetch user', error: error?.message || error });
  }
});

// POST /api/users/save-place
router.post('/save-place', async (req, res) => {
  try {
    const uid = req.user?.uid;
    const { placeId } = req.body;
    if (!uid || !placeId) return res.status(400).json({ message: 'Missing required fields' });

    const place = await Place.findById(placeId);
    if (!place) return res.status(404).json({ message: 'Place not found' });

    let user = await User.findOne({ uid });
    if (!user) user = await User.create({ uid });

    if (!user.savedPlaces.includes(place._id)) {
      user.savedPlaces.push(place._id);
      await user.save();
    }

    res.json({ data: user });
  } catch (error) {
    res.status(500).json({ message: 'Unable to save place', error: error?.message || error });
  }
});

export default router;
