import mongoose from 'mongoose';

const placeSchema = new mongoose.Schema(
  {
    name: { type: String, required: true },
    description: { type: String, default: '' },
    district: { type: String, required: true },
    latitude: { type: Number, required: true },
    longitude: { type: Number, required: true },
    imageUrl: { type: String, default: '' },
    tags: { type: [String], default: [] },
    isHidden: { type: Boolean, default: false },
    category: { type: String, default: 'place' },
  },
  { timestamps: true }
);

export default mongoose.model('Place', placeSchema);
