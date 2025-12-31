
const express = require('express');
const cors = require('cors');
const multer = require('multer');
const mysql = require('mysql');
require('dotenv').config();

const app = express();
// Serve uploaded images statically
app.use('/uploads', express.static('uploads'));

// CORS configuration for production
const corsOptions = {
	origin: process.env.FRONTEND_URL || 'http://localhost:3000',
	credentials: true,
	methods: ['GET', 'POST', 'PUT', 'DELETE'],
	allowedHeaders: ['Content-Type', 'user-id']
};

app.use(cors(corsOptions));
app.use(express.json());

// MySQL connection setup - MUST BE BEFORE MIDDLEWARE
const db = mysql.createConnection({
	host: process.env.DB_HOST || 'localhost',
	user: process.env.DB_USER || 'root', 
	password: process.env.DB_PASSWORD || '', 
	database: process.env.DB_NAME || 'coffeehaven'
});

db.connect((err) => {
	if (err) {
		console.error('Error connecting to MySQL:', err);
		return;
	}
	console.log('Connected to MySQL database coffeehaven');
});

// Simulated user authentication middleware (replace with real auth in production)
function authenticateUser(req, res, next) {
	// For demo, get user id from header (e.g., req.headers['user-id'])
	const userId = req.headers['user-id'];
	if (!userId) {
		req.user = null;
		return next();
	}
	db.query('SELECT * FROM users WHERE id = ?', [userId], (err, results) => {
		if (err) {
			console.error('Auth middleware error:', err);
			req.user = null;
			return next();
		}
		if (results.length === 0) {
			console.log('User not found with id:', userId);
			req.user = null;
			return next();
		}
		req.user = results[0];
		console.log('User authenticated:', req.user.username, 'is_admin:', req.user.is_admin);
		next();
	});
}

// Admin check middleware
function checkAdmin(req, res, next) {
	const userId = req.headers['user-id'];
	console.log('checkAdmin - user-id header:', userId);
	console.log('checkAdmin - req.user:', req.user);
	
	if (req.user && req.user.is_admin) {
		return next();
	}
	return res.status(403).json({ message: 'Access denied. Admins only.' });
}

// Public endpoints (NO authentication required)
// User signup endpoint
app.post('/api/auth/signup', (req, res) => {
	const { username, email, password } = req.body;
	
	if (!username || !email || !password) {
		return res.status(400).json({ error: 'Username, email, and password are required' });
	}

	// Check if user already exists
	db.query('SELECT * FROM users WHERE email = ? OR username = ?', [email, username], (err, results) => {
		if (err) return res.status(500).json({ error: err });
		if (results.length > 0) {
			return res.status(400).json({ error: 'User already exists' });
		}

		// Insert new user (is_admin is default false)
		db.query('INSERT INTO users (username, email, password, is_admin) VALUES (?, ?, ?, 0)', [username, email, password], (err, result) => {
			if (err) return res.status(500).json({ error: err });
			res.json({ id: result.insertId, username, email, is_admin: false });
		});
	});
});

// User signin endpoint
app.post('/api/auth/signin', (req, res) => {
	const { email, password } = req.body;
	
	if (!email || !password) {
		return res.status(400).json({ error: 'Email and password are required' });
	}

	db.query('SELECT * FROM users WHERE email = ? AND password = ?', [email, password], (err, results) => {
		if (err) return res.status(500).json({ error: err });
		if (results.length === 0) {
			return res.status(401).json({ error: 'Invalid email or password' });
		}

		const user = results[0];
		res.json({ id: user.id, username: user.username, email: user.email, is_admin: user.is_admin });
	});
});

// Event signup endpoint (requires authentication)
app.post('/api/event/signup', (req, res) => {
	const userId = req.headers['user-id'];
	const { age, event_name } = req.body;
	
	console.log('Event signup request - user_id:', userId, 'age:', age, 'event_name:', event_name);
	console.log('Type of age:', typeof age, 'Value of age:', age);
	console.log('Type of event_name:', typeof event_name, 'Value of event_name:', event_name);
	console.log('!age result:', !age, '!event_name result:', !event_name);

	if (!userId) {
		return res.status(401).json({ error: 'You must be logged in to sign up for events' });
	}

	if (!age || !event_name) {
		console.log('VALIDATION FAILED - age:', age, 'event_name:', event_name);
		return res.status(400).json({ error: 'All fields are required' });
	}

	console.log('Validation passed, inserting into database...');
	db.query('INSERT INTO event_signups (user_id, age, event_name) VALUES (?, ?, ?)', [userId, age, event_name], (err, result) => {
		if (err) {
			console.error('Database error:', err);
			return res.status(500).json({ error: 'Failed to save signup. Error: ' + err.message });
		}
		console.log('Successfully inserted event signup with ID:', result.insertId);
		res.json({ id: result.insertId, user_id: userId, age, event_name });
	});
});

// Get all menu items (public)
app.get('/api/menu', (req, res) => {
	db.query('SELECT * FROM menu', (err, results) => {
		if (err) return res.status(500).json({ error: err });
		// Transform image filenames to full URLs
		const menuWithImages = results.map(item => ({
			...item,
			image_path: item.image ? `/uploads/${item.image}` : null
		}));
		res.json(menuWithImages);
	});
});

// Get all events (public)
app.get('/api/events', (req, res) => {
	db.query('SELECT * FROM events', (err, results) => {
		if (err) return res.status(500).json({ error: err });
		// Transform image filenames to full URLs
		const eventsWithImages = results.map(event => ({
			...event,
			image_path: event.image ? `/uploads/${event.image}` : null
		}));
		res.json(eventsWithImages);
	});
});

// Multer setup for image uploads
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads');
  },
  filename: function (req, file, cb) {
    const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
    cb(null, uniqueSuffix + '-' + file.originalname);
  }
});
const upload = multer({ storage: storage });

// Protected endpoints (REQUIRE authentication)
app.use(authenticateUser); // Apply to remaining routes

// CRUD routes for events (admin only)

// Add a new event with image upload (name, description, image only)
app.post('/api/events', upload.single('image'), checkAdmin, (req, res) => {
	const { name, description } = req.body;
	const image = req.file ? req.file.filename : null;
	db.query('INSERT INTO events (name, description, image) VALUES (?, ?, ?)', [name, description, image], (err, result) => {
		if (err) return res.status(500).json({ error: err });
		res.json({ id: result.insertId, name, description, image });
	});
});

// Update an event
app.put('/api/events/:id', upload.single('image'), checkAdmin, (req, res) => {
	try {
		const { id } = req.params;
		console.log('Raw req.body:', req.body);
		console.log('req.file:', req.file);
		
		const name = req.body.name;
		const description = req.body.description;
		const image = req.file ? req.file.filename : null;

		console.log('--- Update event request received ---');
		console.log('ID:', id, 'Name:', name, 'Desc:', description, 'Image:', image);

		if (!name || !description) {
			return res.status(400).json({ error: 'Name and description are required' });
		}

		// Update with or without new image
		if (image) {
			db.query('UPDATE events SET name = ?, description = ?, image = ? WHERE id = ?', [name, description, image, id], (err, result) => {
				if (err) {
					console.error('Database error updating event with image:', err);
					return res.status(500).json({ error: 'Database error: ' + err.message });
				}
				console.log('Event updated successfully with new image');
				res.json({ id, name, description, image });
			});
		} else {
			db.query('UPDATE events SET name = ?, description = ? WHERE id = ?', [name, description, id], (err, result) => {
				if (err) {
					console.error('Database error updating event:', err);
					return res.status(500).json({ error: 'Database error: ' + err.message });
				}
				console.log('Event updated successfully');
				res.json({ id, name, description });
			});
		}
	} catch (error) {
		console.error('Exception in update event:', error);
		res.status(500).json({ error: 'Server error: ' + error.message });
	}
});

// Delete an event
app.delete('/api/events/:id', checkAdmin, (req, res) => {
	const { id } = req.params;
	db.query('DELETE FROM events WHERE id = ?', [id], (err) => {
		if (err) return res.status(500).json({ error: err });
		res.json({ message: 'Event deleted', id });
	});
});

// CRUD routes for menu items (admin only)

// Add a new menu item with image upload
app.post('/api/menu', upload.single('image'), checkAdmin, (req, res) => {
	const { name, description, price, category } = req.body;
	const image = req.file ? req.file.filename : null;
	const allowedCategories = ['coffee', 'smoothies', 'pastry', 'acaiBowls'];
	if (!allowedCategories.includes(category)) {
		return res.status(400).json({ error: 'Invalid category. Must be one of: coffee, smoothies, pastry, acaiBowls.' });
	}
	db.query('INSERT INTO menu (name, description, price, image, category) VALUES (?, ?, ?, ?, ?)', [name, description, price, image, category], (err, result) => {
		if (err) return res.status(500).json({ error: err });
		res.json({ id: result.insertId, name, description, price, image, category });
	});
});

// Update a menu item
app.put('/api/menu/:id', checkAdmin, (req, res) => {
	const { id } = req.params;
	const { name, description, price, image } = req.body;
	db.query('UPDATE menu SET name = ?, description = ?, price = ?, image = ? WHERE id = ?', [name, description, price, image, id], (err) => {
		if (err) return res.status(500).json({ error: err });
		res.json({ id, name, description, price, image });
	});
});

// Delete a menu item
app.delete('/api/menu/:id', checkAdmin, (req, res) => {
	const { id } = req.params;
	db.query('DELETE FROM menu WHERE id = ?', [id], (err) => {
		if (err) return res.status(500).json({ error: err });
		res.json({ message: 'Menu item deleted', id });
	});
});

// Get a single menu item by id (public)
app.get('/api/menu/:id', (req, res) => {
	const { id } = req.params;
	db.query('SELECT * FROM menu WHERE id = ?', [id], (err, results) => {
		if (err) return res.status(500).json({ error: err });
		if (results.length === 0) return res.status(404).json({ error: 'Menu item not found' });
		res.json(results[0]);
	});
});

// Protected endpoints (require authentication)
// Orders CRUD endpoints
// Get all orders (admin only)
app.get('/api/orders', checkAdmin, (req, res) => {
	db.query('SELECT * FROM orders', (err, results) => {
		if (err) return res.status(500).json({ error: err });
		res.json(results);
	});
});

// Get orders for logged-in user
app.get('/api/myorders', (req, res) => {
	if (!req.user) return res.status(401).json({ error: 'Not authenticated' });
	db.query('SELECT * FROM orders WHERE user_id = ?', [req.user.id], (err, results) => {
		if (err) return res.status(500).json({ error: err });
		res.json(results);
	});
});

// Create a new order (user only)
app.post('/api/orders', (req, res) => {
	if (!req.user) return res.status(401).json({ error: 'Not authenticated' });
	const { item, quantity } = req.body;
	db.query('INSERT INTO orders (user_id, item, quantity) VALUES (?, ?, ?)', [req.user.id, item, quantity], (err, result) => {
		if (err) return res.status(500).json({ error: err });
		res.json({ id: result.insertId, user_id: req.user.id, item, quantity });
	});
});

// Delete an order (admin only)
app.delete('/api/orders/:id', checkAdmin, (req, res) => {
	const { id } = req.params;
	db.query('DELETE FROM orders WHERE id = ?', [id], (err) => {
		if (err) return res.status(500).json({ error: err });
		res.json({ message: 'Order deleted', id });
	});
});

// Check user admin status
app.get('/api/user-check', (req, res) => {
	if (!req.user) return res.status(401).json({ error: 'Not authenticated' });
	res.json({ is_admin: req.user.is_admin, id: req.user.id, email: req.user.email });
});

// Get all event signups (admin only)
app.get('/api/event/signups', checkAdmin, (req, res) => {
	db.query(`
		SELECT 
			es.id, 
			es.user_id, 
			es.age, 
			es.event_name, 
			es.signup_date,
			u.username,
			u.email
		FROM event_signups es
		JOIN users u ON es.user_id = u.id
		ORDER BY es.signup_date DESC
	`, (err, results) => {
		if (err) {
			console.error('Error fetching event signups:', err);
			return res.status(500).json({ error: err });
		}
		res.json(results);
	});
});

// DEV ONLY: Set user as admin by id
app.put('/api/dev/make-admin/:id', (req, res) => {
	const { id } = req.params;
	db.query('UPDATE users SET is_admin = 1 WHERE id = ?', [id], (err) => {
		if (err) return res.status(500).json({ error: err });
		res.json({ message: 'User is now admin', id });
	});
});

// Example route
app.get('/', (req, res) => {
	res.send('Coffee Haven backend is running');
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, '0.0.0.0', () => {
	console.log(`Server started on port ${PORT}`);
	console.log(`Environment: ${process.env.NODE_ENV || 'development'}`);
});