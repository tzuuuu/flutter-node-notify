const express = require('express');
const bodyParser = require('body-parser');

const userLogin = require('./login');
const userRegister = require('./register');

const app = express();

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

// 登入請求的路由
app.post('/login', userLogin);
app.post('/register', userRegister);

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}/`);
});
