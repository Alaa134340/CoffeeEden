@echo off
REM Coffee Shop Deployment Quick Start
REM This script helps you with the deployment setup

echo.
echo ========================================
echo   Coffee Shop Deployment Quick Start
echo ========================================
echo.

echo [Step 1] Push to GitHub
echo.
echo Your code is ready to push! Run these commands:
echo.
echo   git remote add origin https://github.com/YOUR_USERNAME/coffee-shop.git
echo   git branch -M main
echo   git push -u origin main
echo.
echo Note: Replace YOUR_USERNAME with your GitHub username
echo.

pause

cls

echo [Step 2] Set Up Database
echo.
echo Choose your database provider:
echo.
echo Option A: PlanetScale (Recommended, free)
echo   - Go to https://planetscale.com
echo   - Create account and new database
echo   - Get connection credentials
echo.
echo Option B: AWS RDS
echo   - Go to https://aws.amazon.com
echo   - Create MySQL database
echo   - Get connection credentials
echo.

pause

cls

echo [Step 3] Deploy Backend
echo.
echo 1. Go to https://render.com and sign in
echo 2. Click "Create New Service" and select "Web Service"
echo 3. Connect your GitHub repository
echo 4. Configuration:
echo    - Name: coffee-shop-backend
echo    - Environment: Node
echo    - Build Command: npm install
echo    - Start Command: npm start
echo.
echo 5. Add these Environment Variables:
echo    - PORT: 5000
echo    - NODE_ENV: production
echo    - DB_HOST: your_database_host
echo    - DB_USER: your_database_user
echo    - DB_PASSWORD: your_database_password
echo    - DB_NAME: coffeehaven
echo    - FRONTEND_URL: https://your-frontend-url.onrender.com
echo.

pause

cls

echo [Step 4] Deploy Frontend
echo.
echo 1. In Render, click "Create New Service" and select "Static Site"
echo 2. Connect same GitHub repository
echo 3. Configuration:
echo    - Name: coffee-shop-frontend
echo    - Build Command: cd frontend ^&^& npm run build
echo    - Publish Directory: frontend/build
echo.
echo 4. Add Environment Variable:
echo    - REACT_APP_API_URL: https://your-backend-url.onrender.com
echo.

pause

cls

echo [Step 5] Run Database Migrations
echo.
echo After backend deploys, run the SQL script:
echo.
echo   mysql --host=your_host --user=your_user --password ^< backend/sql/create_tables.sql
echo.
echo Or use your database manager to run backend/sql/create_tables.sql
echo.

pause

cls

echo [Step 6] Test Your Deployment
echo.
echo 1. Visit your frontend URL
echo 2. Check browser console for errors (F12)
echo 3. Test login/signup functionality
echo 4. Verify images load correctly
echo.

pause

cls

echo ========================================
echo   Deployment Setup Complete!
echo ========================================
echo.
echo For detailed instructions, see: DEPLOYMENT_GUIDE.md
echo.

pause
