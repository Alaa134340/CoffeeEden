// API Configuration
// Change this URL based on your environment
const API_URL = process.env.REACT_APP_API_URL || process.env.NODE_ENV === 'production' ? 'https://coffeeeden.onrender.com' : 'http://localhost:5000';

export default API_URL;
