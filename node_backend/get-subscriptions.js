const { executeQuery } = require('./setSQL');

const GetSubscriptions = (req, res) => {
  const { user_account } = req.body;
  console.log(user_account); // check

  // get user_id
  const getUserIdQuery = `CALL GetUserIdFromAccount('${user_account}', @user_id)`;
  
  executeQuery(getUserIdQuery, (err, getUserIdResult) => {
    if (err) {
      res.status(500).json({ error: err.message });
      return;
    }

    if (getUserIdResult && getUserIdResult[0] && getUserIdResult[0][0] && getUserIdResult[0][0].user_id) {
      const user_id = getUserIdResult[0][0].user_id; // 確保獲取了有效的 user_id
      console.log('User ID:', user_id); // check
      const user_idQuery = `CALL GetUserSubscribedCategories(${user_id})`;

      // 用 user ID 抓訂閱公告類別
      executeQuery(user_idQuery, (err, getUserSubscribedCategoriesResult) => {
        if (err) {
          res.status(500).json({ error: err.message });
          return;
        }
      
        console.log('Subscribed Categories Result:', getUserSubscribedCategoriesResult); // check 訂閱類別
      
        if (getUserSubscribedCategoriesResult && Array.isArray(getUserSubscribedCategoriesResult) && getUserSubscribedCategoriesResult.length > 0) {
          // get 類別 ID
          const categoryIds = getUserSubscribedCategoriesResult[0].map((row) => row.ID);
          console.log('Category IDs:', categoryIds); // check          
      
          res.status(200).json({ categoryIds });
        } else {
          res.status(500).json({ error: 'No subscribed categories found or invalid result' });
        }
      });
      
    } else {
      res.status(500).json({ error: 'User ID not found' });
    }
  });
};


module.exports = GetSubscriptions;
