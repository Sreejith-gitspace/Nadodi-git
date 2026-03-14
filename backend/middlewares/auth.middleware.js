import admin from 'firebase-admin';
import dotenv from 'dotenv';

dotenv.config();

let firebaseInitialized = false;

function initializeFirebase() {
  if (firebaseInitialized) return;

  const serviceAccountPath = process.env.FIREBASE_SERVICE_ACCOUNT;
  if (!serviceAccountPath) {
    throw new Error('FIREBASE_SERVICE_ACCOUNT is not set in environment');
  }

  admin.initializeApp({
    credential: admin.credential.cert(serviceAccountPath),
  });
  firebaseInitialized = true;
}

export async function verifyFirebaseToken(req, res, next) {
  try {
    const authHeader = req.headers.authorization;
    if (!authHeader || !authHeader.startsWith('Bearer ')) {
      return res.status(401).json({ message: 'Missing auth token' });
    }

    const token = authHeader.split(' ')[1];
    initializeFirebase();

    const decoded = await admin.auth().verifyIdToken(token);
    req.user = decoded;
    next();
  } catch (error) {
    res.status(401).json({ message: 'Unauthorized', error: error?.message || error });
  }
}
