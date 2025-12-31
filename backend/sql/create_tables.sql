SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE IF NOT EXISTS `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `image` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`id`, `name`, `description`, `image`) VALUES
(5, 'Pottery Painting', 'join us now in our pottery painting class that will take your mind in a calming experience!', '1767198095140-939603848-potterypaint.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `event_signups`
--

CREATE TABLE IF NOT EXISTS `event_signups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `age` int(11) NOT NULL,
  `event_name` varchar(255) NOT NULL,
  `signup_date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `event_signups`
--

INSERT INTO `event_signups` (`id`, `user_id`, `age`, `event_name`, `signup_date`) VALUES
(1, 1, 123, 'sfdsfds', '2025-12-31 15:33:13'),
(2, 2, 22, 'Pottery Painting', '2025-12-31 18:36:12');

-- --------------------------------------------------------

--
-- Table structure for table `menu`
--

CREATE TABLE IF NOT EXISTS `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `menu`
--

INSERT INTO `menu` (`id`, `name`, `description`, `price`, `image`, `category`) VALUES
(5, 'Vanilla Latte', 'Espresso with steamed milk with art on top if you have it hot', 4.00, '1767125647230-536536718-vanillalatte.jpg', 'coffee'),
(6, 'caffe latte', 'Espresso with steamed milk.You have the option to have it hot or iced.', 4.75, '1767125755922-386115575-caffelatte.jpg', 'coffee'),
(7, 'Matcha Latte', 'Espresso with steamed milk.You have the option to have it hot or iced', 4.00, '1767125800472-77050444-matchalatte.jpg', 'coffee'),
(8, 'Cappucino', 'Espresso, steamed milk & foam', 4.50, '1767125846247-774053659-cappucino.jpg', 'coffee'),
(9, 'Macchiato ', 'Espresso with steamed milk.You have the option to have it hot or iced.', 3.75, '1767125927193-188729870-macchiato.jpg', 'coffee'),
(10, 'Mocha', 'Espresso with steamed milk and chocolate.You have the option to have it hot or iced.', 4.75, '1767125964184-999473934-mocha.jpg', 'coffee'),
(11, 'Flat White', 'Espresso with steamed milk.You have the option to have it hot or iced.', 3.50, '1767126011489-605472842-flatwhite.jpg', 'coffee'),
(12, 'Cold Brew', 'Slow-steeped cold coffee, served chilled.', 3.00, '1767126075955-614028809-coldbrew.jpg', 'coffee'),
(13, 'Strawberry Banana', 'Fresh strawberries, ripe bananas, and creamy yogurt blended to perfection', 5.00, '1767126128251-583462545-strawberrySmoothie.jpg', 'smoothies'),
(14, 'Tropical Mango', 'Sweet mango, tropical pineapple, and smooth coconut milk for a paradise taste', 5.50, '1767126183952-255951320-mangoSmoothie.jpg', 'smoothies'),
(15, 'Berry Blast', 'lueberries, raspberries, strawberries, and blackberries with a hint of honey', 5.25, '1767126224894-769742378-berryBlast.jpg', 'smoothies'),
(16, 'Green Detox', 'Spinach, kale, green apple, cucumber, and lemon for a refreshing cleanse', 5.75, '1767126263046-772947103-greenDetox.jpg', 'smoothies'),
(17, 'Croissant', 'Classic buttery, flaky French croissant baked fresh daily', 2.50, '1767126309462-297736561-croissant.jpg', 'pastry'),
(18, 'Chocolate Croissant', 'Buttery croissant filled with rich dark chocolate', 3.00, '1767126388280-993738945-chococroissant.jpg', 'pastry'),
(19, 'Cinnamon Roll', 'Warm, gooey cinnamon roll topped with cream cheese frosting', 3.50, '1767126435198-17285432-cinnamoroll.jpg', 'pastry'),
(20, 'Muffin', 'Freshly baked muffin in your choice of blueberry, chocolate chip, or banana nut', 2.75, '1767126473995-498758974-muffin.jpg', 'pastry'),
(21, 'Donuts', 'Assorted glazed, chocolate, and specialty donuts made fresh each morning', 2.25, '1767126513169-969158949-donuts.jpg', 'pastry'),
(23, 'Berry Açaí', 'Açaí base with mixed berries, crunchy granola, and toasted almond flakes', 6.50, '1767126628440-87680918-berryacaii.jpg', 'acaiBowls'),
(24, 'Protein Açaí', 'Açaí blend with protein powder, peanut butter, granola, banana, and chia seeds', 7.00, '1767126674856-111593871-proteinacaii.jpg', 'acaiBowls'),
(25, 'Tropical Açaí', 'Açaí topped with mango, pineapple, coconut flakes, granola, and passion frui', 6.75, '1767126713140-149345180-tropicalAcaii.webp', 'acaiBowls'),
(26, 'classic acai bowl', 'enjoy our acaii bowl that is full of protien', 4.50, '1767200644192-187322168-acaii.jpg', 'acaiBowls');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE IF NOT EXISTS `orders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `item` varchar(255) NOT NULL,
  `quantity` int(11) NOT NULL,
  `order_date` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `item`, `quantity`, `order_date`) VALUES
(2, 1, 'COFFEE - Latte', 1, '2025-12-31 15:05:15'),
(3, 1, 'COFFEE - Latte', 1, '2025-12-31 18:03:34'),
(4, 2, 'COFFEE - Latte', 1, '2025-12-31 18:35:41');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `is_admin` tinyint(1) DEFAULT 0,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `is_admin`) VALUES
(1, 'alaa', 'alaaalaa', 'alaa.mheich8@gmail.com', 1),
(2, 'rena', 'renarena', 'rena@gmail.com', 0),
(3, 'user2', 'useruser', 'user2@gmail.com', 0);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `event_signups`
--
ALTER TABLE `event_signups`
  ADD CONSTRAINT `event_signups_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
