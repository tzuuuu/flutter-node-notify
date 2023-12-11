const mysql = require('mysql');

const connection = mysql.createConnection({
    host: 'localhost',
    port: '3306',
    user: 'root',
    password: '1234',
    database: 'flutter_nodejs_notify_system'
});

connection.connect(function(err) {
  if (err) throw err;
  console.log("Connected!");
});

const executeQuery = (query, values) => {
  return new Promise((resolve, reject) => {
    connection.query(query, values, (error, results) => {
      if (error) {
        reject(error);
      } else {
        resolve(results);
      }
    });
  });
};

module.exports = { executeQuery };
