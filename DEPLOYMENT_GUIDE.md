# Coffee Shop - Full Stack Deployment Guide

## 🚀 Deployment to Render

This guide will help you deploy your full-stack Coffee Shop application to Render.

### Prerequisites
- GitHub account
- Render account (free at render.com)
- Your code pushed to GitHub
- MySQL database credentials

---

## 📋 Step 1: Prepare Your Project

### ✅ Already Done
- ✓ Environment files created (.env, .env.production)
- ✓ Production settings configured in Server.js
- ✓ CORS configured for production
- ✓ Backend package.json configured with start script
- ✓ Frontend package.json configured for production build

---

## 📦 Step 2: Push to GitHub

1. **Initialize Git (if not already done)**
   ```bash
   cd c:\Users\issam\Desktop\Coffee_Shopfrontend
   git init
   git add .
   git commit -m "Initial commit: Coffee Shop full-stack app"
   ```

2. **Create a repository on GitHub** (https://github.com/new)
   - Name: `coffee-shop` (or your preferred name)
   - Make it Public
   - Do NOT initialize with README (you already have one)

3. **Push to GitHub**
   ```bash
   git remote add origin https://github.com/YOUR_USERNAME/coffee-shop.git
   git branch -M main
   git push -u origin main
   ```

---

## 🗄️ Step 3: Set Up MySQL Database

### Option A: Use PlanetScale (Recommended - MySQL-compatible)
1. Go to https://planetscale.com
2. Sign up for free account
3. Create a new database
4. Get your credentials from "Connect" button
5. Save your connection string:
   ```
   mysql://username:password@aws.connect.psdb.cloud:3306/coffeehaven
   ```

### Option B: Use AWS RDS
1. Go to AWS console
2. Create MySQL RDS instance (free tier available)
3. Get connection details

### Option C: Stick with Local MySQL
- Keep your local database running
- Note: Not recommended for production

---

## 🎯 Step 4: Deploy Backend to Render

1. **Go to https://render.com** and sign in
2. **Create New Service → Web Service**
3. **Connect your GitHub repository**
4. **Configure the backend service:**
   - Name: `coffee-shop-backend`
   - Environment: `Node`
   - Build Command: `npm install`
   - Start Command: `npm start`
   - Plan: `Free` (or paid if you want better performance)

5. **Add Environment Variables** (in Render dashboard):
   ```
   PORT = 5000
   NODE_ENV = production
   DB_HOST = your_database_host (from PlanetScale/RDS)
   DB_USER = your_database_user
   DB_PASSWORD = your_database_password
   DB_NAME = coffeehaven
   FRONTEND_URL = https://your-frontend-url.onrender.com
   ```

6. **Deploy** - Click "Create Web Service"

---

## 📄 Step 5: Deploy Frontend to Render

1. **Go to Render → Create New Service → Static Site**
2. **Connect same GitHub repository**
3. **Configure the frontend service:**
   - Name: `coffee-shop-frontend`
   - Build Command: `cd frontend && npm run build`
   - Publish Directory: `frontend/build`
   - Plan: `Free`

4. **Add Environment Variables:**
   ```
   REACT_APP_API_URL = https://your-backend-url.onrender.com
   ```

5. **Deploy** - Click "Create Static Site"

---

## 🔧 Step 6: Database Setup

1. **After backend deployment**, you need to run the SQL migrations
2. **Connect to your database** using your credentials
3. **Run the SQL script** from `backend/sql/create_tables.sql`

### Using Command Line (if using PlanetScale):
```bash
mysql --host=your_host --user=your_user --password=your_password < backend/sql/create_tables.sql
```

---

## ✅ Step 7: Verify Deployment

1. **Frontend URL:** `https://your-frontend.onrender.com`
2. **Backend API:** `https://your-backend.onrender.com/api/menu`
3. Check browser console for any CORS errors
4. Test login/signup functionality

---

## 🔒 Environment Variables Summary

### Backend (.env)
```
DB_HOST=your_database_host
DB_USER=your_database_user
DB_PASSWORD=your_database_password
DB_NAME=coffeehaven
PORT=5000
NODE_ENV=production
FRONTEND_URL=https://your-frontend.onrender.com
```

### Frontend (.env.production)
```
REACT_APP_API_URL=https://your-backend.onrender.com
```

---

## 🐛 Troubleshooting

### Backend won't connect to database
- Check credentials in Render environment variables
- Verify database is created
- Check if database host allows remote connections

### CORS errors in frontend
- Check FRONTEND_URL in backend environment variables
- Ensure it matches your actual frontend URL
- Clear browser cache

### Uploads not working
- Render's ephemeral file system deletes files on redeploy
- Consider using AWS S3 or similar for file storage

---

## 📝 Next Steps

1. ✅ Push code to GitHub
2. ✅ Set up database (PlanetScale or RDS)
3. ✅ Deploy backend to Render
4. ✅ Deploy frontend to Render
5. ✅ Run database migrations
6. ✅ Test the application
7. Consider adding S3 for file uploads
8. Set up custom domain (optional)

---

## 💡 Important Notes

- **Free tier on Render**: Services spin down after 15 minutes of inactivity
- **Database**: You'll need a paid MySQL host (PlanetScale free tier is good)
- **Files**: Uploaded files are temporary on Render - use cloud storage for production
- **SSL**: Render provides free SSL certificates

Good luck! 🎉
