-- Create users table
CREATE TABLE IF NOT EXISTS users (
  id INT NOT NULL AUTO_INCREMENT,
  username VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  is_admin TINYINT(1) DEFAULT 0,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create menu table
CREATE TABLE IF NOT EXISTS menu (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  description TEXT DEFAULT NULL,
  price DECIMAL(10,2) NOT NULL,
  image VARCHAR(255) DEFAULT NULL,
  category VARCHAR(255) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create orders table
CREATE TABLE IF NOT EXISTS orders (
  id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  item VARCHAR(255) NOT NULL,
  quantity INT NOT NULL,
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create events table
CREATE TABLE IF NOT EXISTS events (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(255) NOT NULL,
  description TEXT NOT NULL,
  image VARCHAR(225) DEFAULT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Create event_signups table
CREATE TABLE IF NOT EXISTS event_signups (
  id INT NOT NULL AUTO_INCREMENT,
  user_id INT NOT NULL,
  age INT NOT NULL,
  event_name VARCHAR(255) NOT NULL,
  signup_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  KEY user_id (user_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Insert sample users
INSERT INTO users (username, password, email, is_admin) VALUES
('alaa', 'alaaalaa', 'alaa.mheich8@gmail.com', 1),
('rena', 'renarena', 'rena@gmail.com', 0),
('user2', 'useruser', 'user2@gmail.com', 0);

-- Insert menu items
INSERT INTO menu (name, description, price, image, category) VALUES
('Vanilla Latte', 'Espresso with steamed milk with art on top if you have it hot', 4.00, '1767125647230-536536718-vanillalatte.jpg', 'coffee'),
('caffe latte', 'Espresso with steamed milk. You have the option to have it hot or iced.', 4.75, '1767125755922-386115575-caffelatte.jpg', 'coffee'),
('Matcha Latte', 'Espresso with steamed milk. You have the option to have it hot or iced', 4.00, '1767125800472-77050444-matchalatte.jpg', 'coffee'),
('Cappucino', 'Espresso, steamed milk & foam', 4.50, '1767125846247-774053659-cappucino.jpg', 'coffee'),
('Macchiato', 'Espresso with steamed milk. You have the option to have it hot or iced.', 3.75, '1767125927193-188729870-macchiato.jpg', 'coffee'),
('Mocha', 'Espresso with steamed milk and chocolate. You have the option to have it hot or iced.', 4.75, '1767125964184-999473934-mocha.jpg', 'coffee'),
('Flat White', 'Espresso with steamed milk. You have the option to have it hot or iced.', 3.50, '1767126011489-605472842-flatwhite.jpg', 'coffee'),
('Cold Brew', 'Slow-steeped cold coffee, served chilled.', 3.00, '1767126075955-614028809-coldbrew.jpg', 'coffee'),
('Strawberry Banana', 'Fresh strawberries, ripe bananas, and creamy yogurt blended to perfection', 5.00, '1767126128251-583462545-strawberrySmoothie.jpg', 'smoothies'),
('Tropical Mango', 'Sweet mango, tropical pineapple, and smooth coconut milk for a paradise taste', 5.50, '1767126183952-255951320-mangoSmoothie.jpg', 'smoothies'),
('Berry Blast', 'Blueberries, raspberries, strawberries, and blackberries with a hint of honey', 5.25, '1767126224894-769742378-berryBlast.jpg', 'smoothies'),
('Green Detox', 'Spinach, kale, green apple, cucumber, and lemon for a refreshing cleanse', 5.75, '1767126263046-772947103-greenDetox.jpg', 'smoothies'),
('Croissant', 'Classic buttery, flaky French croissant baked fresh daily', 2.50, '1767126309462-297736561-croissant.jpg', 'pastry'),
('Chocolate Croissant', 'Buttery croissant filled with rich dark chocolate', 3.00, '1767126388280-993738945-chococroissant.jpg', 'pastry'),
('Cinnamon Roll', 'Warm, gooey cinnamon roll topped with cream cheese frosting', 3.50, '1767126435198-17285432-cinnamoroll.jpg', 'pastry'),
('Muffin', 'Freshly baked muffin in your choice of blueberry, chocolate chip, or banana nut', 2.75, '1767126473995-498758974-muffin.jpg', 'pastry'),
('Donuts', 'Assorted glazed, chocolate, and specialty donuts made fresh each morning', 2.25, '1767126513169-969158949-donuts.jpg', 'pastry'),
('Berry Açaí', 'Açaí base with mixed berries, crunchy granola, and toasted almond flakes', 6.50, '1767126628440-87680918-berryacaii.jpg', 'acaiBowls'),
('Protein Açaí', 'Açaí blend with protein powder, peanut butter, granola, banana, and chia seeds', 7.00, '1767126674856-111593871-proteinacaii.jpg', 'acaiBowls'),
('Tropical Açaí', 'Açaí topped with mango, pineapple, coconut flakes, granola, and passion fruit', 6.75, '1767126713140-149345180-tropicalAcaii.webp', 'acaiBowls'),
('classic acai bowl', 'enjoy our acaii bowl that is full of protein', 4.50, '1767200644192-187322168-acaii.jpg', 'acaiBowls');

-- Insert sample events
INSERT INTO events (name, description, image) VALUES
('Pottery Painting', 'join us now in our pottery painting class that will take your mind in a calming experience!', '1767198095140-939603848-potterypaint.jpg');

-- Insert sample orders
INSERT INTO orders (user_id, item, quantity, order_date) VALUES
(1, 'COFFEE - Latte', 1, '2025-12-31 15:05:15'),
(1, 'COFFEE - Latte', 1, '2025-12-31 18:03:34'),
(2, 'COFFEE - Latte', 1, '2025-12-31 18:35:41');

-- Insert sample event signups
INSERT INTO event_signups (user_id, age, event_name, signup_date) VALUES
(1, 123, 'sfdsfds', '2025-12-31 15:33:13'),
(2, 22, 'Pottery Painting', '2025-12-31 18:36:12');
