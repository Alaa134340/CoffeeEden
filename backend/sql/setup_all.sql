CREATE TABLE users (id INT AUTO_INCREMENT PRIMARY KEY, username VARCHAR(255), password VARCHAR(255), email VARCHAR(255), is_admin TINYINT DEFAULT 0);

CREATE TABLE menu (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), description TEXT, price DECIMAL(10,2), image VARCHAR(255), category VARCHAR(255));

CREATE TABLE orders (id INT AUTO_INCREMENT PRIMARY KEY, user_id INT, item VARCHAR(255), quantity INT, order_date DATETIME DEFAULT CURRENT_TIMESTAMP);

CREATE TABLE events (id INT AUTO_INCREMENT PRIMARY KEY, name VARCHAR(255), description TEXT, image VARCHAR(225));

CREATE TABLE event_signups (id INT AUTO_INCREMENT PRIMARY KEY, user_id INT, age INT, event_name VARCHAR(255), signup_date DATETIME DEFAULT CURRENT_TIMESTAMP);

INSERT INTO users VALUES (1, 'alaa', 'alaaalaa', 'alaa.mheich8@gmail.com', 1), (2, 'rena', 'renarena', 'rena@gmail.com', 0), (3, 'user2', 'useruser', 'user2@gmail.com', 0);

INSERT INTO menu VALUES (5, 'Vanilla Latte', 'Espresso with steamed milk with art on top', 4.00, '1767125647230-536536718-vanillalatte.jpg', 'coffee'), (6, 'caffe latte', 'Espresso with steamed milk', 4.75, '1767125755922-386115575-caffelatte.jpg', 'coffee'), (7, 'Matcha Latte', 'Espresso with steamed milk', 4.00, '1767125800472-77050444-matchalatte.jpg', 'coffee'), (8, 'Cappucino', 'Espresso, steamed milk & foam', 4.50, '1767125846247-774053659-cappucino.jpg', 'coffee'), (9, 'Macchiato', 'Espresso with steamed milk', 3.75, '1767125927193-188729870-macchiato.jpg', 'coffee'), (10, 'Mocha', 'Espresso with steamed milk and chocolate', 4.75, '1767125964184-999473934-mocha.jpg', 'coffee'), (11, 'Flat White', 'Espresso with steamed milk', 3.50, '1767126011489-605472842-flatwhite.jpg', 'coffee'), (12, 'Cold Brew', 'Slow-steeped cold coffee', 3.00, '1767126075955-614028809-coldbrew.jpg', 'coffee'), (13, 'Strawberry Banana', 'Fresh strawberries and bananas', 5.00, '1767126128251-583462545-strawberrySmoothie.jpg', 'smoothies'), (14, 'Tropical Mango', 'Sweet mango and pineapple', 5.50, '1767126183952-255951320-mangoSmoothie.jpg', 'smoothies'), (15, 'Berry Blast', 'Mixed berries with honey', 5.25, '1767126224894-769742378-berryBlast.jpg', 'smoothies'), (16, 'Green Detox', 'Spinach kale and apple', 5.75, '1767126263046-772947103-greenDetox.jpg', 'smoothies'), (17, 'Croissant', 'Buttery flaky croissant', 2.50, '1767126309462-297736561-croissant.jpg', 'pastry'), (18, 'Chocolate Croissant', 'Croissant with dark chocolate', 3.00, '1767126388280-993738945-chococroissant.jpg', 'pastry'), (19, 'Cinnamon Roll', 'Warm cinnamon roll with frosting', 3.50, '1767126435198-17285432-cinnamoroll.jpg', 'pastry'), (20, 'Muffin', 'Freshly baked muffin', 2.75, '1767126473995-498758974-muffin.jpg', 'pastry'), (21, 'Donuts', 'Assorted glazed donuts', 2.25, '1767126513169-969158949-donuts.jpg', 'pastry'), (23, 'Berry Acai', 'Acai with berries and granola', 6.50, '1767126628440-87680918-berryacaii.jpg', 'acaiBowls'), (24, 'Protein Acai', 'Acai with protein powder', 7.00, '1767126674856-111593871-proteinacaii.jpg', 'acaiBowls'), (25, 'Tropical Acai', 'Acai with mango and pineapple', 6.75, '1767126713140-149345180-tropicalAcaii.webp', 'acaiBowls'), (26, 'classic acai bowl', 'Acai bowl full of protein', 4.50, '1767200644192-187322168-acaii.jpg', 'acaiBowls');

INSERT INTO events VALUES (5, 'Pottery Painting', 'Pottery painting class for a calming experience', '1767198095140-939603848-potterypaint.jpg');

INSERT INTO orders VALUES (2, 1, 'COFFEE - Latte', 1, '2025-12-31 15:05:15'), (3, 1, 'COFFEE - Latte', 1, '2025-12-31 18:03:34'), (4, 2, 'COFFEE - Latte', 1, '2025-12-31 18:35:41');

INSERT INTO event_signups VALUES (1, 1, 123, 'sfdsfds', '2025-12-31 15:33:13'), (2, 2, 22, 'Pottery Painting', '2025-12-31 18:36:12');
