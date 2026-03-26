const express = require('express');
const path = require('path');
const expressLayouts = require('express-ejs-layouts');

const app = express();
const PORT = 3000;

// Load movies data
const movies = require('./data/movies.json');

// View Engine
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'views'));

// Layout setup
app.use(expressLayouts);
app.set('layout', 'layout'); // uses views/layout.ejs

// Middleware
app.use(express.static(path.join(__dirname, 'public')));
app.use(express.urlencoded({ extended: true }));

// Routes

// Home page
app.get('/', (req, res) => {
  res.render('index', { movies });
});

// Movie details
app.get('/movie/:id', (req, res) => {
  const movie = movies.find(m => m.id == req.params.id);
  res.render('movie', { movie });
});

// Login page
app.get('/login', (req, res) => {
  res.render('login');
});

// Signup page
app.get('/signup', (req, res) => {
  res.render('signup');
});

// Start server
app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});
