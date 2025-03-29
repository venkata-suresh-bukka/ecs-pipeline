const express = require('express');
const app = express();

// Health check endpoint for ALB
app.get('/health', (req, res) => {
  res.status(200).send('OK');
});

// Main API endpoint (optional)
app.get('/app', (req, res) => {
  res.send('Hello from Node.js App behind ALB!');
});

// Run on port 3000 (ALB forwards traffic from 444 to 3000)
const PORT = 3000;
app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server running on port ${PORT}`);
});
