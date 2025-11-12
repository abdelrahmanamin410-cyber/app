
# Academy Backend (Node.js + Express + MySQL)

Setup:
1. Copy .env.example -> .env and fill values.
2. Run `npm install`.
3. Ensure MySQL is running and run `node_modules/.bin/sequelize db:migrate` OR run schema.sql manually:
   mysql -u root -p < schema.sql
4. Start server: `npm start` (or `npm run dev` with nodemon)

Notes:
- Uses JWT for auth. Mobile app expects endpoints:
  POST /api/auth/register  {name,email,password}
  POST /api/auth/login     {email,password} -> returns {token}
