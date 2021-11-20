-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 21, 2021 at 12:20 AM
-- Server version: 10.4.21-MariaDB
-- PHP Version: 7.3.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hackvision`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth`
--

CREATE TABLE `auth` (
  `id` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `auth`
--

INSERT INTO `auth` (`id`, `password`, `type`) VALUES
('ajaykrishnan.ju@gmail.com', 'ajay', 'educator'),
('ajaykrishnan.ju@gmail.com', 'ajay', 'educator'),
('123@gmail.com', 'as', 'educator'),
('Jeremy@gmail.com', 'Jeremy', 'user'),
('tom@gmail.com', 'tom', 'educator'),
('jerry@gmail.com', 'jerry', 'user'),
('test_ed@gmail.com', 'test', 'educator'),
('aju', 'aju', 'educator'),
('aju', 'aju', 'educator'),
('k', 'k', 'user'),
('k', 'k', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL,
  `start_date_time` datetime NOT NULL,
  `end_date_time` datetime NOT NULL,
  `meeting_link` varchar(500) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `e_email` varchar(50) NOT NULL,
  `m_email` varchar(50) NOT NULL,
  `complete` blob NOT NULL,
  `duration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `start_date_time`, `end_date_time`, `meeting_link`, `subject_id`, `e_email`, `m_email`, `complete`, `duration`) VALUES
(1, '2021-11-24 21:44:45', '2021-11-24 23:44:45', 'https://google.com', 0, 'tom@gmail.com', 'Jeremy@gmail.com', '', 0),
(2, '2021-11-18 21:46:19', '2021-11-20 17:16:18', 'http://facebook.com', 0, 'tom@gmail.com', 'Jeremy@gmail.com', '', 0),
(3, '2021-11-26 23:35:39', '2021-11-27 23:35:39', 'http://www.google.com', 0, 'ajaykrishnan.ju@gmail.com', 'jerry@gmail.com', '', 0);

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `chat_id` int(11) NOT NULL,
  `text` varchar(500) DEFAULT NULL,
  `m_email` varchar(50) NOT NULL,
  `e_email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `educator`
--

CREATE TABLE `educator` (
  `email` varchar(50) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `description` varchar(1000) DEFAULT NULL,
  `rating` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `educator`
--

INSERT INTO `educator` (`email`, `full_name`, `description`, `rating`) VALUES
('123@gmail.com', 'ajay', 'asd', NULL),
('ajaykrishnan.ju@gmail.com', 'Ajay Krishnan', 'good', NULL),
('aju', 'aju', 'aju', NULL),
('test_ed@gmail.com', 'test', 'test', NULL),
('tom@gmail.com', 'Tom', 'Tom is good', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `educator_qualification`
--

CREATE TABLE `educator_qualification` (
  `qualification` varchar(500) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `educator_qualification`
--

INSERT INTO `educator_qualification` (`qualification`, `email`) VALUES
('asdasd', '123@gmail.com'),
('BTech', 'tom@gmail.com'),
('Test', 'test_ed@gmail.com'),
('a', 'aju');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `rating` int(11) DEFAULT NULL,
  `feedback` varchar(100) DEFAULT NULL,
  `m_email` varchar(50) NOT NULL,
  `e_email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `mentee`
--

CREATE TABLE `mentee` (
  `email` varchar(50) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `country` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `mentee`
--

INSERT INTO `mentee` (`email`, `full_name`, `country`) VALUES
('Jeremy@gmail.com', 'Jeremy', 'AL'),
('jerry@gmail.com', 'jerrry', 'CA'),
('k', 'k', 'KZ');

-- --------------------------------------------------------

--
-- Table structure for table `mentee_post`
--

CREATE TABLE `mentee_post` (
  `post_id` int(11) NOT NULL,
  `description` varchar(500) NOT NULL,
  `role_title` varchar(50) NOT NULL,
  `start_date_time` datetime NOT NULL,
  `end_date_time` datetime NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `subjects`
--

CREATE TABLE `subjects` (
  `subject_id` int(11) NOT NULL,
  `subject_name` varchar(100) NOT NULL,
  `email` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `subjects`
--

INSERT INTO `subjects` (`subject_id`, `subject_name`, `email`) VALUES
(0, 'Astronomy', '123@gmail.com'),
(2, 'Maths', 'ajaykrishnan.ju@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `booking_educator_fk` (`e_email`),
  ADD KEY `booking_subjects_fk` (`subject_id`),
  ADD KEY `booking_mentee_fk` (`m_email`);

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`chat_id`),
  ADD KEY `chat_educator_fk` (`e_email`),
  ADD KEY `chat_mentee_fk` (`m_email`);

--
-- Indexes for table `educator`
--
ALTER TABLE `educator`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `educator_qualification`
--
ALTER TABLE `educator_qualification`
  ADD KEY `qualification` (`email`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD KEY `feedback_educator_fk` (`e_email`),
  ADD KEY `feedback_mentee_fk` (`m_email`);

--
-- Indexes for table `mentee`
--
ALTER TABLE `mentee`
  ADD UNIQUE KEY `mentee_pk` (`email`);

--
-- Indexes for table `mentee_post`
--
ALTER TABLE `mentee_post`
  ADD PRIMARY KEY (`post_id`),
  ADD KEY `mentee_post_mentee_fk` (`email`);

--
-- Indexes for table `subjects`
--
ALTER TABLE `subjects`
  ADD PRIMARY KEY (`subject_id`),
  ADD KEY `subjects_educator_fk` (`email`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_educator_fk` FOREIGN KEY (`e_email`) REFERENCES `educator` (`email`),
  ADD CONSTRAINT `booking_mentee_fk` FOREIGN KEY (`m_email`) REFERENCES `mentee` (`email`),
  ADD CONSTRAINT `booking_subjects_fk` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`subject_id`);

--
-- Constraints for table `chat`
--
ALTER TABLE `chat`
  ADD CONSTRAINT `chat_educator_fk` FOREIGN KEY (`e_email`) REFERENCES `educator` (`email`),
  ADD CONSTRAINT `chat_mentee_fk` FOREIGN KEY (`m_email`) REFERENCES `mentee` (`email`);

--
-- Constraints for table `educator_qualification`
--
ALTER TABLE `educator_qualification`
  ADD CONSTRAINT `qualification` FOREIGN KEY (`email`) REFERENCES `educator` (`email`);

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_educator_fk` FOREIGN KEY (`e_email`) REFERENCES `educator` (`email`),
  ADD CONSTRAINT `feedback_mentee_fk` FOREIGN KEY (`m_email`) REFERENCES `mentee` (`email`);

--
-- Constraints for table `mentee_post`
--
ALTER TABLE `mentee_post`
  ADD CONSTRAINT `mentee_post_mentee_fk` FOREIGN KEY (`email`) REFERENCES `mentee` (`email`);

--
-- Constraints for table `subjects`
--
ALTER TABLE `subjects`
  ADD CONSTRAINT `subjects_educator_fk` FOREIGN KEY (`email`) REFERENCES `educator` (`email`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
