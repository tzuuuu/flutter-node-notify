const { executeQuery } = require('./setSQL');

const userRegister = (req, res) => {
  const { Account, Username, Password } = req.body;
  console.log(Account, Username, Password);
  const query = 'SELECT * FROM Members WHERE Account = ?';
  executeQuery(query, [Account])
    .then(results => {
      if (results.length > 0) {
        return res.status(400).json({ message: '此帳號已被註冊' });
      } else {
        const insertQuery = 'INSERT INTO Members (Account, Username, Password) VALUES (?, ?, ?)';
        return executeQuery(insertQuery, [Account, Username, Password]);
      }
    })
    .then(() => {
      res.status(201).json({ message: '註冊成功' });
    })
    .catch(error => {
      console.error('註冊失敗:', error);
      res.status(500).json({ message: '伺服器錯誤' });
    });
};

module.exports = userRegister;
