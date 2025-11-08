
Academy Mobile App - Fullstack Scaffold

This archive contains:
- frontend/  -> Flutter mobile app
- backend/   -> Node.js Express server with MySQL auth

To run locally (Android emulator):
1. Start MySQL and create a database using backend/schema.sql.
2. Configure backend/.env with DB credentials and JWT_SECRET.
3. In backend/: npm install && npm start
4. In frontend/: flutter pub get && flutter run (use emulator; API points to 10.0.2.2:3000)

Important:
- The mobile app expects backend at http://10.0.2.2:3000 for Android emulator.
- For real devices, use your machine IP and adjust CORS/.env accordingly.
