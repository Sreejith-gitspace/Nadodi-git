import Place from '../models/place.model.js';

export async function getPlaces(req, res) {
  try {
    const { district, hidden } = req.query;
    const filter = { category: 'place' };

    if (district) filter.district = { $regex: new RegExp(district, 'i') };
    if (hidden === 'true') filter.isHidden = true;

    const items = await Place.find(filter).limit(500);
    res.json({ data: items, count: items.length });
  } catch (error) {
    res.status(500).json({ message: 'Unable to load places', error: error?.message || error });
  }
}

export async function getHiddenSpots(req, res) {
  try {
    const { district } = req.query;
    const filter = { category: 'place', isHidden: true };
    if (district) filter.district = { $regex: new RegExp(district, 'i') };

    const items = await Place.find(filter).limit(500);
    res.json({ data: items, count: items.length });
  } catch (error) {
    res.status(500).json({ message: 'Unable to load hidden spots', error: error?.message || error });
  }
}

export async function getRestaurants(req, res) {
  try {
    const { district } = req.query;
    const filter = { category: 'restaurant' };
    if (district) filter.district = { $regex: new RegExp(district, 'i') };

    const items = await Place.find(filter).limit(500);
    res.json({ data: items, count: items.length });
  } catch (error) {
    res.status(500).json({ message: 'Unable to load restaurants', error: error?.message || error });
  }
}

export async function getHotels(req, res) {
  try {
    const { district } = req.query;
    const filter = { category: 'hotel' };
    if (district) filter.district = { $regex: new RegExp(district, 'i') };

    const items = await Place.find(filter).limit(500);
    res.json({ data: items, count: items.length });
  } catch (error) {
    res.status(500).json({ message: 'Unable to load hotels', error: error?.message || error });
  }
}
