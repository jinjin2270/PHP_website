-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 19, 2025 at 02:13 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `foodfusion`
--

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `text` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `user_id`, `post_id`, `text`, `created_at`) VALUES
(1, 3, 5, 'Look great', '2025-05-18 19:42:57');

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `topic` varchar(100) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `submitted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `email`, `topic`, `message`, `submitted_at`) VALUES
(1, 'Jackson', 'jackson123@gmail.com', 'Feedback', 'i want Korean recipes too', '2025-05-16 16:19:06');

-- --------------------------------------------------------

--
-- Table structure for table `cuisine_types`
--

CREATE TABLE `cuisine_types` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cuisine_types`
--

INSERT INTO `cuisine_types` (`id`, `name`) VALUES
(1, 'Italian'),
(2, 'Thai'),
(3, 'British');

-- --------------------------------------------------------

--
-- Table structure for table `dietary_preferences`
--

CREATE TABLE `dietary_preferences` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `dietary_preferences`
--

INSERT INTO `dietary_preferences` (`id`, `name`) VALUES
(1, 'Vegan'),
(2, 'Vegetarian'),
(3, 'Gluten-Free');

-- --------------------------------------------------------

--
-- Table structure for table `difficulty_levels`
--

CREATE TABLE `difficulty_levels` (
  `id` int(11) NOT NULL,
  `level` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `difficulty_levels`
--

INSERT INTO `difficulty_levels` (`id`, `level`) VALUES
(1, 'Easy'),
(2, 'Medium'),
(3, 'Hard');

-- --------------------------------------------------------

--
-- Table structure for table `likes`
--

CREATE TABLE `likes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `post_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `likes`
--

INSERT INTO `likes` (`id`, `user_id`, `post_id`, `created_at`) VALUES
(7, 4, 5, '2025-05-16 06:52:22'),
(8, 4, 4, '2025-05-16 06:52:24'),
(9, 3, 5, '2025-05-16 07:05:15'),
(13, 3, 4, '2025-05-16 08:32:07'),
(14, 3, 6, '2025-05-18 04:19:03');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `caption` text DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `user_id`, `caption`, `image_path`, `created_at`) VALUES
(4, 3, 'scrambled eggs', 'uploads/682647c590315.jpg', '2025-05-15 20:00:05'),
(5, 4, 'healthy life', 'uploads/6826cac9c5173.jpg', '2025-05-16 05:19:05'),
(6, 3, 'Today\'s breakfast', 'uploads/6826ee21f4154.jpg', '2025-05-16 07:49:54'),
(7, 3, 'healthy bowl', 'uploads/6829a7ab84b9a.jpg', '2025-05-18 09:26:03');

-- --------------------------------------------------------

--
-- Table structure for table `recipes`
--

CREATE TABLE `recipes` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `cuisine_id` int(11) DEFAULT NULL,
  `diet_id` int(11) DEFAULT NULL,
  `difficulty_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `recipes`
--

INSERT INTO `recipes` (`id`, `title`, `image_url`, `description`, `cuisine_id`, `diet_id`, `difficulty_id`) VALUES
(1, 'Spaghetti Carbonara', 'Resources/images/recipes/spaghetti.jpg', 'Classic pasta with pancetta and egg sauce.', 1, 3, 2),
(2, 'Margherita Pizza', 'Resources/images/recipes/margherita.jpg', 'Pizza topped with tomato, mozzarella and basil.', 1, 2, 2),
(3, 'Lasagna', 'Resources/images/recipes/lasagna.jpg', 'Layered pasta with beef or veggie filling.', 1, 1, 3),
(4, 'Risotto alla Milanese', 'Resources/images/recipes/risotto.jpg', 'Creamy risotto infused with saffron.', 1, 2, 2),
(5, 'Fettuccine Alfredo', 'Resources/images/recipes/alfredo.jpg', 'Creamy pasta dish with butter and cheese.', 1, 2, 1),
(6, 'Osso Buco', 'Resources/images/recipes/osso-buco.jpg', 'Braised veal shanks with vegetables.', 1, 1, 3),
(7, 'Tiramisu', 'Resources/images/recipes/tiramisu.jpg', 'Coffee-flavored Italian dessert.', 1, 2, 3),
(8, 'Bruschetta', 'Resources/images/recipes/bruschetta.jpg', 'Grilled bread with tomato and basil topping.', 1, 1, 1),
(9, 'Parmigiana di Melanzane', 'Resources/images/recipes/eggplant.jpg', 'Baked eggplant with cheese and tomato sauce.', 1, 2, 2),
(10, 'Arancini', 'Resources/images/recipes/arancini.jpg', 'Fried risotto balls with cheese or meat.', 1, 1, 2),
(11, 'Minestrone Soup', 'Resources/images/recipes/minestrone.jpg', 'Hearty vegetable soup with beans and pasta.', 1, 1, 1),
(12, 'Cacio e Pepe', 'Resources/images/recipes/cacio-e-pepe.jpg', 'Pasta with cheese and black pepper.', 1, 2, 2),
(13, 'Saltimbocca alla Romana', 'Resources/images/recipes/saltimbocca.jpg', 'Veal with sage and prosciutto.', 1, 1, 3),
(14, 'Gnocchi al Pesto', 'Resources/images/recipes/gnocchi.jpg', 'Potato dumplings in pesto sauce.', 1, 2, 2),
(15, 'Caprese Salad', 'Resources/images/recipes/caprese.jpg', 'Tomato, mozzarella, and basil salad.', 1, 2, 1),
(16, 'Panna Cotta', 'Resources/images/recipes/panna-cotta.jpg', 'Creamy vanilla dessert.', 1, 2, 2),
(17, 'Ribollita', 'Resources/images/recipes/ribollita.jpg', 'Tuscan vegetable and bread soup.', 1, 1, 1),
(18, 'Cannoli', 'Resources/images/recipes/cannoli.jpg', 'Fried pastry with sweet ricotta filling.', 1, 2, 3),
(19, 'Polenta with Mushrooms', 'Resources/images/recipes/polenta.jpg', 'Cornmeal porridge with wild mushrooms.', 1, 1, 1),
(20, 'Tortellini in Brodo', 'Resources/images/recipes/tortellini.jpg', 'Stuffed pasta in broth.', 1, 1, 3),
(21, 'Pad Thai', 'Resources/images/recipes/pad-thai.jpg', 'Stir-fried rice noodles with tamarind sauce.', 2, 1, 2),
(22, 'Tom Yum Goong', 'Resources/images/recipes/tom-yum.jpg', 'Hot and sour shrimp soup with herbs.', 2, 1, 2),
(23, 'Green Curry', 'Resources/images/recipes/green-curry.jpg', 'Spicy curry with coconut milk and vegetables.', 2, 1, 2),
(24, 'Som Tum', 'Resources/images/recipes/som-tum.jpg', 'Spicy papaya salad.', 2, 1, 1),
(25, 'Massaman Curry', 'Resources/images/recipes/massaman.jpg', 'Rich and mild curry with beef or tofu.', 2, 1, 2),
(26, 'Satay Skewers', 'Resources/images/recipes/satay.jpg', 'Grilled meat skewers served with peanut sauce.', 2, 1, 2),
(27, 'Pad Kra Pao', 'Resources/images/recipes/pad-kra-pao.jpg', 'Stir-fried basil with meat or tofu.', 2, 1, 1),
(28, 'Tom Kha Gai', 'Resources/images/recipes/tom-kha.jpg', 'Coconut chicken soup with galangal.', 2, 1, 2),
(29, 'Mango Sticky Rice', 'Resources/images/recipes/mango-rice.jpg', 'Sweet coconut sticky rice with mango.', 2, 1, 1),
(30, 'Larb Moo', 'Resources/images/recipes/larb.jpg', 'Spicy minced pork salad.', 2, 1, 2),
(31, 'Spring Rolls', 'Resources/images/recipes/spring-rolls.jpg', 'Crispy rolls with veggie or shrimp filling.', 2, 1, 1),
(32, 'Panang Curry', 'Resources/images/recipes/panang.jpg', 'Thick red curry with peanuts and meat.', 2, 1, 2),
(33, 'Khao Soi', 'Resources/images/recipes/khao-soi.jpg', 'Noodle curry soup from Northern Thailand.', 2, 1, 3),
(34, 'Thai Fried Rice', 'Resources/images/recipes/fried-rice.jpg', 'Rice stir-fried with meat or vegetables.', 2, 1, 1),
(35, 'Gaeng Daeng', 'Resources/images/recipes/red-curry.jpg', 'Classic red curry with coconut milk.', 2, 1, 2),
(36, 'Yum Woon Sen', 'Resources/images/recipes/glass-noodle.jpg', 'Spicy glass noodle salad.', 2, 1, 1),
(37, 'Pla Rad Prik', 'Resources/images/recipes/fried-fish.jpg', 'Crispy fish with chili sauce.', 2, 1, 3),
(38, 'Cashew Chicken', 'Resources/images/recipes/cashew-chicken.jpg', 'Stir-fried chicken with cashews.', 2, 1, 1),
(39, 'Boat Noodles', 'Resources/images/recipes/boat-noodles.jpg', 'Hearty meat noodle soup.', 2, 1, 2),
(40, 'Tod Mun Pla', 'Resources/images/recipes/fish-cakes.jpg', 'Fried Thai fish cakes.', 2, 1, 2),
(41, 'Fish & Chips', 'Resources/images/recipes/fish-chips.jpg', 'Fried battered fish with chips.', 3, 1, 2),
(42, 'Full English Breakfast', 'Resources/images/recipes/english-breakfast.jpg', 'Classic British breakfast with eggs, sausage and more.', 3, 1, 1),
(43, 'Shepherd’s Pie', 'Resources/images/recipes/shepherds-pie.jpg', 'Mashed potato-topped meat pie.', 3, 1, 2),
(44, 'Beef Wellington', 'Resources/images/recipes/beef-wellington.jpg', 'Tender beef wrapped in puff pastry.', 3, 1, 3),
(45, 'Bangers & Mash', 'Resources/images/recipes/bangers.jpg', 'Sausages with mashed potatoes.', 3, 1, 1),
(46, 'Ploughman’s Lunch', 'Resources/images/recipes/ploughmans.jpg', 'Cold lunch of cheese, bread, and pickles.', 3, 2, 1),
(47, 'Toad in the Hole', 'Resources/images/recipes/toad-hole.jpg', 'Sausages baked in Yorkshire pudding.', 3, 1, 2),
(48, 'Chicken Tikka Masala', 'Resources/images/recipes/tikka.jpg', 'Chicken curry in tomato cream sauce.', 3, 1, 2),
(49, 'Cornish Pasty', 'Resources/images/recipes/pasty.jpg', 'Baked pastry with meat or veggie filling.', 3, 1, 2),
(50, 'Victoria Sponge Cake', 'Resources/images/recipes/sponge.jpg', 'Light sponge cake with jam and cream.', 3, 2, 1),
(51, 'Sticky Toffee Pudding', 'Resources/images/recipes/toffee.jpg', 'Moist sponge with toffee sauce.', 3, 2, 2),
(52, 'Scotch Eggs', 'Resources/images/recipes/scotch-eggs.jpg', 'Boiled egg wrapped in sausage and fried.', 3, 1, 3),
(53, 'Eton Mess', 'Resources/images/recipes/eton-mess.jpg', 'Strawberries, cream and crushed meringue.', 3, 2, 1),
(54, 'Bubble & Squeak', 'Resources/images/recipes/bubble.jpg', 'Pan-fried leftover veggies and potatoes.', 3, 2, 1),
(55, 'Lancashire Hotpot', 'Resources/images/recipes/hotpot.jpg', 'Lamb stew with sliced potatoes.', 3, 1, 2),
(56, 'Steak & Kidney Pie', 'Resources/images/recipes/steak-kidney.jpg', 'Pastry filled with steak and kidney.', 3, 1, 3),
(57, 'Welsh Rarebit', 'Resources/images/recipes/rarebit.jpg', 'Cheese sauce on toast.', 3, 2, 1),
(58, 'Trifle', 'Resources/images/recipes/trifle.jpg', 'Layered dessert with cake and custard.', 3, 2, 2),
(59, 'Black Pudding', 'Resources/images/recipes/black-pudding.jpg', 'Blood sausage often served with breakfast.', 3, 1, 1),
(60, 'Apple Crumble', 'Resources/images/recipes/crumble.jpg', 'Baked apples topped with buttery crumble.', 3, 2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password_hash` varchar(255) DEFAULT NULL,
  `failed_attempts` int(11) DEFAULT 0,
  `last_failed_login` datetime DEFAULT NULL,
  `is_locked` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `first_name`, `last_name`, `email`, `password_hash`, `failed_attempts`, `last_failed_login`, `is_locked`, `created_at`) VALUES
(3, 'Jackson', 'wan', 'jackson123@gmail.com', '$2y$10$wniQ0o0/P3j4kLgHAyTSJOTQCLssiopG5Pk1LcMsF8bvXQtGrhYyK', 0, NULL, 0, '2025-05-15 17:01:23'),
(4, 'Jessica', 'young', 'jessica123@gmail.com', '$2y$10$2Bucm0UgYXjFhTxc3Ee7mu4cfqyZKiWQx9sB3EfpEj8z3IjZhjDYC', 0, '2025-05-16 13:22:07', 0, '2025-05-15 19:20:27'),
(5, 'mickey', 'young', 'mickey12@gmail.com', '$2y$10$LXZOFA/zVkDZvBLbF.JDjeVdbn9hw/KcIkHU17nsghwTEGor9Pc1q', 0, NULL, 0, '2025-05-18 20:33:47');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `cuisine_types`
--
ALTER TABLE `cuisine_types`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `dietary_preferences`
--
ALTER TABLE `dietary_preferences`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `difficulty_levels`
--
ALTER TABLE `difficulty_levels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `likes`
--
ALTER TABLE `likes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_like` (`user_id`,`post_id`),
  ADD KEY `post_id` (`post_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `recipes`
--
ALTER TABLE `recipes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cuisine_id` (`cuisine_id`),
  ADD KEY `diet_id` (`diet_id`),
  ADD KEY `difficulty_id` (`difficulty_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cuisine_types`
--
ALTER TABLE `cuisine_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dietary_preferences`
--
ALTER TABLE `dietary_preferences`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `difficulty_levels`
--
ALTER TABLE `difficulty_levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `likes`
--
ALTER TABLE `likes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `recipes`
--
ALTER TABLE `recipes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=61;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`);

--
-- Constraints for table `likes`
--
ALTER TABLE `likes`
  ADD CONSTRAINT `likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `likes_ibfk_2` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`);

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `recipes`
--
ALTER TABLE `recipes`
  ADD CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`cuisine_id`) REFERENCES `cuisine_types` (`id`),
  ADD CONSTRAINT `recipes_ibfk_2` FOREIGN KEY (`diet_id`) REFERENCES `dietary_preferences` (`id`),
  ADD CONSTRAINT `recipes_ibfk_3` FOREIGN KEY (`difficulty_id`) REFERENCES `difficulty_levels` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
