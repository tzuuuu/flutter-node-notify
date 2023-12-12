DROP DATABASE IF EXISTS flutter_nodejs_notify_system;
CREATE DATABASE flutter_nodejs_notify_system CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE flutter_nodejs_notify_system;

-- 會員
CREATE TABLE Members (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Account VARCHAR(50) UNIQUE NOT NULL,
    Username VARCHAR(50) NOT NULL,
    Password VARCHAR(100) NOT NULL
);

-- 公告類別
CREATE TABLE Categories (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(50) NOT NULL
);

-- 訂閱類別
CREATE TABLE SubscriptionCategories (
    MemberID INT,
    CategoryID INT,
    PRIMARY KEY (MemberID, CategoryID),
    FOREIGN KEY (MemberID) REFERENCES Members(ID),
    FOREIGN KEY (CategoryID) REFERENCES Categories(ID)
);

-- 插入公告類別表的六個公告類別
INSERT INTO Categories (Name) VALUES
('行政公告'), ('徵才公告'), ('校內徵才'), ('校外來文'), ('實習/就業'), ('活動預告');

-- 插入十筆會員資料
INSERT INTO Members (Account, Username, Password)
VALUES
('user1', 'User One', 'password1'),
('user2', 'User Two', 'password2'),
('user3', 'User Three', 'password3'),
('user4', 'User Four', 'password4'),
('user5', 'User Five', 'password5'),
('user6', 'User Six', 'password6'),
('user7', 'User Seven', 'password7'),
('user8', 'User Eight', 'password8'),
('user9', 'User Nine', 'password9'),
('user10', 'User Ten', 'password10');

-- 插入十筆隨機訂閱資料，每位使用者至少訂閱一個公告類別
INSERT INTO SubscriptionCategories (MemberID, CategoryID)
VALUES (1, 2),(2, 4),(3, 1),(4, 2),(5, 3),(6, 1),(7, 2),(8, 3),(9, 4),(10, 5),
(1, 6),(2, 1),(3, 2),(4, 3),(5, 4),(6, 5),(7, 6),(8, 1),(9, 2),(10, 3);

SELECT * FROM Members;
SELECT * FROM Categories;
SELECT * FROM SubscriptionCategories;


DELIMITER //
--  查詢使用者訂閱了哪些類別
CREATE PROCEDURE GetUserSubscribedCategories(IN user_id INT)
BEGIN
    SELECT Categories.Name FROM Categories
    INNER JOIN SubscriptionCategories ON Categories.ID = SubscriptionCategories.CategoryID
    INNER JOIN Members ON Members.ID = SubscriptionCategories.MemberID
    WHERE Members.ID = user_id;
END //

DELIMITER ;

CALL GetUserSubscribedCategories(2);