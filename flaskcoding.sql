-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 31, 2020 at 09:45 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `flaskcoding`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `id` int(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone` varchar(12) NOT NULL,
  `message` varchar(200) DEFAULT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`id`, `name`, `email`, `phone`, `message`, `date`) VALUES
(1, 'first post', 'first email', '234234234', 'kldfjkl', '2020-07-26 21:56:50'),
(2, '', '', '', '', NULL),
(3, 'deepak', 'deepak@gmail.com', '7739783100', 'hii this is me', NULL),
(4, 'deepak', 'deepak@gmail.com', '7739783100', 'hii this is me', '2020-07-26 22:26:00'),
(5, '', '', '', '', '2020-07-27 10:41:00'),
(6, 'deepak', 'deepak2@gmail.com', '7739783100', 'hi this is me', '2020-07-27 11:31:17'),
(7, 'deepak', 'deepak@gmail.com', '7739783100', 'kldsfh', '2020-07-27 11:43:41'),
(8, 'gjHFHJG', 'UKGH@HG.FFDS', '56875875875', 'UYGTKUYHFVKJUYHV', '2020-07-27 11:50:07'),
(9, 'deepak', 'deepak@gmail.com', '7739783100', 'kdsfjlkdsfjl', '2020-07-27 12:09:14'),
(10, 'deepak', 'deepak@gmail.com', '7739783100', 'kdsfjlkdsfjl', '2020-07-27 12:11:36'),
(11, 'deepak', 'deepak@gmail.com', '7739783100', 'kdsfjlkdsfjl', '2020-07-27 12:13:12'),
(12, 'deepak', 'deepak@gmail.com', '7739783100', 'kdsfjlkdsfjl', '2020-07-27 12:14:04'),
(13, 'deepak', 'deepak@gmail.com', '7739783100', 'kdsfjlkdsfjl', '2020-07-27 21:18:15'),
(14, 'deepak rajak', 'deepakparsabad@gmail.com', '7739783100', 'hii your blogs is awesome', '2020-07-27 21:22:33'),
(15, 'deepak rajak', 'deepakparsabad@gmail.com', '7739783100', 'hii your blogs is awesome', '2020-07-27 21:25:07'),
(16, 'suraj kumar', 'duraj@gmail.com', '374897343', 'aosm site', '2020-07-29 12:48:58'),
(17, 'suraj kumar', 'deepakparsabad2@gmail.com', '374897343', 'aosm site', '2020-07-29 12:50:00');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int(10) NOT NULL,
  `title` varchar(255) NOT NULL,
  `tag_line` varchar(100) NOT NULL,
  `slug` varchar(30) NOT NULL,
  `content` varchar(255) NOT NULL,
  `img_file` varchar(200) NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `tag_line`, `slug`, `content`, `img_file`, `date`) VALUES
(1, 'this is my frist blogs', 'this is first post', 'first-post', 'this is my first post using flask and I am very excited to do some work in daily life', 'home-bg1.jpg', '2020-07-29 12:35:00'),
(2, 'This is my second blogs', 'this is second post', 'second-post', 'hii i am working in front end and backend in web development so if you guys want to join with then context me as soon as possible', 'about-bg.jpg', '2020-07-28 12:31:26'),
(4, 'this is my fourth post', 'hii this is latest post', 'fourth-post', 'this is my fourth post in the flask and I want to do anything', '', '2020-07-28 12:39:50'),
(5, 'this is my fifth post in flask', 'hii this is latest post', 'fifth-post', 'this is latest post in flask and I will invite to join with me', '', '2020-07-28 12:41:36'),
(6, 'this is my six post in flask', 'this is latest post', 'six-post', 'this is latest post in flask and I will invite to join with me', 'about-bg.jpg', '2020-07-31 12:47:30'),
(10, 'hi', 'hii', 'hi-post', 'hii', 'about-bg.jpg', '2020-07-31 13:04:42');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `id` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
