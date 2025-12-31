# Deployment Checklist ✅

## Pre-Deployment (✅ DONE)
- [x] Environment files created (.env, .env.production)
- [x] Backend Server.js updated for production
- [x] CORS configured for frontend URLs
- [x] Backend package.json configured
- [x] Frontend package.json configured
- [x] .gitignore files set up
- [x] render.yaml configuration created
- [x] Code committed to Git

## Deployment Steps (TODO)

### 1. Push to GitHub
- [ ] Create GitHub repository (https://github.com/new)
- [ ] Add remote: `git remote add origin https://github.com/YOUR_USERNAME/coffee-shop.git`
- [ ] Push code: `git push -u origin main`
- [ ] Verify on GitHub

### 2. Set Up Database
- [ ] Choose database provider:
  - [ ] Option A: PlanetScale (https://planetscale.com) - Recommended
  - [ ] Option B: AWS RDS (https://aws.amazon.com)
  - [ ] Option C: Local MySQL (not recommended for production)
- [ ] Create database named `coffeehaven`
- [ ] Save connection credentials:
  - [ ] Host: ________________
  - [ ] User: ________________
  - [ ] Password: ________________

### 3. Deploy Backend to Render
- [ ] Create Render account (https://render.com)
- [ ] Create new Web Service
- [ ] Connect GitHub repository
- [ ] Name: `coffee-shop-backend`
- [ ] Environment: Node
- [ ] Build Command: `npm install`
- [ ] Start Command: `npm start`
- [ ] Add environment variables:
  - [ ] PORT: 5000
  - [ ] NODE_ENV: production
  - [ ] DB_HOST: ________________
  - [ ] DB_USER: ________________
  - [ ] DB_PASSWORD: ________________
  - [ ] DB_NAME: coffeehaven
  - [ ] FRONTEND_URL: ________________
- [ ] Deploy and wait for success
- [ ] Backend URL: https://________________.onrender.com

### 4. Deploy Frontend to Render
- [ ] Create new Static Site
- [ ] Connect same GitHub repository
- [ ] Name: `coffee-shop-frontend`
- [ ] Build Command: `cd frontend && npm run build`
- [ ] Publish Directory: `frontend/build`
- [ ] Add environment variable:
  - [ ] REACT_APP_API_URL: https://________________.onrender.com
- [ ] Deploy and wait for success
- [ ] Frontend URL: https://________________.onrender.com

### 5. Run Database Migrations
- [ ] Connect to MySQL database
- [ ] Run SQL script: `backend/sql/create_tables.sql`
- [ ] Verify tables created:
  - [ ] users
  - [ ] menu
  - [ ] orders
  - [ ] events
  - [ ] event_signups

### 6. Post-Deployment Testing
- [ ] Open frontend URL in browser
- [ ] Test home page loads
- [ ] Test menu page (should load from API)
- [ ] Test signup (should create user in database)
- [ ] Test login (should authenticate user)
- [ ] Test adding items (admin only)
- [ ] Check browser console for errors (F12)
- [ ] Test on mobile device

## Environment Variables Reference

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

## Troubleshooting

### Backend won't start
- Check all environment variables are set
- Check database credentials are correct
- View Render logs for detailed errors

### CORS errors
- Verify FRONTEND_URL matches your actual frontend URL
- Clear browser cache and hard refresh (Ctrl+Shift+R)

### Database connection fails
- Verify database host allows remote connections
- Check credentials are correct
- Ensure database exists

### Images/uploads not loading
- File uploads are temporary on Render
- Consider AWS S3 or similar for production
- For now, ensure images load from uploads folder

## Optional: Custom Domain
- [ ] Buy domain (Namecheap, GoDaddy, etc.)
- [ ] Update Render custom domain settings
- [ ] Point DNS to Render nameservers

## Important Notes
⚠️ Free tier limitations on Render:
- Services spin down after 15 minutes of inactivity
- Limited build minutes per month
- Consider upgrading for production use

💾 Database:
- Use PlanetScale free tier (good for testing)
- AWS RDS free tier (good for learning)
- Plan migration to paid tier for production

📁 File Uploads:
- Render uses ephemeral file system (temp files deleted on redeploy)
- Use AWS S3 or Cloudinary for persistent storage
- Update Server.js multer storage configuration

---

Good luck with your deployment! 🚀
