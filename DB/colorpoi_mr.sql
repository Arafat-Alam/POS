-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 07, 2019 at 12:46 AM
-- Server version: 10.2.22-MariaDB-cll-lve
-- PHP Version: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `colorpoi_mr`
--

-- --------------------------------------------------------

--
-- Table structure for table `branch_info`
--

CREATE TABLE `branch_info` (
  `branch_id` int(10) UNSIGNED NOT NULL,
  `branch_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

--
-- Dumping data for table `branch_info`
--

INSERT INTO `branch_info` (`branch_id`, `branch_name`, `status`) VALUES
(1, 'Main Branch', 1);

-- --------------------------------------------------------

--
-- Table structure for table `companynames`
--

CREATE TABLE `companynames` (
  `company_id` int(10) UNSIGNED NOT NULL,
  `company_name` varchar(50) NOT NULL,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '0=inactive, 1=active',
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `companynames`
--

INSERT INTO `companynames` (`company_id`, `company_name`, `status`, `created_by`, `created_at`, `updated_by`, `updated_at`) VALUES
(1, 'Metro', 1, 1, '2019-03-18 19:45:14', NULL, '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `companyprofiles`
--

CREATE TABLE `companyprofiles` (
  `company_id` int(10) UNSIGNED NOT NULL,
  `company_name` text COLLATE utf8_unicode_ci NOT NULL,
  `address` text COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `web_address` text COLLATE utf8_unicode_ci NOT NULL,
  `return_policy` int(11) NOT NULL DEFAULT 0 COMMENT '0=No, 1=Yes',
  `max_inv_dis_percent` int(3) NOT NULL,
  `language` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `time_zone` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `print_recipt_a_sale` int(11) NOT NULL DEFAULT 0 COMMENT '0=No, 1=Yes',
  `quick_sending_receiving` int(11) NOT NULL DEFAULT 0,
  `theme` int(11) NOT NULL DEFAULT 0 COMMENT '0=style0, 1=style1, 2=style2, 3=style3',
  `back_date_sales` int(11) NOT NULL DEFAULT 0 COMMENT '1=yes,0=no',
  `back_date_purchase` int(11) NOT NULL COMMENT '1=yes,0=no',
  `back_date_return` int(11) NOT NULL COMMENT '1=yes,0=no',
  `install_complete` int(11) NOT NULL DEFAULT 0 COMMENT '0=No, 1=Yes',
  `year` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `companyprofiles`
--

INSERT INTO `companyprofiles` (`company_id`, `company_name`, `address`, `mobile`, `web_address`, `return_policy`, `max_inv_dis_percent`, `language`, `time_zone`, `print_recipt_a_sale`, `quick_sending_receiving`, `theme`, `back_date_sales`, `back_date_purchase`, `back_date_return`, `install_complete`, `year`, `created_at`, `updated_at`) VALUES
(1, 'Metro', 'Feni', '01800000000', 'metroandco.com', 1, 0, 'english', 'asia/dhaka', 0, 1, 0, 1, 0, 0, 1, 2015, '2015-12-08 15:47:23', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `cusduediscounts`
--

CREATE TABLE `cusduediscounts` (
  `c_due_discount_id` int(10) UNSIGNED NOT NULL,
  `c_due_payment_id` int(10) DEFAULT NULL,
  `cus_id` int(10) UNSIGNED NOT NULL,
  `amount` double(12,3) NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `cusduepayments`
--

CREATE TABLE `cusduepayments` (
  `c_due_payment_id` int(10) UNSIGNED NOT NULL,
  `cus_id` int(10) UNSIGNED NOT NULL,
  `payment_type_id` int(10) UNSIGNED NOT NULL,
  `amount` double(12,3) NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customerinfos`
--

CREATE TABLE `customerinfos` (
  `cus_id` int(10) UNSIGNED NOT NULL,
  `cus_card_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `cus_type_id` int(10) UNSIGNED NOT NULL,
  `full_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `present_address` text COLLATE utf8_unicode_ci NOT NULL,
  `shipping_address` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `password` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permanent_address` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `profile_image` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `national_id` bigint(20) DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `advance_payment` int(11) DEFAULT 0,
  `due` double DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `created_by` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `customertypes`
--

CREATE TABLE `customertypes` (
  `cus_type_id` int(10) UNSIGNED NOT NULL,
  `cus_type_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `discount_percent` double(12,3) NOT NULL,
  `point_unit` double(12,3) NOT NULL COMMENT 'per unit point =?',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `customertypes`
--

INSERT INTO `customertypes` (`cus_type_id`, `cus_type_name`, `discount_percent`, `point_unit`, `status`, `year`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Vip_Customer', 0.000, 0.000, 1, 0, 1, NULL, '2018-04-29 18:00:10', '0000-00-00 00:00:00'),
(2, 'Retail', 0.000, 0.000, 1, 0, 1, NULL, '2019-01-28 20:23:47', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `damageinvoices`
--

CREATE TABLE `damageinvoices` (
  `id` int(10) UNSIGNED NOT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL,
  `damage_invoice_id` varchar(14) NOT NULL,
  `amount` double(12,3) NOT NULL,
  `date` date NOT NULL,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '0=inactive, 1=active',
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `empinfos`
--

CREATE TABLE `empinfos` (
  `emp_id` int(10) UNSIGNED NOT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `role` int(11) NOT NULL DEFAULT 1 COMMENT '0=g_emp, 1=s_emp, 2=super_admin',
  `f_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `l_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `father_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `mother_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `remember_token` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `permanent_address` text COLLATE utf8_unicode_ci NOT NULL,
  `present_address` text COLLATE utf8_unicode_ci NOT NULL,
  `profile_image` text COLLATE utf8_unicode_ci NOT NULL,
  `national_id` bigint(20) NOT NULL,
  `fixed_salary` int(11) NOT NULL,
  `advance_salary` int(11) NOT NULL,
  `due_salary` int(11) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `active_session` tinyint(4) DEFAULT 0 COMMENT '0=hasn''t , 1 = has active session',
  `last_logged_ip` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `empinfos`
--

INSERT INTO `empinfos` (`emp_id`, `branch_id`, `role`, `f_name`, `l_name`, `father_name`, `mother_name`, `mobile`, `email`, `user_name`, `password`, `remember_token`, `permanent_address`, `present_address`, `profile_image`, `national_id`, `fixed_salary`, `advance_salary`, `due_salary`, `status`, `year`, `active_session`, `last_logged_ip`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'Super', 'Admin', 'Admin', 'Admin', '01800000000', 'admin@gmail.com', 'admin', '$2y$10$cKFNnSsz6CKSsJSpTUgu8ORpT0auJfiWWgPvvkYzX/2YQEtu4QGw.', 'QscXMBIENpLmgUu4XSOgvEaIgVBpnwCn8X39znrcTQMmgZVqFvs9sx0UZH0O', 'Dhaka', 'Dhaka', '', 1257489631, 10000, 0, 0, 1, 2015, 1, '192.168.0.101', 1, 1, '2015-12-08 15:47:23', '2019-04-04 16:31:58'),
(2, 2, 2, 'Admin2', '', 'Admin2', 'Admin2', '12457845454545', 'admin2@gmail.com', 'admin2', '$2y$10$9GAFB2A/U5TjZVgJYhNrHu7anrkEjVVUmcC2EZjL9wXzY3ZMZGEqq', 'bUOtwIcbAXNQl4FBNq7CcqH97ngHY5sDcZ9yHdIwKFxvDDQ3DJzG5s5ZrrBd', 'Dhaka', 'Dhaka', '', 0, 0, 0, 0, 0, 0, 0, '192.168.10.150', 1, 1, '2015-12-14 00:21:54', '2018-02-17 16:38:49'),
(3, 3, 2, 'Admin3', '', 'Admin3', 'Admin3', '123456789876', 'admin3@gmail.com', 'admin3', '$2y$10$9GAFB2A/U5TjZVgJYhNrHu7anrkEjVVUmcC2EZjL9wXzY3ZMZGEqq', 'p2ZZ2pGuSKRvgFpEvwkhG05tm5JNU18bNgL8QXK98vAor4o7wOmpMcbmeiQk', 'Dhaka', 'Dhaka', '', 0, 0, 0, 0, 0, 0, 0, '192.168.10.150', 1, 1, '2016-01-22 12:11:44', '2018-02-17 16:31:28'),
(4, 1, 1, 'Hamidur', 'Rahaman', '', '', '01232455454547', '', 'AZAD', '$2y$10$9GAFB2A/U5TjZVgJYhNrHu7anrkEjVVUmcC2EZjL9wXzY3ZMZGEqq', 'DizjBIw0OgiBlgMH0ayLbgdijrSEfUErOyp3qqoDtju8YWzlAM3ujpkiHK95', 'nil', '', '', 0, 0, 0, 0, 0, 0, 0, NULL, 1, 1, '2016-01-22 12:23:44', '2016-04-25 16:35:41'),
(5, 1, 1, 'asdd', 'ahmed', '', '', '2323', '', 'asdd', '$2y$10$9GAFB2A/U5TjZVgJYhNrHu7anrkEjVVUmcC2EZjL9wXzY3ZMZGEqq', 'UdLd6Y3DOQFUg3K5VHxL3g3EL0R6LgqUtgO8WrmcgYhOARXuJQwgBFxrrFNF', 'nil', 'nil', '', 0, 0, 0, 0, 0, 0, 0, NULL, 1, 1, '2016-01-23 12:51:43', '2016-04-25 16:36:59'),
(6, 1, 1, 'khaleq', 'abdul', '', '', '012345678912', '', 'Khaleq', '$2y$10$9GAFB2A/U5TjZVgJYhNrHu7anrkEjVVUmcC2EZjL9wXzY3ZMZGEqq', 'El3TpNhU169IBT0aDZrKoieQkmXNwGBun8WlNPlchRIZcZsk4wchtdBZxvZr', 'nil', 'nil', '', 0, 0, 0, 0, 0, 0, 0, NULL, 1, 1, '2016-01-23 13:02:04', '2016-03-29 09:37:28'),
(7, 1, 1, 'main', 'uddin', '', '', '0123456789456', '', 'mainuddin', '$2y$10$9GAFB2A/U5TjZVgJYhNrHu7anrkEjVVUmcC2EZjL9wXzY3ZMZGEqq', '6rkdtTRTLxCbGOOmmPrMr8InNyfcfjdhunRYIjGj0mLWz2eHevIIrPoBEou4', 'nil', 'nil', '', 0, 0, 0, 0, 0, 0, 0, NULL, 1, 1, '2016-01-23 14:43:27', '2016-03-29 13:00:18'),
(8, 1, 2, 'NIZAM', 'Uddin', 'Abul Kashem', 'Mamtaj Begum', '01682767535', 'azimuddin.248@gmail.com', 'azim', '$2y$10$9GAFB2A/U5TjZVgJYhNrHu7anrkEjVVUmcC2EZjL9wXzY3ZMZGEqq', '3CXwHVcBKGVBhCHeeL6eKEBiju1uDm6mBKu5c21uigu693pZRRXPj56PZ7sS', 'FCI', 'FCI', '', 0, 0, 0, 0, 0, 0, 0, NULL, 1, 1, '2016-01-24 09:29:04', '2016-03-07 21:33:22'),
(9, 1, 2, 'Habibur', 'RHAMAN', 'AAAAAAAAAAAAAAAAAA', 'BBBBBBBBBBBBB', '123456789012', '', 'HAB', '$2y$10$9GAFB2A/U5TjZVgJYhNrHu7anrkEjVVUmcC2EZjL9wXzY3ZMZGEqq', '', 'feni', 'feni', '', 0, 0, 0, 0, 0, 0, 0, NULL, 1, 1, '2016-01-25 09:27:59', '2016-03-07 10:53:27'),
(10, 1, 1, 'shiblu', 'shiblu', '', '', '01234567892', '', 'shiblu', '$2y$10$9GAFB2A/U5TjZVgJYhNrHu7anrkEjVVUmcC2EZjL9wXzY3ZMZGEqq', 'RdZmTs2NvKKWebJarfOyAK1XTJlW7C0LYvVHP5F7uf4I4ER67ZDKihmScheJ', '', '', '', 0, 0, 0, 0, 0, 0, 0, NULL, 1, 1, '2016-01-25 09:50:46', '2016-03-29 10:57:37'),
(11, 1, 1, 'Shahadat', 'Hossain', 'Shariat Ullah', 'Saera Khatun', '018301113471', 'abc@gmail.com', 'shahadat', '$2y$10$9GAFB2A/U5TjZVgJYhNrHu7anrkEjVVUmcC2EZjL9wXzY3ZMZGEqq', 'PU4Bw0Uon6gL9lv3IdqEo2YrdZ8udnd7Rjwd5WMyuYNCEKnfdNMz5cmM81Ck', 'Keroniya, Dagonbhuiyan,Feni', 'Keroniya, Dagonbhuiyan,Feni', '', 199400000000001, 5000, 0, 0, 0, 0, 0, NULL, 1, NULL, '2017-08-20 16:01:40', '2017-12-10 10:31:36'),
(12, 1, 1, 'Debabrata', 'Roy', 'Shcindranath Roy', 'Swapna Roy', '01761301421', 'dipuroy@gmail.com', 'dipu', '$2y$10$9GAFB2A/U5TjZVgJYhNrHu7anrkEjVVUmcC2EZjL9wXzY3ZMZGEqq', 'erCKe3ICC59Qhgx4I5owyyLofJ5CLTA0JNv4x0zkYkupPADFro9TuTfOQMzA', 'Feni', 'Feni', '', 19950000000000001, 100000, 0, 0, 0, 0, 0, NULL, 1, 1, '2017-08-20 17:00:13', '2017-12-08 12:57:41'),
(13, 1, 1, 'Parvin', 'Tazmin', 'Tajul Islam', 'Josnara Begum', '0168919124', 'homeplusfeni@gmail.com', 'tazmin', '$2y$10$9GAFB2A/U5TjZVgJYhNrHu7anrkEjVVUmcC2EZjL9wXzY3ZMZGEqq', '1dWSzKk8NpV6faAHlgZe4wsXRtoBOZLABoHLgkAVOLBV5ckbJ2eC2TQg67ZW', 'Feni', 'Feni', '', 10121012012012, 5000, 0, 0, 0, 0, 0, NULL, 1, NULL, '2017-08-20 20:53:40', '2017-08-28 22:21:39'),
(14, 1, 0, 'Sobuj', 'Ashek', 'Nurul Alam', 'Nilufa Eysmin', '21321636969691', 'abc@gmail.com', 'sobuj', '$2y$10$9GAFB2A/U5TjZVgJYhNrHu7anrkEjVVUmcC2EZjL9wXzY3ZMZGEqq', 'r736ovUuPeUCsWHWOChsao90C0zPJiMOVkYqSy93IWMhKQ3APpbxkNiZrRq4', 'Porshuram,feni', 'feni', '', 3222121321322, 5000, 0, 0, 0, 0, 0, '192.168.10.90', 1, NULL, '2017-08-20 21:01:04', '2018-01-18 12:13:16'),
(15, 1, 1, 'Mahfuzur', 'Rahman', 'Monir Ahmed', 'Rokeya Begum', '01838778546', 'abc@gmail.com', 'mahfuzur', '$2y$10$9GAFB2A/U5TjZVgJYhNrHu7anrkEjVVUmcC2EZjL9wXzY3ZMZGEqq', '1BMnxs1SbavJ22uTMStecO23DqVll3zGipKRwisf2Y0H2KBopNSF7lywaSAX', 'Feni', 'Feni', '', 1234567891234, 5000, 0, 0, 0, 0, 1, '192.168.10.90', 1, NULL, '2017-08-25 13:04:29', '2018-01-18 11:58:43'),
(18, 1, 1, 'Hasan', 'Ahmed', 'Null', 'Null', '0100000000', 'hasan@gmail.com', 'hasan', '$2y$10$D9/6XDC15XtkTzef/xOT1ughTRwXciqrwtpoNJuQ7/yO9GWFm983.', 'Xjr7IQisgDnRyEt3C9JC7R6rMlMtyUfE6wDYyyduqvWmBL4bYc7usJVEF0UD', 'Dhaka', 'Dhaka', '', 4587441254784, 8000, 0, 0, 0, 0, 1, '103.209.22.246', 1, NULL, '2018-03-21 16:06:14', '2018-04-07 11:31:31'),
(19, 0, 2, 'Super', 'Admin', 'Admin', 'Admin', '0180000000', 'superadmin@example.com', 'super_admin', '$2y$10$Po42XJObyhmtdeC4v00KceMbuzx.e2scWQJFwgKCB62teNtrkAlsW', '', 'Dhaka', 'Dhaka', '', 180000000, 1, 0, 0, 1, 0, 0, NULL, 1, NULL, '2018-04-02 16:47:41', '0000-00-00 00:00:00'),
(21, 0, 1, 'Md', 'Saiful', 'gahuyy', 'rethhh', '01712155000', 'outlet18@gmail.com', 'Saifu', '$2y$10$UUDtP8dkFdyIuA6KFtYH5Ox48/OCnc.NpDRJISR9gVBrbW.ySBdWS', '', 'jhhhh', 'fff', '', 10255555555, 6000, 0, 0, 0, 0, 0, NULL, 1, NULL, '2019-01-18 20:06:10', '0000-00-00 00:00:00'),
(22, 0, 1, 'Md', 'Sahazan', 'kalamnh', 'fathddjj', '013874888888', 'saha@gmail.com', 'adminsahazan', '$2y$10$QV7/j9CpHF/R81gpXXOQEeEBPRQqR6l6U1HTM7ZDLRduAGZ3qO6cG', '', 'hdhdd', 'diidkdkdk', '', 76888888886, 6000, 0, 0, 1, 0, 0, NULL, 1, NULL, '2019-01-23 18:39:53', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `empwisesalary`
--

CREATE TABLE `empwisesalary` (
  `id` int(11) NOT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL,
  `invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `emp_id` int(10) UNSIGNED NOT NULL,
  `amount` double(16,3) NOT NULL COMMENT 'payable amount',
  `due` double(16,3) UNSIGNED NOT NULL,
  `date` date NOT NULL,
  `salary_month` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `godownitems`
--

CREATE TABLE `godownitems` (
  `branch_id` int(10) UNSIGNED NOT NULL,
  `godown_item_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `price_id` int(10) UNSIGNED NOT NULL,
  `available_quantity` double(12,4) NOT NULL,
  `quantity_ability_flag` int(11) NOT NULL DEFAULT 1 COMMENT '0=quantity not available,  1=quentity available',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` int(10) UNSIGNED DEFAULT NULL COMMENT 'last item quantity increasing id',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sending_by` int(10) UNSIGNED DEFAULT NULL COMMENT 'last item sending id to stock',
  `sending_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `receiving_by` int(10) UNSIGNED DEFAULT NULL COMMENT 'last item receiving id from stock',
  `receiving_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `incomeexpensetype`
--

CREATE TABLE `incomeexpensetype` (
  `type_id` int(10) UNSIGNED NOT NULL,
  `type_name` varchar(50) NOT NULL,
  `used_for` int(1) NOT NULL COMMENT '1=for income, 2=for expense',
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '0=inactive, 1=active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_by` int(11) UNSIGNED NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` int(11) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='used for type setting of other income and other expense';

-- --------------------------------------------------------

--
-- Table structure for table `itembrands`
--

CREATE TABLE `itembrands` (
  `brand_id` int(10) UNSIGNED NOT NULL,
  `brand_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `offer` int(4) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `itembrands`
--

INSERT INTO `itembrands` (`brand_id`, `brand_name`, `offer`, `status`, `year`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Metro', 0, 1, 0, 2, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `itemcategorys`
--

CREATE TABLE `itemcategorys` (
  `category_id` int(10) UNSIGNED NOT NULL,
  `category_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `offer` int(4) NOT NULL DEFAULT 0,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `itemcategorys`
--

INSERT INTO `itemcategorys` (`category_id`, `category_name`, `offer`, `status`, `year`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Gents Shoes', 0, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `itemdamages`
--

CREATE TABLE `itemdamages` (
  `i_damage_id` int(10) UNSIGNED NOT NULL,
  `damage_invoice_id` varchar(14) NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `price_id` int(10) UNSIGNED NOT NULL,
  `quantity` double(12,4) NOT NULL,
  `amount` double(12,3) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `iteminfos`
--

CREATE TABLE `iteminfos` (
  `item_id` int(10) UNSIGNED NOT NULL,
  `company_id` int(10) UNSIGNED DEFAULT 0,
  `supplier_id` int(10) UNSIGNED DEFAULT 0,
  `item_company_id` int(10) UNSIGNED DEFAULT 0,
  `item_name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `upc_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `carton` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category_id` int(10) UNSIGNED NOT NULL,
  `brand_id` int(10) UNSIGNED DEFAULT NULL,
  `location_id` int(10) UNSIGNED DEFAULT NULL,
  `price_id` int(10) UNSIGNED NOT NULL,
  `unit` int(10) NOT NULL DEFAULT 1 COMMENT '1=pcs,2=doz,3=set',
  `tax_amount` double DEFAULT NULL COMMENT 'tax in percentage',
  `offer_type` int(1) UNSIGNED NOT NULL COMMENT '1=item,2=category,3=brand',
  `offer` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `itemlocations`
--

CREATE TABLE `itemlocations` (
  `location_id` int(11) UNSIGNED NOT NULL,
  `location_name` varchar(30) NOT NULL,
  `status` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `itempurchases`
--

CREATE TABLE `itempurchases` (
  `branch_id` int(10) UNSIGNED NOT NULL,
  `i_purchase_id` int(10) UNSIGNED NOT NULL,
  `sup_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `price_id` int(10) UNSIGNED NOT NULL,
  `quantity` double(12,4) NOT NULL,
  `discount` double(12,3) NOT NULL,
  `amount` double(12,3) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `itempurchases_order`
--

CREATE TABLE `itempurchases_order` (
  `i_purchase_id` int(10) UNSIGNED NOT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL,
  `sup_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `price_id` int(10) UNSIGNED NOT NULL,
  `quantity` double(12,4) NOT NULL,
  `discount` double(12,3) NOT NULL,
  `amount` double(12,3) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `itemsales`
--

CREATE TABLE `itemsales` (
  `branch_id` int(10) UNSIGNED NOT NULL,
  `i_sale_id` int(10) UNSIGNED NOT NULL,
  `sale_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `price_id` int(10) UNSIGNED NOT NULL,
  `quantity` double(12,4) NOT NULL,
  `discount` double(12,3) NOT NULL,
  `tax` double(12,3) NOT NULL,
  `amount` double(12,3) NOT NULL,
  `item_point` double(12,3) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `itemsales_order`
--

CREATE TABLE `itemsales_order` (
  `branch_id` int(10) UNSIGNED NOT NULL,
  `i_sale_id` int(10) UNSIGNED NOT NULL,
  `sale_order_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `item_id` int(10) UNSIGNED DEFAULT NULL,
  `price_id` int(10) UNSIGNED NOT NULL,
  `quantity` double(12,4) NOT NULL,
  `discount` double(12,3) UNSIGNED DEFAULT NULL,
  `tax` double(12,3) UNSIGNED DEFAULT NULL,
  `amount` double(12,3) UNSIGNED DEFAULT NULL,
  `item_point` double(12,3) UNSIGNED DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL DEFAULT 2018,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `loangottens`
--

CREATE TABLE `loangottens` (
  `loan_gotten_id` int(10) UNSIGNED NOT NULL,
  `company_person_name` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'it can be person or company name',
  `amount` double(12,3) NOT NULL,
  `reasion` text COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `pay_amount` double(12,3) NOT NULL DEFAULT 0.000 COMMENT 'will be update after each paid transaction',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1=not paid, 0=paid',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loanpays`
--

CREATE TABLE `loanpays` (
  `loan_pay_id` int(10) UNSIGNED NOT NULL,
  `company_person_name` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'it can be person or company name',
  `amount` double(12,3) NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1=Active, 0=Inactive',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loanprovides`
--

CREATE TABLE `loanprovides` (
  `loan_provide_id` int(10) UNSIGNED NOT NULL,
  `company_person_name` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'it can be person or company name',
  `amount` double(12,3) NOT NULL,
  `reasion` text COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `pay_amount` double(12,3) NOT NULL DEFAULT 0.000 COMMENT 'will be update after each paid transaction',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1=not paid, 0=paid',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loanreceives`
--

CREATE TABLE `loanreceives` (
  `loan_receive_id` int(10) UNSIGNED NOT NULL,
  `company_person_name` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'it can be person or company name',
  `amount` double(12,3) NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1=Active, 0=Inactive',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `moduleemppermissions`
--

CREATE TABLE `moduleemppermissions` (
  `module_emp_p_id` int(11) NOT NULL,
  `module_id` int(10) UNSIGNED NOT NULL,
  `emp_id` int(10) UNSIGNED NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `moduleemppermissions`
--

INSERT INTO `moduleemppermissions` (`module_emp_p_id`, `module_id`, `emp_id`, `status`, `year`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 0, 1, NULL, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(160, 1, 2, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(166, 1, 3, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(117, 1, 8, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(185, 1, 19, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(2, 2, 1, 1, 0, 1, NULL, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(3, 3, 1, 1, 0, 1, NULL, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(161, 3, 2, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(167, 3, 3, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(118, 3, 8, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(131, 3, 12, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(133, 3, 13, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(158, 3, 14, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(173, 3, 18, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(186, 3, 19, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(4, 4, 1, 1, 0, 0, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(162, 4, 2, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(168, 4, 3, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(119, 4, 8, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(187, 4, 19, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(5, 5, 1, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(17, 5, 2, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(26, 5, 3, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(78, 5, 8, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(89, 5, 9, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(150, 5, 12, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(136, 5, 14, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(174, 5, 18, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(188, 5, 19, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(6, 6, 1, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(18, 6, 2, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(27, 6, 3, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(79, 6, 8, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(90, 6, 9, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(146, 6, 12, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(137, 6, 14, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(175, 6, 18, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(189, 6, 19, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(7, 7, 1, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(114, 7, 2, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(115, 7, 3, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(124, 7, 4, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(116, 7, 8, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(125, 7, 9, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(155, 7, 14, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(176, 7, 18, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(190, 7, 19, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(8, 8, 1, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(19, 8, 2, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(28, 8, 3, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(80, 8, 8, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(138, 8, 14, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(177, 8, 18, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(191, 8, 19, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(9, 9, 1, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(163, 9, 2, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(126, 9, 3, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(38, 9, 4, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(49, 9, 5, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(60, 9, 6, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(70, 9, 7, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(120, 9, 8, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(103, 9, 10, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(128, 9, 11, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(132, 9, 12, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(134, 9, 13, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(145, 9, 15, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(178, 9, 18, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(192, 9, 19, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(10, 12, 1, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(164, 12, 2, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(169, 12, 3, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(82, 12, 8, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(93, 12, 9, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(147, 12, 12, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(141, 12, 13, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(156, 12, 14, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(183, 12, 18, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(193, 12, 19, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(11, 15, 1, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(24, 15, 2, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(31, 15, 3, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(121, 15, 8, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(94, 15, 9, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(139, 15, 14, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(179, 15, 18, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(194, 15, 19, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(12, 16, 1, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(22, 16, 2, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(32, 16, 3, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(112, 16, 4, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(122, 16, 8, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(148, 16, 12, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(143, 16, 14, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(180, 16, 18, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(195, 16, 19, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(13, 17, 1, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(23, 17, 2, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(33, 17, 3, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(113, 17, 4, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(123, 17, 8, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(149, 17, 12, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(151, 17, 14, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(181, 17, 18, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(196, 17, 19, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(14, 18, 1, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(110, 18, 2, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(111, 18, 3, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(43, 18, 4, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(54, 18, 5, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(65, 18, 6, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(75, 18, 7, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(86, 18, 8, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(97, 18, 9, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(108, 18, 10, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(154, 18, 11, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(153, 18, 15, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(182, 18, 18, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(197, 18, 19, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(15, 19, 1, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(165, 19, 2, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(170, 19, 3, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(87, 19, 8, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(157, 19, 14, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(184, 19, 18, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(198, 19, 19, 1, 0, 1, NULL, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(159, 20, 1, 1, 0, 1, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(171, 20, 2, 1, 0, 1, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(172, 20, 3, 1, 0, 1, 1, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `modulenames`
--

CREATE TABLE `modulenames` (
  `module_id` int(10) UNSIGNED NOT NULL,
  `module_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `module_url` text COLLATE utf8_unicode_ci NOT NULL,
  `icon` text COLLATE utf8_unicode_ci NOT NULL,
  `sorting` int(11) NOT NULL COMMENT 'For showing module with user define sequence',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `modulenames`
--

INSERT INTO `modulenames` (`module_id`, `module_name`, `module_url`, `icon`, `sorting`, `status`, `year`, `created_at`, `updated_at`) VALUES
(1, 'Permission', 'admin.permission', 'permission.png', 17, 1, 2015, '2015-02-19 18:11:23', '2015-02-19 18:11:23'),
(3, 'Dashboard', 'admin.dashboard', 'dashboard.png', 1, 0, 2015, '2015-02-19 18:11:23', '2015-02-19 18:11:23'),
(4, 'Employees', 'admin.EmployeeView', 'employees.png', 14, 1, 2015, '2015-02-19 18:11:23', '2015-02-19 18:11:23'),
(5, 'Items', 'admin.itemView', 'items.png', 2, 0, 2015, '2015-02-19 18:11:23', '2015-02-19 18:11:23'),
(6, 'Suppliers', 'admin.suppliers', 'suppliers.png', 4, 1, 2015, '2015-02-19 18:11:23', '2015-02-19 18:11:23'),
(7, 'Customers', 'admin.customer', 'customers.png', 5, 1, 2015, '2015-02-19 18:11:23', '2015-02-19 18:11:23'),
(8, 'Purchase', 'perchase.index', 'purchase.png', 6, 1, 2015, '2015-02-19 18:11:23', '2015-02-19 18:11:23'),
(9, 'Sales', 'sale.index', 'sales.png', 3, 1, 2015, '2015-02-19 18:11:23', '2015-02-19 18:11:23'),
(12, 'Reports', 'reports.index', 'reports.png', 10, 1, 2015, '2015-02-19 18:11:23', '2015-02-19 18:11:23'),
(14, 'Projects', 'projects', 'projects.png', 12, 1, 2015, '2015-02-19 18:11:23', '2015-02-19 18:11:23'),
(15, 'Setup', 'admin.setup', 'settings.png', 13, 1, 2015, '2015-02-19 18:11:23', '2015-02-19 18:11:23'),
(16, 'Sending', 'send', 'sending.png', 15, 1, 0, '2015-03-11 16:23:34', '0000-00-00 00:00:00'),
(17, 'Receiving', 'receive', 'receiving.png', 15, 1, 0, '2015-03-13 21:42:00', '0000-00-00 00:00:00'),
(18, 'Return', 'return.index', 'return.png', 16, 1, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(19, 'Others', 'other.index', 'other.png', 18, 1, 0, '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(20, 'Exports', 'export.index', 'export.png', 19, 1, 2018, '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `modulepermissions`
--

CREATE TABLE `modulepermissions` (
  `m_permission_id` int(11) NOT NULL,
  `module_id` int(10) UNSIGNED NOT NULL,
  `company_id` int(10) UNSIGNED NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `modulepermissions`
--

INSERT INTO `modulepermissions` (`m_permission_id`, `module_id`, `company_id`, `status`, `year`, `created_at`, `updated_at`) VALUES
(6, 1, 1, 1, 2015, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(2, 3, 1, 1, 2015, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(3, 4, 1, 1, 2015, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(4, 5, 1, 1, 2015, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(14, 6, 1, 1, 2015, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(1, 7, 1, 1, 2015, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(7, 8, 1, 1, 2015, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(11, 9, 1, 1, 2015, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(9, 12, 1, 1, 2015, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(13, 15, 1, 1, 2015, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(12, 16, 1, 1, 2015, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(8, 17, 1, 1, 2015, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(10, 18, 1, 1, 2015, '2015-12-08 15:47:23', '0000-00-00 00:00:00'),
(5, 19, 1, 1, 2015, '2015-12-08 15:47:23', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `otherexpenses`
--

CREATE TABLE `otherexpenses` (
  `branch_id` int(10) UNSIGNED NOT NULL,
  `other_expense_id` int(10) UNSIGNED NOT NULL,
  `expense_type_id` int(10) UNSIGNED NOT NULL,
  `amount` double(12,3) NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1=pending, 0=received',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `otherincomes`
--

CREATE TABLE `otherincomes` (
  `branch_id` int(10) UNSIGNED NOT NULL,
  `other_income_id` int(10) UNSIGNED NOT NULL,
  `income_type_id` int(11) UNSIGNED NOT NULL,
  `amount` double(12,3) NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1=pending, 0=received',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `paymenttypes`
--

CREATE TABLE `paymenttypes` (
  `payment_type_id` int(10) UNSIGNED NOT NULL,
  `payment_type_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `paymenttypes`
--

INSERT INTO `paymenttypes` (`payment_type_id`, `payment_type_name`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Cash', 1, 1, NULL, '2015-04-28 07:00:00', '0000-00-00 00:00:00'),
(2, 'Debit Card', 1, 1, NULL, '2015-04-28 15:00:00', '0000-00-00 00:00:00'),
(3, 'Credit Card', 1, 1, NULL, '2015-04-28 13:35:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `pointincreasingrecords`
--

CREATE TABLE `pointincreasingrecords` (
  `point_increasing_id` int(10) UNSIGNED NOT NULL,
  `cus_id` int(10) UNSIGNED NOT NULL,
  `no_of_point` int(11) NOT NULL,
  `sale_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1=Active, 0=Inactive',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pointusingrecords`
--

CREATE TABLE `pointusingrecords` (
  `point_using_id` int(10) UNSIGNED NOT NULL,
  `cus_id` int(10) UNSIGNED NOT NULL,
  `use_point` int(11) NOT NULL,
  `point_taka` int(11) NOT NULL,
  `benifited_way` int(11) NOT NULL DEFAULT 1 COMMENT '1=on item, 0=hand cash',
  `sale_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1=Active, 0=Inactive',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `priceinfos`
--

CREATE TABLE `priceinfos` (
  `price_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `purchase_price` double(12,2) NOT NULL,
  `sale_price` double(12,2) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- --------------------------------------------------------

--
-- Table structure for table `purchasereturntosupplier`
--

CREATE TABLE `purchasereturntosupplier` (
  `branch_id` int(10) UNSIGNED NOT NULL,
  `purchase_return_id` int(10) UNSIGNED NOT NULL,
  `sup_r_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `price_id` int(10) UNSIGNED NOT NULL,
  `quantity` double(12,4) NOT NULL,
  `discount` double(12,3) NOT NULL,
  `amount` double(12,3) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `receivingitems`
--

CREATE TABLE `receivingitems` (
  `branch_id` int(10) UNSIGNED NOT NULL,
  `receiving_item_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `price_id` int(10) UNSIGNED NOT NULL,
  `quantity` double NOT NULL,
  `sending_date` datetime NOT NULL,
  `receive_cancel_date` datetime NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0 = received 1 = pending, 2=cancelled',
  `year` int(11) NOT NULL,
  `sending_by` int(10) UNSIGNED NOT NULL,
  `receive_cancel_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `returnreceivingitems`
--

CREATE TABLE `returnreceivingitems` (
  `branch_id` int(10) UNSIGNED NOT NULL,
  `r_receiving_item_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `price_id` int(10) UNSIGNED NOT NULL,
  `quantity` double NOT NULL,
  `returning_date` datetime NOT NULL,
  `receive_cancel_date` datetime NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '1=pending, 0=received 2=cancle',
  `year` int(11) NOT NULL,
  `returning_by` int(10) UNSIGNED NOT NULL,
  `receive_cancel_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `saleinvoices`
--

CREATE TABLE `saleinvoices` (
  `id` int(11) NOT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL,
  `sale_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `cus_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'can be 0 for unregister customer',
  `payment_type_id` int(10) UNSIGNED NOT NULL,
  `discount` double(12,3) DEFAULT NULL,
  `total_point` double(12,3) DEFAULT NULL,
  `point_use_taka` int(11) NOT NULL,
  `amount` double NOT NULL COMMENT 'payable amount',
  `pay` double(12,3) NOT NULL,
  `due` double(12,3) NOT NULL,
  `pay_note` int(11) NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `saleinvoices_order`
--

CREATE TABLE `saleinvoices_order` (
  `id` int(11) NOT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL,
  `sale_order_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `cus_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'can be 0 for unregister customer',
  `payment_type_id` int(10) UNSIGNED NOT NULL,
  `discount` double(12,3) DEFAULT NULL,
  `total_point` double(12,3) DEFAULT NULL,
  `point_use_taka` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL COMMENT 'payable amount',
  `pay` double(12,3) DEFAULT NULL,
  `due` double(12,3) DEFAULT NULL,
  `pay_note` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL DEFAULT 2018,
  `created_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `salereturninvoices`
--

CREATE TABLE `salereturninvoices` (
  `id` int(11) NOT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL,
  `sale_r_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `sale_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `cus_id` int(11) UNSIGNED NOT NULL DEFAULT 0 COMMENT 'can be 0 for unregister customer',
  `payment_type_id` int(10) UNSIGNED NOT NULL,
  `amount` double(12,3) NOT NULL,
  `less_amount` double(12,3) NOT NULL COMMENT 'loss amount of customer for return',
  `transaction_date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `salereturntostocks`
--

CREATE TABLE `salereturntostocks` (
  `branch_id` int(10) UNSIGNED NOT NULL,
  `i_sale_return_id` int(10) UNSIGNED NOT NULL,
  `sale_r_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `price_id` int(10) UNSIGNED NOT NULL,
  `quantity` double(12,4) NOT NULL,
  `discount` double(12,3) NOT NULL,
  `tax` double(12,4) NOT NULL,
  `amount` double(12,3) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `smemppermissions`
--

CREATE TABLE `smemppermissions` (
  `s_m_emp_p_id` int(11) NOT NULL,
  `sub_module_id` int(10) UNSIGNED NOT NULL,
  `emp_id` int(10) UNSIGNED NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `stockitems`
--

CREATE TABLE `stockitems` (
  `stock_item_id` int(10) UNSIGNED NOT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL,
  `item_id` int(10) UNSIGNED NOT NULL,
  `price_id` int(10) UNSIGNED NOT NULL,
  `available_quantity` double(12,2) NOT NULL,
  `quantity_ability_flag` int(11) NOT NULL DEFAULT 1 COMMENT '0=quantity not available,  1=quentity available',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=quantity not available,  1=quentity available',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sending_by` int(10) UNSIGNED DEFAULT NULL,
  `sending_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `receiving_by` int(10) UNSIGNED DEFAULT NULL,
  `receiving_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `submodulenames`
--

CREATE TABLE `submodulenames` (
  `sub_module_id` int(10) UNSIGNED NOT NULL,
  `sub_module_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `module_id` int(10) UNSIGNED NOT NULL,
  `sub_module_url` text COLLATE utf8_unicode_ci NOT NULL,
  `sub_module_icon` text COLLATE utf8_unicode_ci NOT NULL,
  `sorting` int(11) NOT NULL COMMENT 'For showing sub module with user define sequence',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sub_companies`
--

CREATE TABLE `sub_companies` (
  `id` int(11) NOT NULL,
  `company_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `sub_companies`
--

INSERT INTO `sub_companies` (`id`, `company_name`, `status`) VALUES
(1, 'Metro and Co', 1);

-- --------------------------------------------------------

--
-- Table structure for table `supduepayments`
--

CREATE TABLE `supduepayments` (
  `s_due_payment_id` int(10) UNSIGNED NOT NULL,
  `supp_id` int(10) UNSIGNED NOT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL,
  `payment_type_id` int(10) UNSIGNED NOT NULL,
  `amount` double(12,3) NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supinvoices`
--

CREATE TABLE `supinvoices` (
  `id` int(11) NOT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL,
  `sup_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `sup_memo_no` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `supp_id` int(10) UNSIGNED DEFAULT 0 COMMENT '0 means unregistrad customer',
  `payment_type_id` int(10) UNSIGNED NOT NULL,
  `discount` double(12,3) NOT NULL,
  `amount` double NOT NULL COMMENT 'payable amount',
  `pay` double(12,3) NOT NULL,
  `due` double(12,3) NOT NULL,
  `transaction_date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) DEFAULT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `supinvoices_order`
--

CREATE TABLE `supinvoices_order` (
  `id` int(11) NOT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL,
  `sup_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `sup_memo_no` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `supp_id` int(10) UNSIGNED DEFAULT 0 COMMENT '0 means unregistrad customer',
  `payment_type_id` int(10) UNSIGNED NOT NULL,
  `discount` double(12,3) NOT NULL,
  `amount` double NOT NULL COMMENT 'payable amount',
  `pay` double(12,3) NOT NULL,
  `due` double(12,3) NOT NULL,
  `transaction_date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `supplierduediscounts`
--

CREATE TABLE `supplierduediscounts` (
  `s_due_discount_id` int(10) UNSIGNED NOT NULL,
  `s_due_payment_id` int(10) DEFAULT NULL,
  `supp_id` int(10) UNSIGNED NOT NULL,
  `amount` double(12,3) NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- --------------------------------------------------------

--
-- Table structure for table `supplierinfos`
--

CREATE TABLE `supplierinfos` (
  `supp_id` int(10) UNSIGNED NOT NULL,
  `supp_or_comp_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `password` varchar(256) COLLATE utf8_unicode_ci NOT NULL,
  `permanent_address` text COLLATE utf8_unicode_ci NOT NULL,
  `present_address` text COLLATE utf8_unicode_ci NOT NULL,
  `profile_image` text COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `advance_payment` int(11) NOT NULL COMMENT 'Shop advance payment',
  `due` int(11) NOT NULL COMMENT 'Shop liabilities',
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Dumping data for table `supplierinfos`
--

INSERT INTO `supplierinfos` (`supp_id`, `supp_or_comp_name`, `user_name`, `password`, `permanent_address`, `present_address`, `profile_image`, `mobile`, `email`, `advance_payment`, `due`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 'Metro and Co.', 'metro_and_co', '', '', '', '', '0125', 'metro@gmail.com', 0, 0, 1, 1, 1, '2018-04-15 17:47:46', '2019-01-28 20:12:10');

-- --------------------------------------------------------

--
-- Table structure for table `supplierreturninvoices`
--

CREATE TABLE `supplierreturninvoices` (
  `id` int(11) NOT NULL,
  `branch_id` int(10) UNSIGNED NOT NULL,
  `sup_r_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `sup_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `supp_id` int(10) UNSIGNED NOT NULL,
  `payment_type_id` int(10) UNSIGNED NOT NULL,
  `amount` double(12,3) NOT NULL,
  `less_amount` double(12,3) NOT NULL COMMENT 'loss amount of customer for return',
  `transaction_date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1 COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) UNSIGNED NOT NULL,
  `updated_by` int(10) UNSIGNED DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `urlemppermissions`
--

CREATE TABLE `urlemppermissions` (
  `url_emp_p_id` int(10) UNSIGNED NOT NULL,
  `url_id` int(10) UNSIGNED NOT NULL,
  `emp_id` int(10) UNSIGNED NOT NULL,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '0 = inactive 1 = active',
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `urlemppermissions`
--

INSERT INTO `urlemppermissions` (`url_emp_p_id`, `url_id`, `emp_id`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, 0, NULL, '2015-12-08 21:51:27', '0000-00-00 00:00:00'),
(2, 2, 1, 1, 1, NULL, '2015-12-08 21:53:53', '0000-00-00 00:00:00'),
(3, 3, 1, 1, 1, NULL, '2015-12-08 21:53:53', '0000-00-00 00:00:00'),
(4, 4, 1, 1, 1, NULL, '2015-12-08 21:53:53', '0000-00-00 00:00:00'),
(5, 5, 1, 1, 1, NULL, '2015-12-08 21:53:53', '0000-00-00 00:00:00'),
(6, 7, 1, 1, 1, NULL, '2015-12-08 21:53:53', '0000-00-00 00:00:00'),
(7, 8, 1, 1, 1, NULL, '2015-12-08 21:53:53', '0000-00-00 00:00:00'),
(8, 9, 1, 1, 1, NULL, '2015-12-08 21:53:53', '0000-00-00 00:00:00'),
(9, 10, 1, 1, 1, NULL, '2015-12-08 21:53:53', '0000-00-00 00:00:00'),
(10, 11, 1, 1, 1, NULL, '2015-12-08 21:53:53', '0000-00-00 00:00:00'),
(11, 1, 2, 1, 1, NULL, '2015-12-13 16:23:58', '0000-00-00 00:00:00'),
(12, 2, 2, 1, 1, NULL, '2015-12-13 16:23:58', '0000-00-00 00:00:00'),
(13, 3, 2, 1, 1, NULL, '2015-12-13 16:23:58', '0000-00-00 00:00:00'),
(14, 4, 2, 1, 1, NULL, '2015-12-13 16:23:58', '0000-00-00 00:00:00'),
(15, 5, 2, 1, 1, NULL, '2015-12-13 16:23:58', '0000-00-00 00:00:00'),
(18, 9, 2, 1, 1, NULL, '2015-12-13 16:23:58', '0000-00-00 00:00:00'),
(19, 10, 2, 1, 1, NULL, '2015-12-13 16:23:58', '0000-00-00 00:00:00'),
(21, 1, 3, 1, 1, NULL, '2016-01-23 08:12:13', '0000-00-00 00:00:00'),
(22, 2, 3, 1, 1, NULL, '2016-01-23 08:12:13', '0000-00-00 00:00:00'),
(23, 3, 3, 1, 1, NULL, '2016-01-23 08:12:13', '0000-00-00 00:00:00'),
(24, 4, 3, 1, 1, NULL, '2016-01-23 08:12:13', '0000-00-00 00:00:00'),
(25, 5, 3, 1, 1, NULL, '2016-01-23 08:12:13', '0000-00-00 00:00:00'),
(28, 9, 3, 1, 1, NULL, '2016-01-23 08:12:13', '0000-00-00 00:00:00'),
(29, 10, 3, 1, 1, NULL, '2016-01-23 08:12:13', '0000-00-00 00:00:00'),
(37, 8, 4, 1, 1, NULL, '2016-01-23 08:24:11', '0000-00-00 00:00:00'),
(40, 11, 4, 1, 1, NULL, '2016-01-23 08:24:12', '0000-00-00 00:00:00'),
(47, 8, 5, 1, 1, NULL, '2016-01-24 08:52:08', '0000-00-00 00:00:00'),
(50, 11, 5, 1, 1, NULL, '2016-01-24 08:52:08', '0000-00-00 00:00:00'),
(57, 8, 6, 1, 1, NULL, '2016-01-24 09:02:23', '0000-00-00 00:00:00'),
(60, 11, 6, 1, 1, NULL, '2016-01-24 09:02:23', '0000-00-00 00:00:00'),
(67, 8, 7, 1, 1, NULL, '2016-01-24 10:43:46', '0000-00-00 00:00:00'),
(70, 11, 7, 1, 1, NULL, '2016-01-24 10:43:46', '0000-00-00 00:00:00'),
(71, 1, 8, 1, 1, NULL, '2016-01-25 05:31:26', '0000-00-00 00:00:00'),
(72, 2, 8, 1, 1, NULL, '2016-01-25 05:31:26', '0000-00-00 00:00:00'),
(73, 3, 8, 1, 1, NULL, '2016-01-25 05:31:26', '0000-00-00 00:00:00'),
(74, 4, 8, 1, 1, NULL, '2016-01-25 05:31:26', '0000-00-00 00:00:00'),
(75, 5, 8, 1, 1, NULL, '2016-01-25 05:31:26', '0000-00-00 00:00:00'),
(76, 7, 8, 1, 1, NULL, '2016-01-25 05:31:26', '0000-00-00 00:00:00'),
(77, 8, 8, 1, 1, NULL, '2016-01-25 05:31:26', '0000-00-00 00:00:00'),
(78, 9, 8, 1, 1, NULL, '2016-01-25 05:31:26', '0000-00-00 00:00:00'),
(79, 10, 8, 1, 1, NULL, '2016-01-25 05:31:26', '0000-00-00 00:00:00'),
(80, 11, 8, 1, 1, NULL, '2016-01-25 05:31:26', '0000-00-00 00:00:00'),
(81, 1, 9, 1, 1, NULL, '2016-01-26 05:28:24', '0000-00-00 00:00:00'),
(82, 2, 9, 1, 1, NULL, '2016-01-26 05:28:24', '0000-00-00 00:00:00'),
(83, 3, 9, 1, 1, NULL, '2016-01-26 05:28:24', '0000-00-00 00:00:00'),
(84, 4, 9, 1, 1, NULL, '2016-01-26 05:28:24', '0000-00-00 00:00:00'),
(85, 5, 9, 1, 1, NULL, '2016-01-26 05:28:24', '0000-00-00 00:00:00'),
(86, 7, 9, 1, 1, NULL, '2016-01-26 05:28:24', '0000-00-00 00:00:00'),
(87, 8, 9, 1, 1, NULL, '2016-01-26 05:28:24', '0000-00-00 00:00:00'),
(88, 9, 9, 1, 1, NULL, '2016-01-26 05:28:24', '0000-00-00 00:00:00'),
(89, 10, 9, 1, 1, NULL, '2016-01-26 05:28:24', '0000-00-00 00:00:00'),
(90, 11, 9, 1, 1, NULL, '2016-01-26 05:28:24', '0000-00-00 00:00:00'),
(97, 8, 10, 1, 1, NULL, '2016-01-26 05:51:09', '0000-00-00 00:00:00'),
(100, 11, 10, 1, 1, NULL, '2016-01-26 05:51:09', '0000-00-00 00:00:00'),
(101, 1, 4, 1, 1, NULL, '2016-01-29 09:12:20', '0000-00-00 00:00:00'),
(102, 2, 4, 1, 1, NULL, '2016-01-29 09:12:20', '0000-00-00 00:00:00'),
(103, 3, 4, 1, 1, NULL, '2016-01-29 09:12:20', '0000-00-00 00:00:00'),
(104, 4, 4, 1, 1, NULL, '2016-01-29 09:12:20', '0000-00-00 00:00:00'),
(105, 7, 4, 1, 1, NULL, '2016-01-29 09:12:21', '0000-00-00 00:00:00'),
(106, 9, 4, 1, 1, NULL, '2016-01-29 09:12:21', '0000-00-00 00:00:00'),
(109, 11, 11, 1, 1, NULL, '2017-08-20 22:02:05', '0000-00-00 00:00:00'),
(110, 11, 12, 1, 1, NULL, '2017-08-20 23:01:21', '0000-00-00 00:00:00'),
(111, 11, 13, 1, 1, NULL, '2017-08-21 02:57:22', '0000-00-00 00:00:00'),
(112, 1, 14, 1, 1, NULL, '2017-08-21 03:02:38', '0000-00-00 00:00:00'),
(116, 8, 15, 1, 1, NULL, '2017-08-25 19:05:15', '0000-00-00 00:00:00'),
(117, 1, 12, 1, 1, NULL, '2017-08-28 04:49:25', '0000-00-00 00:00:00'),
(118, 2, 12, 1, 1, NULL, '2017-08-28 04:49:25', '0000-00-00 00:00:00'),
(119, 3, 12, 1, 1, NULL, '2017-08-28 04:49:25', '0000-00-00 00:00:00'),
(120, 4, 12, 1, 1, NULL, '2017-08-28 04:49:25', '0000-00-00 00:00:00'),
(121, 8, 11, 1, 1, NULL, '2017-11-19 19:45:35', '0000-00-00 00:00:00'),
(122, 2, 14, 1, 1, NULL, '2017-12-12 02:26:35', '0000-00-00 00:00:00'),
(123, 4, 14, 1, 1, NULL, '2017-12-12 02:26:35', '0000-00-00 00:00:00'),
(124, 5, 14, 1, 1, NULL, '2017-12-12 02:26:35', '0000-00-00 00:00:00'),
(125, 7, 14, 1, 1, NULL, '2017-12-12 02:26:35', '0000-00-00 00:00:00'),
(126, 3, 14, 1, 1, NULL, '2017-12-12 02:30:32', '0000-00-00 00:00:00'),
(127, 8, 14, 1, 1, NULL, '2017-12-12 02:30:32', '0000-00-00 00:00:00'),
(128, 9, 14, 1, 1, NULL, '2017-12-12 02:30:32', '0000-00-00 00:00:00'),
(129, 10, 14, 1, 1, NULL, '2017-12-12 02:30:32', '0000-00-00 00:00:00'),
(130, 11, 14, 1, 1, NULL, '2017-12-12 02:30:32', '0000-00-00 00:00:00'),
(131, 7, 2, 1, 1, NULL, '2018-02-17 22:26:39', '0000-00-00 00:00:00'),
(132, 8, 2, 1, 1, NULL, '2018-02-17 22:26:39', '0000-00-00 00:00:00'),
(133, 11, 2, 1, 1, NULL, '2018-02-17 22:26:39', '0000-00-00 00:00:00'),
(134, 7, 3, 1, 1, NULL, '2018-02-17 22:28:47', '0000-00-00 00:00:00'),
(135, 8, 3, 1, 1, NULL, '2018-02-17 22:28:47', '0000-00-00 00:00:00'),
(136, 11, 3, 1, 1, NULL, '2018-02-17 22:28:47', '0000-00-00 00:00:00'),
(137, 1, 18, 1, 1, NULL, '2018-03-21 16:06:46', '0000-00-00 00:00:00'),
(138, 2, 18, 1, 1, NULL, '2018-03-21 16:06:46', '0000-00-00 00:00:00'),
(139, 3, 18, 1, 1, NULL, '2018-03-21 16:06:46', '0000-00-00 00:00:00'),
(140, 4, 18, 1, 1, NULL, '2018-03-21 16:06:46', '0000-00-00 00:00:00'),
(141, 5, 18, 1, 1, NULL, '2018-03-21 16:06:46', '0000-00-00 00:00:00'),
(142, 7, 18, 1, 1, NULL, '2018-03-21 16:06:46', '0000-00-00 00:00:00'),
(143, 8, 18, 1, 1, NULL, '2018-03-21 16:06:46', '0000-00-00 00:00:00'),
(144, 9, 18, 1, 1, NULL, '2018-03-21 16:06:46', '0000-00-00 00:00:00'),
(145, 10, 18, 1, 1, NULL, '2018-03-21 16:06:46', '0000-00-00 00:00:00'),
(146, 11, 18, 1, 1, NULL, '2018-03-21 16:06:46', '0000-00-00 00:00:00'),
(147, 1, 19, 1, 1, NULL, '2018-04-02 16:48:06', '0000-00-00 00:00:00'),
(148, 2, 19, 1, 1, NULL, '2018-04-02 16:48:06', '0000-00-00 00:00:00'),
(149, 3, 19, 1, 1, NULL, '2018-04-02 16:48:06', '0000-00-00 00:00:00'),
(150, 4, 19, 1, 1, NULL, '2018-04-02 16:48:06', '0000-00-00 00:00:00'),
(151, 5, 19, 1, 1, NULL, '2018-04-02 16:48:06', '0000-00-00 00:00:00'),
(152, 7, 19, 1, 1, NULL, '2018-04-02 16:48:06', '0000-00-00 00:00:00'),
(153, 8, 19, 1, 1, NULL, '2018-04-02 16:48:06', '0000-00-00 00:00:00'),
(154, 9, 19, 1, 1, NULL, '2018-04-02 16:48:06', '0000-00-00 00:00:00'),
(155, 10, 19, 1, 1, NULL, '2018-04-02 16:48:06', '0000-00-00 00:00:00'),
(156, 11, 19, 1, 1, NULL, '2018-04-02 16:48:06', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `urlnamepermissions`
--

CREATE TABLE `urlnamepermissions` (
  `url_permission_id` int(10) UNSIGNED NOT NULL,
  `url_id` int(10) UNSIGNED NOT NULL,
  `company_id` int(10) UNSIGNED NOT NULL,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '0 = inactive 1 = active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `urlnamepermissions`
--

INSERT INTO `urlnamepermissions` (`url_permission_id`, `url_id`, `company_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 1, '2015-04-26 18:30:14', NULL),
(2, 2, 1, 1, '2015-04-26 18:30:14', NULL),
(3, 3, 1, 1, '2015-04-26 18:30:32', NULL),
(4, 4, 1, 1, '2015-04-26 18:30:32', NULL),
(5, 5, 1, 1, '2015-05-02 06:31:44', NULL),
(6, 7, 0, 1, '2015-05-02 06:31:44', NULL),
(7, 8, 1, 1, '2015-05-02 06:32:49', NULL),
(8, 9, 1, 1, '2015-05-06 17:50:31', NULL),
(9, 10, 1, 1, '2015-05-06 17:50:31', NULL),
(10, 11, 1, 1, '2015-05-31 10:24:24', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `urlnames`
--

CREATE TABLE `urlnames` (
  `url_id` int(11) UNSIGNED NOT NULL,
  `url_name` varchar(30) NOT NULL,
  `url_address` varchar(50) NOT NULL,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '0 = inactive 1 = active',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `urlnames`
--

INSERT INTO `urlnames` (`url_id`, `url_name`, `url_address`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Add new Item', 'admin.itemAddForm', 1, '2015-04-07 10:37:01', '0000-00-00 00:00:00'),
(2, 'Barcode Print', 'barcode.post', 1, '2015-04-07 10:38:34', '0000-00-00 00:00:00'),
(3, 'WareHouse Items View', 'admin.godownItem', 1, '2015-04-07 10:47:44', '0000-00-00 00:00:00'),
(4, 'Recently Added Item', 'admin.getRecentItems', 1, '2015-04-07 10:45:18', '0000-00-00 00:00:00'),
(5, 'Damage Products', 'damage.index', 1, '2015-05-02 06:25:26', NULL),
(7, 'Return to WareHouse', 'send.returnToGodown', 1, '2015-05-02 06:25:51', NULL),
(8, 'Sales Return -Customer', 'saleReturn.index', 1, '2015-05-02 06:26:18', NULL),
(9, 'Return Receive', 'returnReceive', 1, '2015-05-06 17:49:45', NULL),
(10, 'Purchase Return to Supplier', 'purchase.returnToSupplier', 1, '2015-05-06 17:49:45', NULL),
(11, 'Item wise Return from customer', 'admin.returnQtyFromCustomer', 1, '2015-05-31 10:23:23', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `branch_info`
--
ALTER TABLE `branch_info`
  ADD PRIMARY KEY (`branch_id`);

--
-- Indexes for table `companynames`
--
ALTER TABLE `companynames`
  ADD PRIMARY KEY (`company_id`),
  ADD UNIQUE KEY `company_name` (`company_name`),
  ADD KEY `FK_companynames_empinfos` (`created_by`),
  ADD KEY `FK_companynames_empinfos_2` (`updated_by`),
  ADD KEY `company_id` (`company_id`);

--
-- Indexes for table `companyprofiles`
--
ALTER TABLE `companyprofiles`
  ADD UNIQUE KEY `company_id` (`company_id`);

--
-- Indexes for table `cusduediscounts`
--
ALTER TABLE `cusduediscounts`
  ADD UNIQUE KEY `c_due_payment_id` (`c_due_discount_id`),
  ADD KEY `cusduepayments_c_due_payment_id_index` (`c_due_discount_id`),
  ADD KEY `cusduepayments_cus_id_foreign` (`cus_id`),
  ADD KEY `cusduepayments_created_by_foreign` (`created_by`),
  ADD KEY `cusduepayments_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `cusduepayments`
--
ALTER TABLE `cusduepayments`
  ADD UNIQUE KEY `c_due_payment_id` (`c_due_payment_id`),
  ADD KEY `cusduepayments_c_due_payment_id_index` (`c_due_payment_id`),
  ADD KEY `cusduepayments_cus_id_foreign` (`cus_id`),
  ADD KEY `cusduepayments_payment_type_id_foreign` (`payment_type_id`),
  ADD KEY `cusduepayments_created_by_foreign` (`created_by`),
  ADD KEY `cusduepayments_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `customerinfos`
--
ALTER TABLE `customerinfos`
  ADD UNIQUE KEY `customerinfos_user_name_unique` (`user_name`),
  ADD UNIQUE KEY `cus_id` (`cus_id`),
  ADD UNIQUE KEY `customerinfos_cus_card_id_unique` (`cus_card_id`),
  ADD UNIQUE KEY `national_id` (`national_id`),
  ADD KEY `customerinfos_cus_id_index` (`cus_id`),
  ADD KEY `customerinfos_cus_type_id_foreign` (`cus_type_id`),
  ADD KEY `customerinfos_created_by_foreign` (`created_by`),
  ADD KEY `customerinfos_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `customertypes`
--
ALTER TABLE `customertypes`
  ADD UNIQUE KEY `cus_type_id` (`cus_type_id`),
  ADD UNIQUE KEY `cus_type_name` (`cus_type_name`),
  ADD KEY `customertypes_cus_type_id_index` (`cus_type_id`),
  ADD KEY `customertypes_created_by_foreign` (`created_by`),
  ADD KEY `customertypes_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `damageinvoices`
--
ALTER TABLE `damageinvoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `damage_invoice_id` (`damage_invoice_id`),
  ADD KEY `FK_damageinvoices_empinfos` (`created_by`),
  ADD KEY `FK_damageinvoices_empinfos_2` (`updated_by`),
  ADD KEY `FK_damageinvoices_branch_info` (`branch_id`);

--
-- Indexes for table `empinfos`
--
ALTER TABLE `empinfos`
  ADD UNIQUE KEY `emp_id` (`emp_id`),
  ADD UNIQUE KEY `empinfos_user_name_unique` (`user_name`),
  ADD KEY `empinfos_emp_id_index` (`emp_id`),
  ADD KEY `empinfos_created_by_foreign` (`created_by`),
  ADD KEY `empinfos_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `empwisesalary`
--
ALTER TABLE `empwisesalary`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sale_invoice_id` (`invoice_id`),
  ADD KEY `saleinvoices_created_by_foreign` (`emp_id`),
  ADD KEY `saleinvoices_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_empwisesalary_empinfos` (`created_by`),
  ADD KEY `FK_empwisesalary_branch_info` (`branch_id`);

--
-- Indexes for table `godownitems`
--
ALTER TABLE `godownitems`
  ADD PRIMARY KEY (`item_id`,`price_id`),
  ADD UNIQUE KEY `godown_item_id` (`godown_item_id`),
  ADD KEY `godownitems_godown_item_id_index` (`godown_item_id`),
  ADD KEY `godownitems_price_id_foreign` (`price_id`),
  ADD KEY `godownitems_created_by_foreign` (`created_by`),
  ADD KEY `godownitems_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_godownitems_empinfos` (`sending_by`),
  ADD KEY `FK_godownitems_empinfos_2` (`receiving_by`),
  ADD KEY `FK_godownitems_branch_info` (`branch_id`);

--
-- Indexes for table `incomeexpensetype`
--
ALTER TABLE `incomeexpensetype`
  ADD PRIMARY KEY (`type_id`),
  ADD UNIQUE KEY `type_name` (`type_name`),
  ADD KEY `FK_incomeexpensetype_empinfos` (`created_by`),
  ADD KEY `FK_incomeexpensetype_empinfos_2` (`updated_by`);

--
-- Indexes for table `itembrands`
--
ALTER TABLE `itembrands`
  ADD UNIQUE KEY `brand_id` (`brand_id`),
  ADD UNIQUE KEY `itembrands_brand_name_unique` (`brand_name`),
  ADD KEY `itembrands_brand_id_index` (`brand_id`),
  ADD KEY `itembrands_created_by_foreign` (`created_by`),
  ADD KEY `itembrands_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `itemcategorys`
--
ALTER TABLE `itemcategorys`
  ADD UNIQUE KEY `category_id` (`category_id`),
  ADD UNIQUE KEY `itemcategorys_category_name_unique` (`category_name`),
  ADD KEY `itemcategorys_category_id_index` (`category_id`),
  ADD KEY `itemcategorys_created_by_foreign` (`created_by`),
  ADD KEY `itemcategorys_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `itemdamages`
--
ALTER TABLE `itemdamages`
  ADD PRIMARY KEY (`i_damage_id`),
  ADD KEY `FK_itemdamages_empinfos` (`created_by`),
  ADD KEY `FK_itemdamages_iteminfos` (`item_id`),
  ADD KEY `FK_itemdamages_empinfos_2` (`updated_by`),
  ADD KEY `FK_itemdamages_priceinfos` (`price_id`),
  ADD KEY `damageinvoices_itemdamages` (`damage_invoice_id`);

--
-- Indexes for table `iteminfos`
--
ALTER TABLE `iteminfos`
  ADD UNIQUE KEY `item_id` (`item_id`),
  ADD UNIQUE KEY `item_name` (`item_name`),
  ADD UNIQUE KEY `upc_code` (`upc_code`),
  ADD KEY `iteminfos_item_id_index` (`item_id`),
  ADD KEY `iteminfos_category_id_foreign` (`category_id`),
  ADD KEY `iteminfos_brand_id_foreign` (`brand_id`),
  ADD KEY `iteminfos_created_by_foreign` (`created_by`),
  ADD KEY `iteminfos_updated_by_foreign` (`updated_by`),
  ADD KEY `location_id` (`location_id`);

--
-- Indexes for table `itemlocations`
--
ALTER TABLE `itemlocations`
  ADD PRIMARY KEY (`location_id`),
  ADD UNIQUE KEY `location_name` (`location_name`),
  ADD KEY `FK_itemlocations_empinfos_2` (`updated_by`),
  ADD KEY `FK_itemlocations_empinfos` (`created_by`);

--
-- Indexes for table `itempurchases`
--
ALTER TABLE `itempurchases`
  ADD UNIQUE KEY `i_purchase_id` (`i_purchase_id`),
  ADD KEY `itempurchases_i_purchase_id_index` (`i_purchase_id`),
  ADD KEY `itempurchases_sup_invoice_id_foreign` (`sup_invoice_id`),
  ADD KEY `itempurchases_item_id_foreign` (`item_id`),
  ADD KEY `itempurchases_price_id_foreign` (`price_id`),
  ADD KEY `itempurchases_created_by_foreign` (`created_by`),
  ADD KEY `itempurchases_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_itempurchases_branch_info` (`branch_id`);

--
-- Indexes for table `itempurchases_order`
--
ALTER TABLE `itempurchases_order`
  ADD UNIQUE KEY `i_purchase_id` (`i_purchase_id`),
  ADD KEY `itempurchases_i_purchase_id_index` (`i_purchase_id`),
  ADD KEY `itempurchases_sup_invoice_id_foreign` (`sup_invoice_id`),
  ADD KEY `itempurchases_item_id_foreign` (`item_id`),
  ADD KEY `itempurchases_price_id_foreign` (`price_id`),
  ADD KEY `itempurchases_created_by_foreign` (`created_by`),
  ADD KEY `itempurchases_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_itempurchases_order_branch_info` (`branch_id`);

--
-- Indexes for table `itemsales`
--
ALTER TABLE `itemsales`
  ADD UNIQUE KEY `i_sale_id` (`i_sale_id`),
  ADD KEY `itemsales_i_sale_id_index` (`i_sale_id`),
  ADD KEY `itemsales_sale_invoice_id_foreign` (`sale_invoice_id`),
  ADD KEY `itemsales_item_id_foreign` (`item_id`),
  ADD KEY `itemsales_price_id_foreign` (`price_id`),
  ADD KEY `itemsales_created_by_foreign` (`created_by`),
  ADD KEY `itemsales_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_itemsales_branch_info` (`branch_id`);

--
-- Indexes for table `itemsales_order`
--
ALTER TABLE `itemsales_order`
  ADD UNIQUE KEY `i_sale_id` (`i_sale_id`),
  ADD KEY `itemsales_i_sale_id_index` (`i_sale_id`),
  ADD KEY `itemsales_sale_invoice_id_foreign` (`sale_order_invoice_id`),
  ADD KEY `itemsales_item_id_foreign` (`item_id`),
  ADD KEY `itemsales_price_id_foreign` (`price_id`),
  ADD KEY `itemsales_created_by_foreign` (`created_by`),
  ADD KEY `itemsales_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_itemsales_branch_info` (`branch_id`);

--
-- Indexes for table `loangottens`
--
ALTER TABLE `loangottens`
  ADD UNIQUE KEY `loan_gotten_id` (`loan_gotten_id`),
  ADD KEY `loangottens_loan_gotten_id_index` (`loan_gotten_id`),
  ADD KEY `loangottens_created_by_foreign` (`created_by`),
  ADD KEY `loangottens_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `loanpays`
--
ALTER TABLE `loanpays`
  ADD UNIQUE KEY `loan_pay_id` (`loan_pay_id`),
  ADD KEY `loanpays_loan_pay_id_index` (`loan_pay_id`),
  ADD KEY `loanpays_created_by_foreign` (`created_by`),
  ADD KEY `loanpays_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `loanprovides`
--
ALTER TABLE `loanprovides`
  ADD UNIQUE KEY `loan_provide_id` (`loan_provide_id`),
  ADD KEY `loanprovides_loan_provide_id_index` (`loan_provide_id`),
  ADD KEY `loanprovides_created_by_foreign` (`created_by`),
  ADD KEY `loanprovides_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `loanreceives`
--
ALTER TABLE `loanreceives`
  ADD UNIQUE KEY `loan_receive_id` (`loan_receive_id`),
  ADD KEY `loanreceives_loan_receive_id_index` (`loan_receive_id`),
  ADD KEY `loanreceives_created_by_foreign` (`created_by`),
  ADD KEY `loanreceives_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `moduleemppermissions`
--
ALTER TABLE `moduleemppermissions`
  ADD PRIMARY KEY (`module_id`,`emp_id`),
  ADD UNIQUE KEY `module_emp_p_id` (`module_emp_p_id`),
  ADD KEY `moduleemppermissions_module_emp_p_id_index` (`module_emp_p_id`),
  ADD KEY `moduleemppermissions_emp_id_foreign` (`emp_id`),
  ADD KEY `moduleemppermissions_created_by_foreign` (`created_by`),
  ADD KEY `moduleemppermissions_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `modulenames`
--
ALTER TABLE `modulenames`
  ADD UNIQUE KEY `module_id` (`module_id`);

--
-- Indexes for table `modulepermissions`
--
ALTER TABLE `modulepermissions`
  ADD PRIMARY KEY (`module_id`,`company_id`),
  ADD UNIQUE KEY `m_permission_id` (`m_permission_id`),
  ADD KEY `modulepermissions_m_permission_id_index` (`m_permission_id`),
  ADD KEY `modulepermissions_company_id_foreign` (`company_id`);

--
-- Indexes for table `otherexpenses`
--
ALTER TABLE `otherexpenses`
  ADD UNIQUE KEY `other_expense_id` (`other_expense_id`),
  ADD KEY `otherexpenses_other_expense_id_index` (`other_expense_id`),
  ADD KEY `otherexpenses_created_by_foreign` (`created_by`),
  ADD KEY `otherexpenses_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_otherexpenses_incomeexpensetype` (`expense_type_id`),
  ADD KEY `FK_otherexpenses_branch_info` (`branch_id`);

--
-- Indexes for table `otherincomes`
--
ALTER TABLE `otherincomes`
  ADD UNIQUE KEY `other_income_id` (`other_income_id`),
  ADD KEY `otherincomes_other_income_id_index` (`other_income_id`),
  ADD KEY `otherincomes_created_by_foreign` (`created_by`),
  ADD KEY `otherincomes_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_otherincomes_incomeexpensetype` (`income_type_id`),
  ADD KEY `FK_otherincomes_branch_info` (`branch_id`);

--
-- Indexes for table `paymenttypes`
--
ALTER TABLE `paymenttypes`
  ADD UNIQUE KEY `payment_type_id` (`payment_type_id`),
  ADD UNIQUE KEY `paymenttypes_payment_type_name_unique` (`payment_type_name`),
  ADD KEY `paymenttypes_payment_type_id_index` (`payment_type_id`),
  ADD KEY `paymenttypes_created_by_foreign` (`created_by`),
  ADD KEY `paymenttypes_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `pointincreasingrecords`
--
ALTER TABLE `pointincreasingrecords`
  ADD UNIQUE KEY `point_increasing_id` (`point_increasing_id`),
  ADD KEY `pointincreasingrecords_point_increasing_id_index` (`point_increasing_id`),
  ADD KEY `pointincreasingrecords_cus_id_foreign` (`cus_id`),
  ADD KEY `pointincreasingrecords_sale_invoice_id_foreign` (`sale_invoice_id`),
  ADD KEY `pointincreasingrecords_created_by_foreign` (`created_by`),
  ADD KEY `pointincreasingrecords_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `pointusingrecords`
--
ALTER TABLE `pointusingrecords`
  ADD UNIQUE KEY `point_using_id` (`point_using_id`),
  ADD KEY `pointusingrecords_point_using_id_index` (`point_using_id`),
  ADD KEY `pointusingrecords_cus_id_foreign` (`cus_id`),
  ADD KEY `pointusingrecords_sale_invoice_id_foreign` (`sale_invoice_id`),
  ADD KEY `pointusingrecords_created_by_foreign` (`created_by`),
  ADD KEY `pointusingrecords_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `priceinfos`
--
ALTER TABLE `priceinfos`
  ADD PRIMARY KEY (`item_id`,`purchase_price`,`sale_price`),
  ADD UNIQUE KEY `price_id` (`price_id`),
  ADD KEY `priceinfos_price_id_index` (`price_id`),
  ADD KEY `priceinfos_created_by_foreign` (`created_by`),
  ADD KEY `priceinfos_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `purchasereturntosupplier`
--
ALTER TABLE `purchasereturntosupplier`
  ADD UNIQUE KEY `i_sup_return_id` (`purchase_return_id`),
  ADD KEY `purchasertosuppliers_i_sup_return_id_index` (`purchase_return_id`),
  ADD KEY `purchasertosuppliers_sup_r_invoice_id_foreign` (`sup_r_invoice_id`),
  ADD KEY `purchasertosuppliers_item_id_foreign` (`item_id`),
  ADD KEY `purchasertosuppliers_price_id_foreign` (`price_id`),
  ADD KEY `purchasertosuppliers_created_by_foreign` (`created_by`),
  ADD KEY `purchasertosuppliers_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_purchasereturntosupplier_branch_info` (`branch_id`);

--
-- Indexes for table `receivingitems`
--
ALTER TABLE `receivingitems`
  ADD UNIQUE KEY `receiving_item_id` (`receiving_item_id`),
  ADD KEY `receivingitems_receiving_item_id_index` (`receiving_item_id`),
  ADD KEY `receivingitems_item_id_foreign` (`item_id`),
  ADD KEY `receivingitems_price_id_foreign` (`price_id`),
  ADD KEY `receivingitems_created_by_foreign` (`sending_by`),
  ADD KEY `receivingitems_updated_by_foreign` (`receive_cancel_by`),
  ADD KEY `FK_receivingitems_branch_info` (`branch_id`);

--
-- Indexes for table `returnreceivingitems`
--
ALTER TABLE `returnreceivingitems`
  ADD UNIQUE KEY `r_receiving_item_id` (`r_receiving_item_id`),
  ADD KEY `returnreceivingitems_r_receiving_item_id_index` (`r_receiving_item_id`),
  ADD KEY `returnreceivingitems_item_id_foreign` (`item_id`),
  ADD KEY `returnreceivingitems_price_id_foreign` (`price_id`),
  ADD KEY `returnreceivingitems_created_by_foreign` (`returning_by`),
  ADD KEY `returnreceivingitems_updated_by_foreign` (`receive_cancel_by`),
  ADD KEY `FK_returnreceivingitems_branch_info` (`branch_id`);

--
-- Indexes for table `saleinvoices`
--
ALTER TABLE `saleinvoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sale_invoice_id` (`sale_invoice_id`),
  ADD KEY `saleinvoices_payment_type_id_foreign` (`payment_type_id`),
  ADD KEY `saleinvoices_created_by_foreign` (`created_by`),
  ADD KEY `saleinvoices_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_saleinvoices_customerinfos` (`cus_id`),
  ADD KEY `FK_saleinvoices_branch_info` (`branch_id`);

--
-- Indexes for table `saleinvoices_order`
--
ALTER TABLE `saleinvoices_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sale_invoice_id` (`sale_order_invoice_id`),
  ADD KEY `saleinvoices_payment_type_id_foreign` (`payment_type_id`),
  ADD KEY `saleinvoices_created_by_foreign` (`created_by`),
  ADD KEY `saleinvoices_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_saleinvoices_customerinfos` (`cus_id`),
  ADD KEY `FK_saleinvoices_branch_info` (`branch_id`);

--
-- Indexes for table `salereturninvoices`
--
ALTER TABLE `salereturninvoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sale_return_invoice_id` (`sale_r_invoice_id`),
  ADD KEY `salereturninvoices_payment_type_id_foreign` (`payment_type_id`),
  ADD KEY `salereturninvoices_created_by_foreign` (`created_by`),
  ADD KEY `salereturninvoices_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_salereturninvoices_saleinvoices` (`sale_invoice_id`),
  ADD KEY `FK_salereturninvoices_customerinfos` (`cus_id`),
  ADD KEY `FK_salereturninvoices_branch_info` (`branch_id`);

--
-- Indexes for table `salereturntostocks`
--
ALTER TABLE `salereturntostocks`
  ADD UNIQUE KEY `i_sale_return_id` (`i_sale_return_id`),
  ADD KEY `salereturntostocks_i_sale_return_id_index` (`i_sale_return_id`),
  ADD KEY `salereturntostocks_sale_r_invoice_id_foreign` (`sale_r_invoice_id`),
  ADD KEY `salereturntostocks_item_id_foreign` (`item_id`),
  ADD KEY `salereturntostocks_price_id_foreign` (`price_id`),
  ADD KEY `salereturntostocks_created_by_foreign` (`created_by`),
  ADD KEY `salereturntostocks_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_salereturntostocks_branch_info` (`branch_id`);

--
-- Indexes for table `smemppermissions`
--
ALTER TABLE `smemppermissions`
  ADD PRIMARY KEY (`sub_module_id`,`emp_id`),
  ADD UNIQUE KEY `s_m_emp_p_id` (`s_m_emp_p_id`),
  ADD KEY `smemppermissions_s_m_emp_p_id_index` (`s_m_emp_p_id`),
  ADD KEY `smemppermissions_emp_id_foreign` (`emp_id`),
  ADD KEY `smemppermissions_created_by_foreign` (`created_by`),
  ADD KEY `smemppermissions_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `stockitems`
--
ALTER TABLE `stockitems`
  ADD PRIMARY KEY (`item_id`,`price_id`,`branch_id`),
  ADD UNIQUE KEY `stock_item_id` (`stock_item_id`),
  ADD KEY `stockitems_stock_item_id_index` (`stock_item_id`),
  ADD KEY `stockitems_price_id_foreign` (`price_id`),
  ADD KEY `stockitems_created_by_foreign` (`created_by`),
  ADD KEY `stockitems_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_stockitems_empinfos` (`sending_by`),
  ADD KEY `FK_stockitems_empinfos_2` (`receiving_by`),
  ADD KEY `FK_stockitems_branch_info` (`branch_id`);

--
-- Indexes for table `submodulenames`
--
ALTER TABLE `submodulenames`
  ADD UNIQUE KEY `sub_module_id` (`sub_module_id`),
  ADD KEY `submodulenames_sub_module_id_index` (`sub_module_id`),
  ADD KEY `submodulenames_module_id_foreign` (`module_id`);

--
-- Indexes for table `sub_companies`
--
ALTER TABLE `sub_companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `supduepayments`
--
ALTER TABLE `supduepayments`
  ADD UNIQUE KEY `s_due_payment_id` (`s_due_payment_id`),
  ADD KEY `supduepayments_s_due_payment_id_index` (`s_due_payment_id`),
  ADD KEY `supduepayments_supp_id_foreign` (`supp_id`),
  ADD KEY `supduepayments_payment_type_id_foreign` (`payment_type_id`),
  ADD KEY `supduepayments_created_by_foreign` (`created_by`),
  ADD KEY `supduepayments_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_supduepayments_branch_info` (`branch_id`);

--
-- Indexes for table `supinvoices`
--
ALTER TABLE `supinvoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sup_invoice_id` (`sup_invoice_id`),
  ADD UNIQUE KEY `sup_memo_no` (`sup_memo_no`),
  ADD KEY `supinvoices_supp_id_foreign` (`supp_id`),
  ADD KEY `supinvoices_payment_type_id_foreign` (`payment_type_id`),
  ADD KEY `supinvoices_created_by_foreign` (`created_by`),
  ADD KEY `supinvoices_updated_by_foreign` (`updated_by`),
  ADD KEY `sup_invoice_id_2` (`sup_invoice_id`),
  ADD KEY `FK_supinvoices_branch_info` (`branch_id`);

--
-- Indexes for table `supinvoices_order`
--
ALTER TABLE `supinvoices_order`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sup_invoice_id` (`sup_invoice_id`),
  ADD UNIQUE KEY `sup_memo_no` (`sup_memo_no`),
  ADD KEY `supinvoices_supp_id_foreign` (`supp_id`),
  ADD KEY `supinvoices_payment_type_id_foreign` (`payment_type_id`),
  ADD KEY `supinvoices_created_by_foreign` (`created_by`),
  ADD KEY `supinvoices_updated_by_foreign` (`updated_by`),
  ADD KEY `sup_invoice_id_2` (`sup_invoice_id`),
  ADD KEY `FK_supinvoices_order_branch_info` (`branch_id`);

--
-- Indexes for table `supplierduediscounts`
--
ALTER TABLE `supplierduediscounts`
  ADD UNIQUE KEY `c_due_payment_id` (`s_due_discount_id`),
  ADD KEY `cusduepayments_c_due_payment_id_index` (`s_due_discount_id`),
  ADD KEY `cusduepayments_cus_id_foreign` (`supp_id`),
  ADD KEY `cusduepayments_created_by_foreign` (`created_by`),
  ADD KEY `cusduepayments_updated_by_foreign` (`updated_by`);

--
-- Indexes for table `supplierinfos`
--
ALTER TABLE `supplierinfos`
  ADD UNIQUE KEY `supp_id` (`supp_id`),
  ADD UNIQUE KEY `supplierinfos_user_name_unique` (`user_name`),
  ADD KEY `supplierinfos_supp_id_index` (`supp_id`),
  ADD KEY `supplierinfos_created_by_foreign` (`created_by`),
  ADD KEY `supplierinfos_updated_by_foreign` (`updated_by`),
  ADD KEY `supp_id_2` (`supp_id`);

--
-- Indexes for table `supplierreturninvoices`
--
ALTER TABLE `supplierreturninvoices`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sup_r_invoice_id` (`sup_r_invoice_id`),
  ADD KEY `supplierreturninvoices_supp_id_foreign` (`supp_id`),
  ADD KEY `supplierreturninvoices_payment_type_id_foreign` (`payment_type_id`),
  ADD KEY `supplierreturninvoices_created_by_foreign` (`created_by`),
  ADD KEY `supplierreturninvoices_updated_by_foreign` (`updated_by`),
  ADD KEY `FK_supplierreturninvoices_supinvoices` (`sup_invoice_id`),
  ADD KEY `FK_supplierreturninvoices_branch_info` (`branch_id`);

--
-- Indexes for table `urlemppermissions`
--
ALTER TABLE `urlemppermissions`
  ADD PRIMARY KEY (`url_emp_p_id`),
  ADD KEY `FK_urlemppermissions_empinfos` (`emp_id`),
  ADD KEY `FK_urlemppermissions_urlnames` (`url_id`);

--
-- Indexes for table `urlnamepermissions`
--
ALTER TABLE `urlnamepermissions`
  ADD PRIMARY KEY (`url_permission_id`),
  ADD KEY `FK_urlnamepermissions_urlnames` (`url_id`);

--
-- Indexes for table `urlnames`
--
ALTER TABLE `urlnames`
  ADD PRIMARY KEY (`url_id`),
  ADD UNIQUE KEY `url_name` (`url_name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `branch_info`
--
ALTER TABLE `branch_info`
  MODIFY `branch_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `companynames`
--
ALTER TABLE `companynames`
  MODIFY `company_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `companyprofiles`
--
ALTER TABLE `companyprofiles`
  MODIFY `company_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `cusduediscounts`
--
ALTER TABLE `cusduediscounts`
  MODIFY `c_due_discount_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `cusduepayments`
--
ALTER TABLE `cusduepayments`
  MODIFY `c_due_payment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customerinfos`
--
ALTER TABLE `customerinfos`
  MODIFY `cus_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `customertypes`
--
ALTER TABLE `customertypes`
  MODIFY `cus_type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `damageinvoices`
--
ALTER TABLE `damageinvoices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `empinfos`
--
ALTER TABLE `empinfos`
  MODIFY `emp_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `empwisesalary`
--
ALTER TABLE `empwisesalary`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `godownitems`
--
ALTER TABLE `godownitems`
  MODIFY `godown_item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `incomeexpensetype`
--
ALTER TABLE `incomeexpensetype`
  MODIFY `type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `itembrands`
--
ALTER TABLE `itembrands`
  MODIFY `brand_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `itemcategorys`
--
ALTER TABLE `itemcategorys`
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `itemdamages`
--
ALTER TABLE `itemdamages`
  MODIFY `i_damage_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `iteminfos`
--
ALTER TABLE `iteminfos`
  MODIFY `item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `itemlocations`
--
ALTER TABLE `itemlocations`
  MODIFY `location_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `itempurchases`
--
ALTER TABLE `itempurchases`
  MODIFY `i_purchase_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `itempurchases_order`
--
ALTER TABLE `itempurchases_order`
  MODIFY `i_purchase_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `itemsales`
--
ALTER TABLE `itemsales`
  MODIFY `i_sale_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `itemsales_order`
--
ALTER TABLE `itemsales_order`
  MODIFY `i_sale_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loangottens`
--
ALTER TABLE `loangottens`
  MODIFY `loan_gotten_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loanpays`
--
ALTER TABLE `loanpays`
  MODIFY `loan_pay_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loanprovides`
--
ALTER TABLE `loanprovides`
  MODIFY `loan_provide_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loanreceives`
--
ALTER TABLE `loanreceives`
  MODIFY `loan_receive_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `moduleemppermissions`
--
ALTER TABLE `moduleemppermissions`
  MODIFY `module_emp_p_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=199;

--
-- AUTO_INCREMENT for table `modulenames`
--
ALTER TABLE `modulenames`
  MODIFY `module_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `modulepermissions`
--
ALTER TABLE `modulepermissions`
  MODIFY `m_permission_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `otherexpenses`
--
ALTER TABLE `otherexpenses`
  MODIFY `other_expense_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `otherincomes`
--
ALTER TABLE `otherincomes`
  MODIFY `other_income_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `paymenttypes`
--
ALTER TABLE `paymenttypes`
  MODIFY `payment_type_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `pointincreasingrecords`
--
ALTER TABLE `pointincreasingrecords`
  MODIFY `point_increasing_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `pointusingrecords`
--
ALTER TABLE `pointusingrecords`
  MODIFY `point_using_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `priceinfos`
--
ALTER TABLE `priceinfos`
  MODIFY `price_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `purchasereturntosupplier`
--
ALTER TABLE `purchasereturntosupplier`
  MODIFY `purchase_return_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `receivingitems`
--
ALTER TABLE `receivingitems`
  MODIFY `receiving_item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `returnreceivingitems`
--
ALTER TABLE `returnreceivingitems`
  MODIFY `r_receiving_item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `saleinvoices`
--
ALTER TABLE `saleinvoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `saleinvoices_order`
--
ALTER TABLE `saleinvoices_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `salereturninvoices`
--
ALTER TABLE `salereturninvoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `salereturntostocks`
--
ALTER TABLE `salereturntostocks`
  MODIFY `i_sale_return_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `smemppermissions`
--
ALTER TABLE `smemppermissions`
  MODIFY `s_m_emp_p_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `stockitems`
--
ALTER TABLE `stockitems`
  MODIFY `stock_item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `submodulenames`
--
ALTER TABLE `submodulenames`
  MODIFY `sub_module_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sub_companies`
--
ALTER TABLE `sub_companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `supduepayments`
--
ALTER TABLE `supduepayments`
  MODIFY `s_due_payment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supinvoices`
--
ALTER TABLE `supinvoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supinvoices_order`
--
ALTER TABLE `supinvoices_order`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supplierduediscounts`
--
ALTER TABLE `supplierduediscounts`
  MODIFY `s_due_discount_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `supplierinfos`
--
ALTER TABLE `supplierinfos`
  MODIFY `supp_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `supplierreturninvoices`
--
ALTER TABLE `supplierreturninvoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `urlemppermissions`
--
ALTER TABLE `urlemppermissions`
  MODIFY `url_emp_p_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=157;

--
-- AUTO_INCREMENT for table `urlnamepermissions`
--
ALTER TABLE `urlnamepermissions`
  MODIFY `url_permission_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `urlnames`
--
ALTER TABLE `urlnames`
  MODIFY `url_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `companynames`
--
ALTER TABLE `companynames`
  ADD CONSTRAINT `FK_companynames_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_companynames_empinfos_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `cusduediscounts`
--
ALTER TABLE `cusduediscounts`
  ADD CONSTRAINT `cusduediscounts_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cusduediscounts_ibfk_2` FOREIGN KEY (`cus_id`) REFERENCES `customerinfos` (`cus_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cusduediscounts_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `cusduepayments`
--
ALTER TABLE `cusduepayments`
  ADD CONSTRAINT `cusduepayments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cusduepayments_cus_id_foreign` FOREIGN KEY (`cus_id`) REFERENCES `customerinfos` (`cus_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cusduepayments_payment_type_id_foreign` FOREIGN KEY (`payment_type_id`) REFERENCES `paymenttypes` (`payment_type_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cusduepayments_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `customerinfos`
--
ALTER TABLE `customerinfos`
  ADD CONSTRAINT `FK_customerinfos_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `customerinfos_cus_type_id_foreign` FOREIGN KEY (`cus_type_id`) REFERENCES `customertypes` (`cus_type_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `customerinfos_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `customertypes`
--
ALTER TABLE `customertypes`
  ADD CONSTRAINT `customertypes_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `customertypes_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `damageinvoices`
--
ALTER TABLE `damageinvoices`
  ADD CONSTRAINT `FK_damageinvoices_branch_info` FOREIGN KEY (`branch_id`) REFERENCES `branch_info` (`branch_id`),
  ADD CONSTRAINT `FK_damageinvoices_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_damageinvoices_empinfos_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `empinfos`
--
ALTER TABLE `empinfos`
  ADD CONSTRAINT `empinfos_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `empinfos_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `empwisesalary`
--
ALTER TABLE `empwisesalary`
  ADD CONSTRAINT `FK_empwisesalary_branch_info` FOREIGN KEY (`branch_id`) REFERENCES `branch_info` (`branch_id`),
  ADD CONSTRAINT `FK_empwisesalary_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `empwisesalary_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `empwisesalary_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `godownitems`
--
ALTER TABLE `godownitems`
  ADD CONSTRAINT `FK_godownitems_empinfos` FOREIGN KEY (`sending_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_godownitems_empinfos_2` FOREIGN KEY (`receiving_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `godownitems_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `godownitems_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `iteminfos` (`item_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `godownitems_price_id_foreign` FOREIGN KEY (`price_id`) REFERENCES `priceinfos` (`price_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `godownitems_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `incomeexpensetype`
--
ALTER TABLE `incomeexpensetype`
  ADD CONSTRAINT `FK_incomeexpensetype_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_incomeexpensetype_empinfos_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `itembrands`
--
ALTER TABLE `itembrands`
  ADD CONSTRAINT `itembrands_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `itembrands_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `itemcategorys`
--
ALTER TABLE `itemcategorys`
  ADD CONSTRAINT `itemcategorys_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `itemcategorys_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `itemdamages`
--
ALTER TABLE `itemdamages`
  ADD CONSTRAINT `FK_itemdamages_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_itemdamages_empinfos_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_itemdamages_iteminfos` FOREIGN KEY (`item_id`) REFERENCES `iteminfos` (`item_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_itemdamages_priceinfos` FOREIGN KEY (`price_id`) REFERENCES `priceinfos` (`price_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `damageinvoices_itemdamages` FOREIGN KEY (`damage_invoice_id`) REFERENCES `damageinvoices` (`damage_invoice_id`) ON UPDATE CASCADE;

--
-- Constraints for table `iteminfos`
--
ALTER TABLE `iteminfos`
  ADD CONSTRAINT `brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `itembrands` (`brand_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `iteminfos_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `itemcategorys` (`category_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `iteminfos_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `iteminfos_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `itemlocations` (`location_id`) ON UPDATE CASCADE;

--
-- Constraints for table `itemlocations`
--
ALTER TABLE `itemlocations`
  ADD CONSTRAINT `FK_itemlocations_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_itemlocations_empinfos_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `itempurchases`
--
ALTER TABLE `itempurchases`
  ADD CONSTRAINT `FK_itempurchases_branch_info` FOREIGN KEY (`branch_id`) REFERENCES `branch_info` (`branch_id`),
  ADD CONSTRAINT `FK_itempurchases_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_itempurchases_empinfos_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_itempurchases_iteminfos` FOREIGN KEY (`item_id`) REFERENCES `iteminfos` (`item_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_itempurchases_priceinfos` FOREIGN KEY (`price_id`) REFERENCES `priceinfos` (`price_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_itempurchases_supinvoices` FOREIGN KEY (`sup_invoice_id`) REFERENCES `supinvoices` (`sup_invoice_id`) ON UPDATE CASCADE;

--
-- Constraints for table `itempurchases_order`
--
ALTER TABLE `itempurchases_order`
  ADD CONSTRAINT `FK_itempurchases_order_branch_info` FOREIGN KEY (`branch_id`) REFERENCES `branch_info` (`branch_id`),
  ADD CONSTRAINT `itempurchases_order_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `itempurchases_order_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `itempurchases_order_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `iteminfos` (`item_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `itempurchases_order_ibfk_4` FOREIGN KEY (`price_id`) REFERENCES `priceinfos` (`price_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `itempurchases_order_ibfk_5` FOREIGN KEY (`sup_invoice_id`) REFERENCES `supinvoices_order` (`sup_invoice_id`) ON UPDATE CASCADE;

--
-- Constraints for table `itemsales`
--
ALTER TABLE `itemsales`
  ADD CONSTRAINT `FK_itemsales_saleinvoices` FOREIGN KEY (`sale_invoice_id`) REFERENCES `saleinvoices` (`sale_invoice_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `itemsales_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `itemsales_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `iteminfos` (`item_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `itemsales_price_id_foreign` FOREIGN KEY (`price_id`) REFERENCES `priceinfos` (`price_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `itemsales_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `itemsales_order`
--
ALTER TABLE `itemsales_order`
  ADD CONSTRAINT `itemsales_order_ibfk_1` FOREIGN KEY (`sale_order_invoice_id`) REFERENCES `saleinvoices_order` (`sale_order_invoice_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `itemsales_order_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `itemsales_order_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `iteminfos` (`item_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `itemsales_order_ibfk_4` FOREIGN KEY (`price_id`) REFERENCES `priceinfos` (`price_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `itemsales_order_ibfk_5` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `loangottens`
--
ALTER TABLE `loangottens`
  ADD CONSTRAINT `loangottens_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `loangottens_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `loanpays`
--
ALTER TABLE `loanpays`
  ADD CONSTRAINT `loanpays_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `loanpays_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `loanprovides`
--
ALTER TABLE `loanprovides`
  ADD CONSTRAINT `loanprovides_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `loanprovides_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `loanreceives`
--
ALTER TABLE `loanreceives`
  ADD CONSTRAINT `loanreceives_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `loanreceives_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;

--
-- Constraints for table `supplierduediscounts`
--
ALTER TABLE `supplierduediscounts`
  ADD CONSTRAINT `supplierduediscounts_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `supplierduediscounts_ibfk_2` FOREIGN KEY (`supp_id`) REFERENCES `supplierinfos` (`supp_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `supplierduediscounts_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
