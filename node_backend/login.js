const { executeQuery } = require('./setSQL');

const userLogin = (req, res) => {
  const { account, password } = req.body;
  console.log(account, password);
  const query = 'SELECT * FROM Members WHERE Account = ? AND Password = ?';
  executeQuery(query, [account, password])
    .then(results => {
      if (results.length === 0) {
        return res.status(401).json({ message: '帳號或密碼錯誤' });
      } else {
        return res.status(200).json({ message: '登入成功', account: results['Account'], name: results['UserName'] });
      }      
    })
    .catch(error => {
      console.error('查詢資料庫出錯:', error);
      return res.status(500).json({ message: '伺服器錯誤' });
    });
};

module.exports = userLogin;
