# Nadodi - Smart Travel Platform (Type‑2)

Nadodi is a Flutter-based travel app for Kerala (India) with AI features, map integration, and backend support.

## 🚀 Features

- AI Travel Assistant (chatbot)
- AI Trip Planner (itinerary generator)
- Smart location-based recommendations
- Map explorer with tourist spots, restaurants, hotels, and fuel stations
- Firebase Authentication (email/password)
- Backend API (Node.js + Express + MongoDB)
- Cloudinary image hosting
- Production-ready Android APK build setup

## 🗂️ Repository structure

- `lib/` — Flutter app code (screens, providers, services, models)
- `backend/` — Node.js REST API and data seed scripts
- `assets/` — sample images + data
- `.github/workflows/` — CI workflow to build Android APK

## 🛠️ Getting started

### 1) Backend setup

1. Copy `backend/.env.example` to `backend/.env` and fill in your credentials.
2. Install dependencies:

```bash
cd backend
npm install
```

3. Seed the database (requires MongoDB running):

```bash
npm run seed
```

4. Start the backend server:

```bash
npm run dev
```

### 2) Flutter app setup

1. Copy `.env.example` to `.env` at repo root and set `API_BASE_URL` to your backend endpoint (e.g. `http://localhost:5000/api`).
2. Install dependencies:

```bash
flutter pub get
```

3. Run the app:

```bash
flutter run
```

### 3) Build APK (locally)

```bash
flutter build apk --release
```

### 4) GitHub Actions

On push to `main`, the workflow will build a release APK and upload it as an artifact.

## ✅ Notes

- The app uses Firebase Auth for user accounts. Use a Firebase project and provide the service account JSON path in `backend/.env`.
- AI features use OpenAI APIs. Set `OPENAI_API_KEY` in both `.env` and `backend/.env`.

---

## Next steps

- Fill in rich datasets (400+ tourist places, 200+ hidden spots, etc.) via the seed script.
- Replace placeholder images with Cloudinary-hosted media.
- Customize UI themes and polish UX.
