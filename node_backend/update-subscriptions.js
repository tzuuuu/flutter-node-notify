const { executeQuery } = require('./setSQL');

const UpdateSubscriptions = async (req, res) => {
  const { user_account, newSubscriptions } = req.body;

  // check
  console.log('使用者帳戶:', user_account);
  console.log('新訂閱類別:', newSubscriptions);

  // 檢查是否提供了有效的使用者帳戶和新訂閱類別
  if (!user_account || !newSubscriptions || !Array.isArray(newSubscriptions)) {
    console.log('無效的使用者帳戶或新訂閱類別'); // check
    return res.status(400).json({ message: '請提供有效的使用者帳戶和訂閱類別' });
  }

  try {
    // 取得使用者ID
    const getUserIdQuery = `CALL GetUserIdFromAccount('${user_account}', @user_id)`;
    const getUserIdResult = await executeQuery(getUserIdQuery);
    
    // 確保有取得有效的使用者ID
    if (getUserIdResult && getUserIdResult[0] && getUserIdResult[0][0] && getUserIdResult[0][0].user_id) {
      const user_id = getUserIdResult[0][0].user_id;
      console.log('轉換後的使用者ID:', user_id);

      // 刪除原有的訂閱
      const deleteQuery = `DELETE FROM SubscriptionCategories WHERE MemberID = ${user_id}`;
      await executeQuery(deleteQuery);
      console.log('舊訂閱已刪除');

      // 建立新的訂閱資料
      const insertValues = newSubscriptions.map(categoryID => `(${user_id}, ${categoryID})`).join(',');
      const insertQuery = `INSERT INTO SubscriptionCategories (MemberID, CategoryID) VALUES ${insertValues}`;
      await executeQuery(insertQuery);
      console.log('新訂閱已添加');

      res.status(200).json({ message: '使用者訂閱更新成功' });
    } else {
      res.status(500).json({ error: 'User ID not found' });
    }
  } catch (err) {
    console.error('更新使用者訂閱時發生錯誤:', err);
    res.status(500).json({ message: '更新使用者訂閱時發生錯誤' });
  }
};

module.exports = UpdateSubscriptions;
