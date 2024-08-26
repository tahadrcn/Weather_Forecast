const express = require('express');
const app = express();
const port = 3000;

const cities = [
  "New York", "Los Angeles", "London", "Tokyo", "Paris", "Berlin", 
  "Moscow", "Beijing", "Sydney", "Dubai", "Mumbai", "Cape Town", 
  "São Paulo", "Mexico City", "Istanbul", "Toronto", "Seoul", "Singapore",
  "Hong Kong", "Bangkok", "Jakarta", "Buenos Aires", "Cairo", "Lagos",
  "Nairobi", "Karachi", "Tehran", "Rome", "Madrid", "Amsterdam"
];

app.get('/cities', (req, res) => {
  res.json(cities);
});

app.listen(port, () => {
  console.log(`City names API listening at http://localhost:${port}`);
});