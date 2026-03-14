import mongoose from 'mongoose';

const userSchema = new mongoose.Schema(
  {
    uid: { type: String, required: true, unique: true },
    email: { type: String },
    name: { type: String },
    photoUrl: { type: String },
    savedPlaces: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Place' }],
    createdAt: { type: Date, default: Date.now },
  },
  { timestamps: true }
);

export default mongoose.model('User', userSchema);
