import mongoose from 'mongoose';
import dotenv from 'dotenv';
import Place from '../models/place.model.js';

dotenv.config();

const districts = [
  'Thiruvananthapuram',
  'Kollam',
  'Pathanamthitta',
  'Alappuzha',
  'Kottayam',
  'Idukki',
  'Ernakulam',
  'Thrissur',
  'Palakkad',
  'Malappuram',
  'Kozhikode',
  'Wayanad',
  'Kannur',
  'Kasaragod',
];

const imageSamples = [
  'https://images.unsplash.com/photo-1526772662000-3f88f10405ff?auto=format&fit=crop&w=1000&q=80',
  'https://images.unsplash.com/photo-1507537297725-24a1c029d3ca?auto=format&fit=crop&w=1000&q=80',
  'https://images.unsplash.com/photo-1526481280698-2e1a3e1ea8c6?auto=format&fit=crop&w=1000&q=80',
  'https://images.unsplash.com/photo-1513938709626-033611b8cc03?auto=format&fit=crop&w=1000&q=80',
];

function randomBetween(min, max) {
  return min + Math.random() * (max - min);
}

function pickRandom<T>(items) {
  return items[Math.floor(Math.random() * items.length)];
}

function createPlace(index, category) {
  const district = pickRandom(districts);
  const lat = randomBetween(8.0, 12.5);
  const lng = randomBetween(74.5, 77.5);

  return {
    name: `${category.charAt(0).toUpperCase() + category.slice(1)} ${index}`,
    description: `A beautiful ${category} located in ${district}. Perfect for travelers looking for authentic experiences in Kerala.`,
    district,
    latitude: lat,
    longitude: lng,
    imageUrl: pickRandom(imageSamples),
    tags: ['nature', 'culture', 'photography'],
    isHidden: category === 'place' && index % 7 === 0,
    category,
  };
}

async function run() {
  if (!process.env.MONGO_URI) {
    throw new Error('MONGO_URI is not set');
  }

  await mongoose.connect(process.env.MONGO_URI, {
    serverSelectionTimeoutMS: 5000,
  });

  console.log('Connected to Mongo');

  await Place.deleteMany({});

  const places = Array.from({ length: 400 }, (_, idx) => createPlace(idx + 1, 'place'));
  const hiddenSpots = Array.from({ length: 200 }, (_, idx) => {
    const spot = createPlace(idx + 1, 'place');
    spot.isHidden = true;
    spot.name = `Hidden Spot ${idx + 1}`;
    return spot;
  });
  const restaurants = Array.from({ length: 300 }, (_, idx) => createPlace(idx + 1, 'restaurant'));
  const hotels = Array.from({ length: 250 }, (_, idx) => createPlace(idx + 1, 'hotel'));

  const all = [...places, ...hiddenSpots, ...restaurants, ...hotels];
  await Place.insertMany(all);

  console.log('Seeded database with:', {
    places: places.length,
    hiddenSpots: hiddenSpots.length,
    restaurants: restaurants.length,
    hotels: hotels.length,
  });

  await mongoose.disconnect();
  console.log('Disconnected');
}

run().catch((err) => {
  console.error(err);
  process.exit(1);
});
