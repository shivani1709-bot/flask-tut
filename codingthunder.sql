-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 20, 2020 at 10:57 AM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.2.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codingthunder`
--

-- --------------------------------------------------------

--
-- Table structure for table `contacts`
--

CREATE TABLE `contacts` (
  `sno` int(50) NOT NULL,
  `name` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_num` varchar(50) NOT NULL,
  `msg` text NOT NULL,
  `date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `contacts`
--

INSERT INTO `contacts` (`sno`, `name`, `email`, `phone_num`, `msg`, `date`) VALUES
(1, 'name', 'email', 'phone', 'message', '2020-12-11 17:57:41'),
(2, 'name', 'email', 'phone', 'message', '2020-12-11 18:16:26'),
(3, 'name', 'email', 'phone', 'message', '2020-12-11 18:17:29'),
(4, 'name', 'email', 'phone', 'message', '2020-12-11 22:06:24'),
(5, 'name', 'email', 'phone', 'message', '2020-12-11 22:07:30'),
(6, 'name', 'email', 'phone', 'message', '2020-12-15 13:08:45');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `sno` int(11) NOT NULL,
  `title` text NOT NULL,
  `tagline` varchar(120) NOT NULL,
  `slug` varchar(25) NOT NULL,
  `content` text NOT NULL,
  `date` datetime NOT NULL DEFAULT current_timestamp(),
  `img_file` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`sno`, `title`, `tagline`, `slug`, `content`, `date`, `img_file`) VALUES
(1, 'This is the first post.', 'First post ..!!', 'first-post', 'As stated above, any file can be loaded as a template, regardless of file extension. Adding a .jinja extension, like user.html.jinja may make it easier for some IDEs or editor plugins, but is not required. Autoescaping, introduced later, can be applied based on file extension, so you’ll need to take the extra suffix into account in that case.\r\n\r\nAnother good heuristic for identifying templates is that they are in a templates folder, regardless of extension. This is a common layout for projects.', '2020-12-15 16:49:12', 'home-bg.jpg'),
(2, 'This is the second post Edited', 'Coolest post ever..!', 'second-post', 'Welcome to part 2 of my Jinja2 Tutorial. In part 1 we learned what Jinja2 is, what are its uses, and we started looking at templating basics. Coming up next are loops and conditionals, sprinkled with tests and a healthy dose of examples!', '2020-12-15 16:50:20', 'home-bg.jpg'),
(3, 'This is the third post. ', 'And this is brand new post..!!', 'third-post', 'A Jinja template is simply a text file. Jinja can generate any text-based format (HTML, XML, CSV, LaTeX, etc.). A Jinja template doesn’t need to have a specific extension: .html, .xml, or any other extension is just fine.\r\n\r\nA template contains variables and/or expressions, which get replaced with values when a template is rendered; and tags, which control the logic of the template. The template syntax is heavily inspired by Django and Python.', '2020-12-15 16:51:06', 'home-bg.jpg'),
(4, 'This is fourth post. ', 'Did you know..!!', 'fourth-post', '\r\n\r\n19\r\nI have an existing database using PHP, MySQL and phpMyAdmin.\r\n\r\nWhen users become a member on my website, I need the system to create a unique membership number for them using a five digit number. for e.g 83773. I guess it is like generating a random password except I only want numbers for my members. This ID number has to be unique to each member.\r\n\r\nWould it be possible for me to set the primary key to auto_increment in my user table and set it to start at 10000 and then auto increment every time a member registers?', '2020-12-15 17:26:56', 'home-bg.jpg'),
(5, 'This is the fifth and last post. ', 'Fifth post..!!', 'fifth-post', 'Would it be possible for me to set the primary key to auto_increment in my user table and set it to start at 10000 and then auto increment every time a member registers?\r\n\r\nAlso, is there a maximum number that the primary key ID number would go up to?', '2020-12-15 17:27:50', 'home-bg.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `contacts`
--
ALTER TABLE `contacts`
  ADD PRIMARY KEY (`sno`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`sno`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `contacts`
--
ALTER TABLE `contacts`
  MODIFY `sno` int(50) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `sno` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
