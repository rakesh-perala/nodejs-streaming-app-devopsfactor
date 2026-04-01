require('dotenv').config(); // Load environment variables

const express = require('express');
const path = require('path');
const expressLayouts = require('express-ejs-layouts');
const morgan = require('morgan');

const app = express();
const PORT = process.env.PORT || 3000;

// Load movies data
const movies = require('./data/movies.json');

// 🔹 Logging (Production standard)
app.use(morgan('combined'));

// 🔹 View Engine
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// 🔹 Layout setup
app.use(expressLayouts);
app.set('layout', 'layout');

// 🔹 Middleware
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.urlencoded({ extended: true }));

// 🔹 Health Check (used by Jenkins / Docker / monitoring)
app.get('/health', (req, res) => {
    res.status(200).json({ status: 'OK', uptime: process.uptime() });
});

// 🔹 Home page
app.get('/', (req, res) => {
  res.render('index', { movies });
});

// 🔹 Movie details
app.get('/movie/:id', (req, res) => {
  const movie = movies.find(m => m.id == req.params.id);

  if (!movie) {
    return res.status(404).render('error', { message: 'Movie not found' });
  }

  res.render('movie', { movie });
});

// 🔹 Login page
app.get('/login', (req, res) => {
  res.render('login');
});

// 🔹 Signup page
app.get('/signup', (req, res) => {
  res.render('signup');
});

// 🔹 404 Handler (VERY IMPORTANT)
app.use((req, res) => {
  res.status(404).render('error', { message: 'Page not found' });
});

// 🔹 Global Error Handler
app.use((err, req, res, next) => {
  console.error('❌ Error:', err.stack);
  res.status(500).render('error', { message: 'Internal Server Error' });
});

// 🔹 Start server
app.listen(PORT, () => {
  console.log(`🚀 Server running on http://localhost:${PORT}`);
});
