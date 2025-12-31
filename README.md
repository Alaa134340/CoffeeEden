# Coffee Shop Management System

A full-stack web application for managing a coffee shop, including user authentication, menu management, orders, and event signups.

## Features

### User Features
- **User Authentication**: Sign up and sign in with secure password handling
- **Order Management**: Browse menu items and place orders
- **Order History**: View your past orders
- **Event Signup**: Sign up for coffee shop events

### Admin Features
- **Menu Management**: Add, edit, and delete menu items with images
- **Event Management**: Create and manage events with images
- **Order Management**: View and delete all customer orders
- **Event Signups**: View all user event signups

## Tech Stack

### Frontend
- **React** - UI library
- **React Router** - Client-side routing
- **Bootstrap** - Styling
- **Fetch API** - HTTP requests

### Backend
- **Node.js** - Runtime environment
- **Express.js** - Web framework
- **MySQL** - Database
- **Multer** - File uploads for images
- **CORS** - Cross-Origin Resource Sharing

## Installation

### Prerequisites
- Node.js (v14 or higher)
- MySQL Server
- Git

### Setup Instructions

1. **Clone the repository**
```bash
git clone https://github.com/yourusername/Coffee_Shopfrontend.git
cd Coffee_Shopfrontend
```

2. **Setup Database**
```bash
# Open your MySQL client (phpMyAdmin or command line)
# Create a new database named 'coffeehaven'
# Import the SQL file:
mysql -u root -p coffeehaven < backend/sql/create_tables.sql
```

3. **Install Backend Dependencies**
```bash
cd backend
npm install
```

4. **Start Backend Server**
```bash
node Server.js
```
The server will run on `http://localhost:5000`

5. **Install Frontend Dependencies** (in a new terminal)
```bash
cd frontend
npm install
```

6. **Start Frontend Development Server**
```bash
npm start
```
The app will open at `http://localhost:3000`

## Project Structure

```
Coffee_Shopfrontend/
├── backend/
│   ├── Server.js           # Express server and API endpoints
│   ├── sql/
│   │   └── create_tables.sql  # Database schema
│   ├── uploads/            # Menu and event images
│   └── package.json
├── frontend/
│   ├── public/
│   ├── src/
│   │   ├── components/     # Reusable React components
│   │   ├── pages/          # Page components
│   │   ├── styles/         # CSS files
│   │   ├── utils/          # Utility functions
│   │   └── App.js
│   └── package.json
└── README.md
```

## API Endpoints

### Public Routes
- `POST /api/auth/signup` - User registration
- `POST /api/auth/signin` - User login
- `GET /api/menu` - Get all menu items
- `GET /api/events` - Get all events
- `POST /api/event/signup` - Sign up for an event

### Protected Routes (Requires user-id header)
- `GET /api/myorders` - Get user's orders
- `POST /api/orders` - Create an order
- `GET /api/event/signups` - Get all event signups (admin only)

## Database Schema

### users
- id, username, password, email, is_admin

### menu
- id, name, description, price, image_path

### events
- id, name, description, date, image_path

### orders
- id, user_id, item, quantity, order_date

### event_signups
- id, user_id, age, event_name, signup_date

## Authentication

- Users are authenticated using a `user-id` header in requests
- User data is stored in browser localStorage
- Passwords are stored in the database (implement hashing in production!)

## Development Notes

- Backend runs on port 5000
- Frontend runs on port 3000
- CORS is enabled for localhost communication
- Admin users have `is_admin = true` in the database

## Future Improvements

- [ ] Password hashing and salting
- [ ] JWT token-based authentication
- [ ] Payment integration
- [ ] Email notifications
- [ ] User profile management
- [ ] Advanced search and filtering
- [ ] Admin dashboard with analytics

## License

MIT

## Contact

For questions or issues, please open a GitHub issue.
