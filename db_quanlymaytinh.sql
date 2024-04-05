-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 05, 2024 at 03:55 PM
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
-- Database: `db_quanlymaytinh`
--

-- --------------------------------------------------------

--
-- Table structure for table `tt_computer`
--

CREATE TABLE `tt_computer` (
  `id` int(11) NOT NULL,
  `user` varchar(50) NOT NULL,
  `IP` varchar(15) NOT NULL,
  `HeDieuHanh` varchar(50) DEFAULT NULL,
  `VaiTro` varchar(50) DEFAULT NULL,
  `Time_conn` datetime DEFAULT current_timestamp(),
  `status` varchar(10) DEFAULT NULL,
  `in4_Ram` varchar(20) DEFAULT NULL,
  `in4_Rom` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tt_computer`
--

INSERT INTO `tt_computer` (`id`, `user`, `IP`, `HeDieuHanh`, `VaiTro`, `Time_conn`, `status`, `in4_Ram`, `in4_Rom`) VALUES
(19, 'VT', '192.168.1.7', 'Windows', 'CaNhan', '2024-04-04 22:26:16', 'Online ✅️', '32', '512'),
(20, 'VT', '192.168.1.10', 'Windows', 'QuanTri', '2024-04-02 22:26:16', 'Offline ❌', '16', '512');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fullname` varchar(100) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `username`, `password`, `email`) VALUES
(5, 'Pham Viet Thanh', 'VT', '1907', 'thanhh@gmail.com'),
(6, 'Ngo Thi Thu Thao', 'TT', '2001', 'thao@gmail.com'),
(7, 'Lam Chi Nguyen', 'lcn', '0000', 'nguyen@gmail.com'),
(8, 'Pham Viet Thanh', 'thanh', 'thanh1907', 'thanhpham@gmail.com'),
(9, 'Nguyen Thanh Binh', 'ntbinh', 'abc123', 'b@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tt_computer`
--
ALTER TABLE `tt_computer`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tt_computer`
--
ALTER TABLE `tt_computer`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
