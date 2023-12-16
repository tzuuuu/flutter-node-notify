const express = require('express');
const bodyParser = require('body-parser');

const userLogin = require('./login');
const userRegister = require('./register');
const UpdateSubscriptions = require('./update-subscriptions')
const GetSubscriptions = require('./get-subscriptions');
const app = express();

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());


app.post('/login', userLogin);
app.post('/register', userRegister);
app.post('/update-subscriptions', UpdateSubscriptions);
app.post('/get-subscriptions', GetSubscriptions);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}/`);
});
