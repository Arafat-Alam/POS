-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Apr 14, 2019 at 11:38 AM
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
(1, 'MR Traders', 1, 1, '2019-04-06 13:19:38', NULL, '0000-00-00 00:00:00');

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
(1, 'MR Traders', 'Gulshan, Dhaka', '01800000000', 'MrTraders', 1, 0, 'english', 'asia/dhaka', 0, 1, 0, 1, 0, 0, 1, 2019, '2015-12-08 15:47:23', '0000-00-00 00:00:00');

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

--
-- Dumping data for table `customerinfos`
--

INSERT INTO `customerinfos` (`cus_id`, `cus_card_id`, `branch_id`, `cus_type_id`, `full_name`, `user_name`, `mobile`, `present_address`, `shipping_address`, `password`, `permanent_address`, `profile_image`, `national_id`, `email`, `advance_payment`, `due`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(1, '1000000', 1, 2, 'ACI Logistics Ltd.', 'acilog', '012356', 'Tejgaon', NULL, '$2y$10$oawemC9QJYdqPWAD95ClBOszB3bFREbOQ989Weo0NdNdoZNrkZdAG', 'Tejgaon', NULL, 123, 'aci@gmail.com', 0, 0, 1, 1, NULL, '2019-04-07 06:47:50', '0000-00-00 00:00:00');

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
(1, 1, 2, 'Super', 'Admin', 'Admin', 'Admin', '01800000000', 'admin@gmail.com', 'admin', '$2y$10$cKFNnSsz6CKSsJSpTUgu8ORpT0auJfiWWgPvvkYzX/2YQEtu4QGw.', 'GmPa6i7ybSTJ7lWOdXCY4eSKjDEqz1jGmfuRkfcnjeV9M1m8PAQoyxsglEDn', 'Dhaka', 'Dhaka', '', 1257489631, 10000, 0, 0, 1, 2015, 1, '192.168.0.101', 1, 1, '2015-12-08 15:47:23', '2019-04-07 13:35:22'),
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
(22, 0, 1, 'Md', 'Sahazan', 'kalamnh', 'fathddjj', '013874888888', 'saha@gmail.com', 'adminsahazan', '$2y$10$QV7/j9CpHF/R81gpXXOQEeEBPRQqR6l6U1HTM7ZDLRduAGZ3qO6cG', '', 'hdhdd', 'diidkdkdk', '', 76888888886, 6000, 0, 0, 1, 0, 0, NULL, 1, NULL, '2019-01-23 18:39:53', '0000-00-00 00:00:00'),
(23, 0, 1, 'MASUM', 'AHMED', 'FATHER', 'MOTHER', '0125414587', 'masum@gmail.com', 'masum', '$2y$10$Dl8EddKdnZBdQEiIl.dtdeIplMnJPHTLc69tZm1cwOZs2uGy00j1K', '', 'dfa', 'adf', '', 123, 5000, 0, 0, 1, 0, 0, NULL, 1, NULL, '2019-04-07 13:35:11', '0000-00-00 00:00:00');

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
(1, 'MR Traders', 0, 1, 0, 2, 1, '0000-00-00 00:00:00', '2019-04-07 12:37:16');

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
(1, 'Body Lotion', 0, 1, 0, 1, 1, '0000-00-00 00:00:00', '2019-04-07 12:33:09'),
(2, 'Body Spray', 0, 1, 0, 1, NULL, '2019-04-07 12:33:20', '0000-00-00 00:00:00'),
(3, 'Soap', 0, 1, 0, 1, NULL, '2019-04-07 12:33:34', '0000-00-00 00:00:00'),
(4, 'Shampoo', 0, 1, 0, 1, NULL, '2019-04-07 12:33:50', '0000-00-00 00:00:00'),
(5, 'Oil', 0, 1, 0, 1, NULL, '2019-04-07 12:33:57', '0000-00-00 00:00:00'),
(6, 'Cream', 0, 1, 0, 1, NULL, '2019-04-07 12:34:09', '0000-00-00 00:00:00'),
(7, 'Air Freshner', 0, 1, 0, 1, NULL, '2019-04-07 12:34:20', '0000-00-00 00:00:00'),
(8, 'Conditioner', 0, 1, 0, 1, NULL, '2019-04-07 12:34:29', '0000-00-00 00:00:00'),
(9, 'Tooth Brash', 0, 1, 0, 1, NULL, '2019-04-07 12:34:39', '0000-00-00 00:00:00'),
(10, 'Face Wash', 0, 1, 0, 1, NULL, '2019-04-07 12:34:50', '0000-00-00 00:00:00'),
(11, 'Face Scrub', 0, 1, 0, 1, NULL, '2019-04-07 12:35:04', '0000-00-00 00:00:00'),
(12, 'Hair Oil', 0, 1, 0, 1, NULL, '2019-04-07 12:35:14', '0000-00-00 00:00:00'),
(13, 'Bath', 0, 1, 0, 1, NULL, '2019-04-07 12:35:21', '0000-00-00 00:00:00'),
(14, 'Top To Toe Wash', 0, 1, 0, 1, NULL, '2019-04-07 12:35:39', '0000-00-00 00:00:00'),
(15, 'Gift Set', 0, 1, 0, 1, NULL, '2019-04-07 12:35:54', '0000-00-00 00:00:00'),
(16, 'Powdar', 0, 1, 0, 1, NULL, '2019-04-07 12:36:04', '0000-00-00 00:00:00'),
(17, 'Tooth Pest', 0, 1, 0, 1, NULL, '2019-04-07 12:36:21', '0000-00-00 00:00:00'),
(18, 'Hair Colour', 0, 1, 0, 1, NULL, '2019-04-07 12:36:48', '0000-00-00 00:00:00'),
(19, 'ROLL-ON', 0, 1, 0, 1, NULL, '2019-04-07 13:39:55', '0000-00-00 00:00:00'),
(20, 'kajol', 0, 1, 0, 1, NULL, '2019-04-07 14:54:00', '0000-00-00 00:00:00'),
(21, 'Hair Gel', 0, 1, 0, 1, NULL, '2019-04-07 14:57:18', '0000-00-00 00:00:00'),
(22, 'Mouth wash ', 0, 1, 0, 1, NULL, '2019-04-07 17:03:44', '0000-00-00 00:00:00'),
(23, 'Hair Spray', 0, 1, 0, 1, NULL, '2019-04-07 22:50:36', '0000-00-00 00:00:00'),
(24, 'Garbag Bag', 0, 1, 0, 1, NULL, '2019-04-07 23:37:42', '0000-00-00 00:00:00'),
(25, 'Hair Tonic', 0, 1, 0, 1, NULL, '2019-04-07 23:38:16', '0000-00-00 00:00:00'),
(26, 'Toner Clinsing Milk', 0, 1, 0, 1, NULL, '2019-04-08 11:24:24', '0000-00-00 00:00:00'),
(27, 'Hair Cream ', 0, 1, 0, 1, NULL, '2019-04-08 11:30:31', '0000-00-00 00:00:00'),
(28, 'Car Shampoo', 0, 1, 0, 1, NULL, '2019-04-08 11:56:09', '0000-00-00 00:00:00'),
(29, 'pain kelar', 0, 1, 0, 1, NULL, '2019-04-08 12:02:22', '0000-00-00 00:00:00'),
(30, 'Dental Floss', 0, 1, 0, 1, NULL, '2019-04-08 12:30:15', '0000-00-00 00:00:00'),
(31, 'Gum', 0, 1, 0, 1, NULL, '2019-04-08 12:49:37', '0000-00-00 00:00:00');

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
  `article_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
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

--
-- Dumping data for table `iteminfos`
--

INSERT INTO `iteminfos` (`item_id`, `company_id`, `supplier_id`, `item_company_id`, `item_name`, `upc_code`, `article_number`, `carton`, `category_id`, `brand_id`, `location_id`, `price_id`, `unit`, `tax_amount`, `offer_type`, `offer`, `description`, `status`, `year`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(257, 1, 3, 1, 'JOHNSON\'S BABY SOFT CREAM 100ML FR', '30000070', NULL, NULL, 6, 1, NULL, 256, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 11:05:18', '2019-04-07 13:56:26'),
(258, 1, 3, 1, 'FA ROLL ON MEN PERFECT WAVE 50ML', '30000046', NULL, NULL, 19, 1, NULL, 257, 1, NULL, 0, 0, 'k-shose', 0, 0, 1, 1, '2019-04-07 11:59:54', '2019-04-07 13:49:07'),
(259, 1, 2, 1, '', '11904072590000', NULL, NULL, 7, 1, NULL, 258, 1, 0, 0, 0, '', 0, 0, 1, 1, '2019-04-07 12:51:37', '2019-04-07 12:51:37'),
(262, 1, 3, 1, 'FA ROLL ON CARIBBIAN LEMON 50ML', '30000011', NULL, NULL, 19, 1, NULL, 260, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 13:41:31', '2019-04-07 13:41:31'),
(263, 1, 3, 1, 'FA ROLL ON AQUA FRESH 50ML', '30000045', NULL, NULL, 19, 1, NULL, 261, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 13:47:32', '2019-04-07 13:47:32'),
(264, 1, 3, 1, 'FA BODY SPRAY AQUA 200ML DE', '30000047', NULL, NULL, 2, 1, NULL, 262, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 13:52:42', '2019-04-07 13:52:42'),
(265, 1, 3, 1, 'JOHNSON\'S BABY OIL 300ML IT', '30000077', NULL, NULL, 5, 1, NULL, 263, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 13:58:51', '2019-04-07 13:58:51'),
(266, 1, 3, 1, 'JOHNSON\'S BABY OIL 500ML IT', '30000078', NULL, NULL, 5, 1, NULL, 264, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 14:01:59', '2019-04-07 14:01:59'),
(267, 1, 3, 1, 'JOHNSON\'S BABY LOTION PINK 200ML IT', '30000080', NULL, NULL, 1, 1, NULL, 265, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 14:03:10', '2019-04-07 14:03:10'),
(268, 1, 3, 1, 'JOHNSON\'S BABY LOTION PINK 300ML IT', '30000081', NULL, NULL, 1, NULL, NULL, 266, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 14:04:06', '2019-04-07 14:04:06'),
(269, 1, 3, 1, 'JOHNSON\'S BABY LOTION PINK 500ML IT', '30000082', NULL, NULL, 1, NULL, NULL, 267, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 14:05:19', '2019-04-07 14:05:19'),
(270, 1, 3, 1, 'JOHNSON\'S BABY OIL 100ML IN', '30000102', NULL, NULL, 5, NULL, NULL, 268, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 14:06:08', '2019-04-07 14:06:08'),
(271, 1, 3, 1, 'JOHNSON\'S BABY HAIR OIL 100ML IN', '30000111', NULL, NULL, 12, 1, NULL, 269, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 14:11:44', '2019-04-07 14:21:31'),
(272, 1, 3, 1, 'JOHNSON\'S BABY MILK BATH 100ML MY', '30000274', NULL, NULL, 13, 1, NULL, 270, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 14:17:35', '2019-04-07 14:17:35'),
(273, 1, 3, 1, 'JOHNSON\'S BABY MILK LOTION 200ML MY', '30000275', NULL, NULL, 1, 1, NULL, 271, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 14:20:40', '2019-04-07 14:21:56'),
(274, 1, 3, 1, 'FA ROLL ON PINK PASSION FLORAL 50ML DE', '30001696', NULL, NULL, 19, 1, NULL, 272, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 14:24:21', '2019-04-07 14:24:21'),
(275, 1, 3, 1, 'FA ROLL ON NUTRI SKIN CARE COMPLEX 50ML', '30001697', NULL, NULL, 19, 1, NULL, 273, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 14:25:05', '2019-04-07 14:25:05'),
(276, 1, 3, 1, 'JOHNSON\'S BABY GIFT BOX MEDIUM', '30002397', NULL, NULL, 15, 1, NULL, 274, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 14:26:57', '2019-04-07 14:26:57'),
(277, 1, 3, 1, 'FA BODY SPRAY PINK PASSION 200ML', '30003125', NULL, NULL, 2, 1, NULL, 275, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 14:52:21', '2019-04-07 14:52:21'),
(278, 1, 3, 1, 'MAYBELLINE COLOSSAL KAJAL 6H 0.35G CN', '30006023', NULL, NULL, 20, 1, NULL, 276, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 14:55:24', '2019-04-07 14:55:24'),
(279, 1, 3, 1, 'GATSBY WATER GLOSS SOFT 150G ID', '30006042', NULL, NULL, 21, 1, NULL, 277, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 14:58:19', '2019-04-07 14:58:19'),
(280, 1, 3, 1, 'GATSBY WATER GLOSS HYPER SOLID 150G ID', '30006043', NULL, NULL, 21, 1, NULL, 278, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 14:58:52', '2019-04-07 14:58:52'),
(281, 1, 3, 1, 'DOVE SHOWER CRM DEEPLY NOURISH 250ML GB', '30006421', NULL, NULL, 13, 1, NULL, 279, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 15:01:15', '2019-04-07 15:01:15'),
(282, 1, 3, 1, 'GATSBY HAIR GEL ORANGE 150ML TUB CN', '30007041', NULL, NULL, 21, 1, NULL, 280, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 15:19:29', '2019-04-07 15:19:29'),
(283, 1, 3, 1, 'GATSBY HAIR GEL GREEN 150ML TUB CN', '30007042', NULL, NULL, 21, 1, NULL, 281, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 15:20:14', '2019-04-07 15:20:14'),
(284, 1, 3, 1, 'GATSBY HAIR GEL WHITE 150ML TUB CN', '30007043', NULL, NULL, 21, 1, NULL, 282, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 15:20:52', '2019-04-07 15:20:52'),
(285, 1, 3, 1, 'DR. WEST TOOTHBRUSH JUNIOR OM', '30007258', NULL, NULL, 9, 1, NULL, 283, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 15:21:56', '2019-04-07 15:21:56'),
(286, 1, 3, 1, 'JOHNSON’S BABY SHAMPOO 200ML MY', '30007427', NULL, NULL, 4, 1, NULL, 284, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 15:23:19', '2019-04-07 15:23:19'),
(287, 1, 3, 1, 'JOHNSON’S BABY SHAMPOO 300ML IT', '30007428', NULL, NULL, 4, 1, NULL, 285, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 15:23:56', '2019-04-07 15:23:56'),
(288, 1, 3, 1, 'JOHNSON’S BABY SHAMPOO 100ML MY', '30007429', NULL, NULL, 4, 1, NULL, 286, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 15:24:46', '2019-04-07 15:24:46'),
(289, 1, 3, 1, 'JOHNSON’S BABY MILK CREAM 100ML TH', '30007430', NULL, NULL, 6, 1, NULL, 287, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 15:35:39', '2019-04-07 15:35:39'),
(290, 1, 3, 1, 'JOHNSON’S BABY CREAM 100G TH', '30007431', NULL, NULL, 6, 1, NULL, 288, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 16:55:36', '2019-04-07 16:55:36'),
(291, 1, 3, 1, 'JOHNSON’S BABY MILK CREAM 50ML TH', '30007432', NULL, NULL, 6, 1, NULL, 289, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 16:56:16', '2019-04-07 16:56:16'),
(292, 1, 3, 1, 'JOHNSON’S BABY CREAM 50G TH', '30007433', NULL, NULL, 6, 1, NULL, 290, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 16:56:50', '2019-04-07 16:56:50'),
(293, 1, 3, 1, 'JOHNSON\'S BABY SOAP MOISTURE 75G TH', '30007437', NULL, NULL, 3, 1, NULL, 291, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 16:59:26', '2019-04-07 16:59:26'),
(294, 1, 3, 1, 'JOHNSON\'S BABY TOP 2 TOE MOIST. CRM 100M', '30013082', NULL, NULL, 6, 1, NULL, 292, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 17:12:55', '2019-04-07 17:12:55'),
(295, 1, 3, 1, 'JOHNSON\'S BABY TOP TO TOE WASH 100ML MY', '30013093', NULL, NULL, 14, 1, NULL, 293, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 17:19:13', '2019-04-07 17:19:13'),
(296, 1, 3, 1, 'JOHNSON\'S BABY MILK LOTION 100ML ', '30013094', NULL, NULL, 1, 1, NULL, 294, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 17:22:06', '2019-04-07 17:22:06'),
(297, 1, 3, 1, 'JOHNSON\'S BABY LOTION 500ML TH', '30013095', NULL, NULL, 1, 1, NULL, 295, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 17:28:08', '2019-04-07 17:28:08'),
(298, 1, 3, 1, 'JOHNSONIS BABY LOTION 100ML MY', '30013751', NULL, NULL, 1, 1, NULL, 296, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 17:30:31', '2019-04-07 17:30:31'),
(299, 1, 3, 1, 'JOHNSONIS BABY OIL 125ML MY', '30013753', NULL, NULL, 5, 1, NULL, 297, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 17:31:18', '2019-04-07 17:31:18'),
(300, 1, 3, 1, 'JOHNSONIS BABY LOTION 200ML ID', '30013754', NULL, NULL, 1, 1, NULL, 298, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 17:31:56', '2019-04-07 17:31:56'),
(301, 1, 3, 1, 'CLEAN & CLEAR FCIAL CLNSR BERRY 100ML TH', '30013756', NULL, NULL, 10, 1, NULL, 299, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 17:32:52', '2019-04-07 17:32:52'),
(302, 1, 3, 1, 'CLEAN & CLEAR FCIAL CLNSR LMN  100ML TH', '30013757', NULL, NULL, 10, 1, NULL, 300, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 17:33:38', '2019-04-07 17:33:38'),
(303, 1, 3, 1, 'PEPSODENT TRIPLE CLEAN FAMILI TOOTH BRUS', '30013970', NULL, NULL, 9, 1, NULL, 301, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 17:34:21', '2019-04-07 17:34:21'),
(304, 1, 3, 1, 'PEPSODENT ACTION 123 TOOTH BRUSH MEDIUM', '30013971', NULL, NULL, 9, 1, NULL, 302, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 17:35:06', '2019-04-07 17:35:06'),
(305, 1, 3, 1, 'PEPSODENT ACTION 123 TOOTH BRUSH SOFT', '30013972', NULL, NULL, 9, 1, NULL, 303, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 17:39:00', '2019-04-07 17:39:00'),
(306, 1, 3, 1, 'PEPSODENT VERTICAL EXPERT TOOTH BRUSH', '30013973', NULL, NULL, 9, 1, NULL, 304, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 17:39:45', '2019-04-07 17:39:45'),
(307, 1, 3, 1, 'SENSODYNE  PRECISION TOOTH BRUSH', '30013974', NULL, NULL, 9, 1, NULL, 305, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 22:33:59', '2019-04-07 22:33:59'),
(308, 1, 3, 1, 'DOVE CARING PROTECTION BODY WASH 250ML', '30013981', NULL, NULL, 13, 1, NULL, 306, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 22:35:09', '2019-04-07 22:35:09'),
(309, 1, 3, 1, 'DOVE GO FRESH BODY WASH 250ML', '30013982', NULL, NULL, 13, 1, NULL, 307, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 22:35:51', '2019-04-07 22:35:51'),
(310, 1, 3, 1, 'DOVE PURELY PAMPERING BODY WASH 250ML', '30013983', NULL, NULL, 13, 1, NULL, 308, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 22:36:36', '2019-04-07 22:36:36'),
(311, 1, 3, NULL, 'DAILY FRESH CAR AIRFRESHNER ORCHARD 70GM', '30000006', NULL, NULL, 7, 1, NULL, 309, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 22:37:42', '2019-04-07 22:37:42'),
(312, 1, 3, 1, 'JOHNSON\'S BABY POWDER WHITE 200G TH', '30000096', NULL, NULL, 16, 1, NULL, 310, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 22:38:39', '2019-04-07 22:38:39'),
(313, 1, 3, 1, 'JOHNSON\'S BABY POWDER PINK 200G TH', '30000115', NULL, NULL, 16, 1, NULL, 311, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 22:39:25', '2019-04-07 22:39:25'),
(314, 1, 3, 1, 'JOHNSON\'S BABY POWDER PINK 400G', '30000166', NULL, NULL, 16, 1, NULL, 312, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 22:41:09', '2019-04-07 22:41:09'),
(315, 1, 3, 1, 'DAILY FRESH CAR FRESHENR LEMON 70ML', '30000615', NULL, NULL, 7, 1, NULL, 313, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 22:42:13', '2019-04-07 22:42:13'),
(316, 1, 3, 1, 'GATSBY HAIR SPRAY SUPER HARD 250ML', '30001100', NULL, NULL, 23, 1, NULL, 314, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 22:47:13', '2019-04-07 22:59:34'),
(322, 1, 3, 1, 'JOHNSON\'S BABY GIFT SET 4PCS BOX', '30001384', NULL, NULL, 15, 1, NULL, 315, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:00:23', '2019-04-07 23:00:23'),
(323, 1, 3, 1, 'ITCH GUARD 15G', '30004256', NULL, NULL, 6, 1, NULL, 316, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:01:29', '2019-04-07 23:01:29'),
(324, 1, 3, 1, 'DEEP HEAT SPRAY 150ML GB', '30004472', NULL, NULL, 23, 1, NULL, 317, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:02:28', '2019-04-07 23:02:28'),
(325, 1, 3, 1, 'JOHNSON\'S SOFT CREAM 200ML FR', '30005997', NULL, NULL, 6, 1, NULL, 318, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:07:02', '2019-04-07 23:07:02'),
(326, 1, 3, 1, 'VASELINE HAIR TONIC 200ML GB', '30007684', NULL, NULL, 12, 1, NULL, 319, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:36:38', '2019-04-07 23:36:38'),
(327, 1, 3, 1, 'GARBAGE BAG 34X46 5PCS BLACK US', '30007949', NULL, NULL, 24, 1, NULL, 320, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:46:28', '2019-04-07 23:46:28'),
(328, 1, 3, 1, 'GARBAGE BAG 36X58 5PCS BLACK US', '30007950', NULL, NULL, 24, 1, NULL, 321, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:47:45', '2019-04-07 23:47:45'),
(329, 1, 3, 1, 'GARBAGE BAG 28X34 10PCS BLACK US', '30007951', NULL, NULL, 24, 1, NULL, 322, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:48:38', '2019-04-07 23:48:38'),
(330, 1, 3, 1, 'GARBAGE BAG 20X30 10PCS BLACK US', '30007952', NULL, NULL, 24, 1, NULL, 323, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:49:28', '2019-04-07 23:49:28'),
(331, 1, 3, 1, 'GARBAGE BAG 20X30 10PCS WHITE US', '30007953', NULL, NULL, 24, 1, NULL, 324, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:50:14', '2019-04-07 23:50:14'),
(332, 1, 3, 1, 'GARBAGE BAG 16X20 20PCS WHITE US', '30007954', NULL, NULL, 24, 1, NULL, 325, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:50:59', '2019-04-07 23:50:59'),
(333, 1, 3, 1, 'RINGUARD ANTI FUNGAL CREAM 12G TUB IN', '30007983', NULL, NULL, 6, 1, NULL, 326, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:52:00', '2019-04-07 23:52:00'),
(334, 1, 3, 1, 'ORAL-B TOOTHBRUSH EXPERT MEDIUM IE', '30008258', NULL, NULL, 9, 1, NULL, 327, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:52:58', '2019-04-07 23:52:58'),
(335, 1, 3, 1, 'NAIR HAIR REMOVAL CREAM ROSE 110ML GB', '30008577', NULL, NULL, 9, 1, NULL, 328, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:54:04', '2019-04-07 23:54:04'),
(336, 1, 3, 1, 'NAIR HAIR REMOVAL CREAM LEMON 110ML GB', '30008578', NULL, NULL, 6, 1, NULL, 329, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:54:54', '2019-04-07 23:54:54'),
(337, 1, 3, 1, 'JOHNSON\'S BABY POWDER WHITE 400G', '30008868', NULL, NULL, 16, 1, NULL, 330, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-07 23:56:27', '2019-04-07 23:56:27'),
(338, 1, 3, 1, 'DOVE SHOWER CREAM DEEPLY NOURISHING 500M', '30008869', NULL, NULL, 13, 1, NULL, 331, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 00:01:54', '2019-04-08 00:01:54'),
(339, 1, 3, 1, 'DOVE SHOWER CREAM PURELY PAMPERING 500ML', '30008871', NULL, NULL, 13, 1, NULL, 332, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 00:02:38', '2019-04-08 00:02:38'),
(340, 1, 3, 1, 'DOVE SHOWER CREAM GO FRESH REVIVE 500ML', '30008872', NULL, NULL, 13, 1, NULL, 333, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 00:03:35', '2019-04-08 00:03:35'),
(342, 1, 3, 1, 'DOVE SHOWER CREAM ALMOND CREAM 500ML', '30008873', NULL, NULL, 13, 1, NULL, 334, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 00:04:31', '2019-04-08 00:04:31'),
(343, 1, 3, 1, 'ORAL-B BABY TOOTHBRUSH STAGE-2', '30009124', NULL, NULL, 9, 1, NULL, 335, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 00:05:43', '2019-04-08 00:05:43'),
(344, 1, 3, 1, 'ORAL-B TOOTHBRUSH 3D WHITE', '30009125', NULL, NULL, 9, 1, NULL, 336, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 00:06:20', '2019-04-08 00:06:20'),
(345, 1, 3, 1, 'LADY DIANA SUNBLOCK LOTION 200ML', '30009131', NULL, NULL, 1, 1, NULL, 337, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 00:07:27', '2019-04-08 00:07:27'),
(346, 1, 3, 1, 'VASELINE MEN FACE WASH 100ML', '30009135', NULL, NULL, 10, 1, NULL, 338, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 00:09:13', '2019-04-08 00:09:13'),
(347, 1, 3, 1, 'VASELINE MEN FACE SCRUB 100ML', '30009136', NULL, NULL, 11, 1, NULL, 339, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 00:10:19', '2019-04-08 00:10:19'),
(348, 1, 3, 1, 'OLD SPICE DEO STICK PURE SPORT 63G', '30009391', NULL, NULL, 19, 1, NULL, 340, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 00:11:34', '2019-04-08 00:11:34'),
(349, 1, 3, 1, 'COLGATE BABY TOOTHPASTE STRAWBER 50ML CN', '30009590', NULL, NULL, 17, 1, NULL, 341, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 00:12:42', '2019-04-08 00:12:42'),
(350, 1, 3, 1, 'JOHNSON\'S BABY GIFT BOX 5PCS CONTAINER', '30011059', NULL, NULL, 15, 1, NULL, 342, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 00:14:27', '2019-04-08 00:14:27'),
(351, 1, 3, 1, 'JOHNSON\'S BABY GIFT BOX 6PCS CONTAINER', '30011060', NULL, NULL, 15, 1, NULL, 343, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 00:15:18', '2019-04-08 00:15:18'),
(352, 1, 3, 1, 'JOHNSON\'S BABY POWDER WHITE 100G TH', '30011061', NULL, NULL, 16, 1, NULL, 344, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 00:16:28', '2019-04-08 00:16:28'),
(353, 1, 3, 1, 'JOHNSON\'S BABY POWDER PINK 100G TH', '30011062', NULL, NULL, 16, 1, NULL, 345, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 00:17:22', '2019-04-08 00:17:22'),
(354, 1, 3, 1, 'JOHNSON\'S BABY TOP TO TOE WASH 500ML TH', '30011067', NULL, NULL, 13, 1, NULL, 346, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:20:04', '2019-04-08 11:20:04'),
(355, 1, 3, 1, 'GARNIER FOAM LIGHT COMPLETE LEMON 100ML', '30011074', NULL, NULL, 10, 1, NULL, 347, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:21:08', '2019-04-08 11:21:08'),
(356, 1, 3, 1, 'CLEAN & CLEAR ACTIVE CLEAR CLEANSER 100G', '30011075', NULL, NULL, 10, 1, NULL, 348, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:21:52', '2019-04-08 11:21:52'),
(357, 1, 3, 1, 'CLEAN & CLEAR DEEP ACTION CLEANSER 100G', '30011076', NULL, NULL, 10, 1, NULL, 349, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:22:25', '2019-04-08 11:22:25'),
(358, 1, 3, 1, 'CLEAN & CLEAR CLEAR FAIRNES CLEANSR 100G', '30011077', NULL, NULL, 10, 1, NULL, 350, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:23:05', '2019-04-08 11:23:05'),
(359, 1, 3, 1, 'POND\'S WHITE BEAUTY CLEANSING MILK 150ML', '30011078', NULL, NULL, 26, 1, NULL, 351, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:23:56', '2019-04-08 11:25:06'),
(360, 1, 3, 1, 'POND\'S WHITE BEAUTY LIGHTEN TONER 150ML', '30011079', NULL, NULL, 26, 1, NULL, 352, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:25:56', '2019-04-08 11:25:56'),
(361, 1, 3, 1, 'GARNIER BODY LOTION LIGHT EXTRA 400ML', '30012800', NULL, NULL, 1, 1, NULL, 353, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:27:08', '2019-04-08 11:27:08'),
(362, 1, 3, 1, 'GRANDY AIR FRESHENER 138ML', '30013775', NULL, NULL, 7, 1, NULL, 354, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:29:18', '2019-04-08 11:29:18'),
(363, 1, 3, 1, 'GATSBY HAIR CREM ANTI DANDRUFF 250G', '30013790', NULL, NULL, 27, 1, NULL, 355, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:30:04', '2019-04-08 11:31:25'),
(364, 1, 3, 1, 'GATSBY HAIR CREM NOEMAL 250G', '30013791', NULL, NULL, 27, 1, NULL, 356, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:33:55', '2019-04-08 11:33:55'),
(365, 1, 3, 1, 'GATSBY HAIR CREM ANTI DANDRUFF 125G', '30013792', NULL, NULL, 27, 1, NULL, 357, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:35:13', '2019-04-08 11:35:13'),
(366, 1, 3, 1, 'GATSBY HAIR CREM NOEMAL 125G', '30013793', NULL, NULL, 27, 1, NULL, 358, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:35:48', '2019-04-08 11:35:48'),
(367, 1, 3, 1, 'AITELI SUN STAR BLM CR FRSHNER VANILA20G', '30014044', NULL, NULL, 7, 1, NULL, 359, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:36:38', '2019-04-08 11:36:38'),
(368, 1, 3, 1, 'AMBI PUR AFTER TOBACCO CR FRESHENER8ML', '30014047', NULL, NULL, 7, 1, NULL, 360, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:39:44', '2019-04-08 11:39:44'),
(369, 1, 3, 1, 'AMBI PUR LEMON CAR AIR FRESHENER 8 ML', '30014048', NULL, NULL, 7, 1, NULL, 361, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:40:17', '2019-04-08 11:40:17'),
(370, 1, 3, 1, 'AMBI PUR AQUA CAR AIR FRESHENER 8 ML', '30014049', NULL, NULL, 7, 1, NULL, 362, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:40:45', '2019-04-08 11:40:45'),
(371, 1, 3, 1, 'AMBI PUR PACIFIC CAR AIR FRESHENER 8 ML', '30014050', NULL, NULL, 7, 1, NULL, 363, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:41:53', '2019-04-08 11:41:53'),
(372, 1, 3, 1, 'AITELI CAR AIR FRESHENER  AQUA 8 ML', '30014051', NULL, NULL, 7, 1, NULL, 364, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:42:37', '2019-04-08 11:42:37'),
(373, 1, 3, 1, 'AITELI CAR AIR FRSHNER VANILA BOUQUET8ML', '30014052', NULL, NULL, 7, 1, NULL, 365, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:44:01', '2019-04-08 11:44:01'),
(374, 1, 3, 1, 'AITELI CAR AIR FRESHENER  PACIFIC AR 8ML', '30014053', NULL, NULL, 7, 1, NULL, 366, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:44:34', '2019-04-08 11:44:34'),
(375, 1, 3, 1, 'AITELI CAR AIR FRESHENER AFTR TOBACO8ML', '30014054', NULL, NULL, 7, 1, NULL, 367, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:45:13', '2019-04-08 11:45:13'),
(376, 1, 3, 1, 'OSION AIR REFILL LAVENDER SPA 8 ML', '30014055', NULL, NULL, 7, 1, NULL, 368, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:46:01', '2019-04-08 11:46:01'),
(377, 1, 3, 1, 'OSION AIR REFILL AFTER TOBACCO 8 ML', '30014056', NULL, NULL, 7, 1, NULL, 369, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:46:40', '2019-04-08 11:46:40'),
(378, 1, 3, 1, 'OSION AIR REFILL PACIFIC AIR 8 ML', '30014057', NULL, NULL, 7, 1, NULL, 370, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:47:10', '2019-04-08 11:47:10'),
(379, 1, 3, 1, 'OSION AIR REFILL AQUA 8 ML', '30014058', NULL, NULL, 7, 1, NULL, 371, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:47:48', '2019-04-08 11:47:48'),
(380, 1, 3, 1, 'AITELI CAR REFILL VANILLA BOUQUET 8 ML', '30014059', NULL, NULL, 7, 1, NULL, 372, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:48:28', '2019-04-08 11:48:28'),
(381, 1, 3, 1, 'AITELI CAR REFILL AQUA 8 ML', '30014060', NULL, NULL, 7, 1, NULL, 373, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:49:40', '2019-04-08 11:49:40'),
(382, 1, 3, 1, 'AITELI CAR REFILL AFTER TOBACCO 8 ML', '30014061', NULL, NULL, 7, 1, NULL, 374, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:50:38', '2019-04-08 11:50:38'),
(383, 1, 3, 1, 'AITELI CAR REFILL PACIFIC AIR 8 ML', '30014062', NULL, NULL, 7, 1, NULL, 375, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:51:10', '2019-04-08 11:51:10'),
(384, 1, 3, 1, 'COLUM AIR SPENCER CAR FRSHNER LEMON 80ML', '30014063', NULL, NULL, 7, 1, NULL, 376, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:52:47', '2019-04-08 11:52:47'),
(385, 1, 3, 1, 'COLUM AIR SPENCER CAR FRSHNER GREN 80ML', '30014064', NULL, NULL, 7, 1, NULL, 377, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:53:30', '2019-04-08 11:53:30'),
(386, 1, 3, 1, 'REXEL CAR SHAMPOO WASH & WAX 500 ML', '30014065', NULL, NULL, 28, 1, NULL, 378, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:54:59', '2019-04-08 11:58:36'),
(387, 1, 3, 1, 'REXEL CAR SHAMPOO SUPER CLEANER 500 ML', '30014066', NULL, NULL, 28, 1, NULL, 379, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 11:59:38', '2019-04-08 11:59:38'),
(388, 1, 3, 1, 'MOOV RAPID RELIFE SPRAY  150 ML', '30014067', NULL, NULL, 29, 1, NULL, 380, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:00:13', '2019-04-08 12:03:11'),
(389, 1, 3, 1, 'MOOV RAPID RELIFE MUSCLES & JOINTS 50 G', '30014068', NULL, NULL, 29, 1, NULL, 381, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:01:32', '2019-04-08 12:03:30'),
(390, 1, 3, 1, 'ZANDU BALM 8 ML', '30014069', NULL, NULL, 29, 1, NULL, 382, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:04:18', '2019-04-08 12:04:18'),
(391, 1, 3, 1, 'VICKS VAPORUB OINTMENT COLDS RELIEF 100G', '30010396', NULL, NULL, 29, 1, NULL, 383, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:25:32', '2019-04-08 12:25:32'),
(392, 1, 3, 1, 'VICKS VAPORUB OINTMENT COLDS RELIEF 50G', '30010397', NULL, NULL, 29, 1, NULL, 384, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:26:14', '2019-04-08 12:26:14'),
(393, 1, 3, 1, 'AXE BRAND UNIVERSAL OIL QUICK RELIF 56ML', '30010398', NULL, NULL, 29, 1, NULL, 385, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:26:54', '2019-04-08 12:26:54'),
(394, 1, 3, 1, 'AXE BRAND UNIVERSAL OIL QUICK RELIF 28ML', '30010399', NULL, NULL, 29, 1, NULL, 386, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:27:38', '2019-04-08 12:27:38'),
(395, 1, 3, 1, 'TIGER BALM RED OINTMENT 19.4G', '30010400', NULL, NULL, 29, 1, NULL, 387, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:28:13', '2019-04-08 12:28:13'),
(396, 1, 3, 1, 'WATSON MINT DENTAL FLOSSERS 50PCS TH', '30008632', NULL, NULL, 30, 1, NULL, 388, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:29:52', '2019-04-08 12:33:00'),
(399, 1, 3, 1, 'WATSON  DENTAL FLOSSERS 50PCS TH', '30008633', NULL, NULL, 30, 1, NULL, 389, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:46:35', '2019-04-08 12:46:35'),
(400, 1, 3, 1, 'PALMOLIVE SHOWER GEL MINERAL MASSG 500ML', '30009096', NULL, NULL, 13, 1, NULL, 390, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:48:23', '2019-04-08 12:48:23'),
(401, 1, 3, 1, 'FEVI STIK SUPER GLUE STICK 15G', '30009098', NULL, NULL, 31, 1, NULL, 391, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:49:06', '2019-04-08 12:51:02'),
(402, 1, 3, 1, 'FEVICOL MR EASY FLOW WHITE ADHESIV 22.5G', '30009099', NULL, NULL, 31, 1, NULL, 392, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:51:56', '2019-04-08 12:51:56'),
(403, 1, 3, 1, 'FEVICOL MR  WHITE ADHESIVE 50G', '30009100', NULL, NULL, 31, 1, NULL, 393, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:52:53', '2019-04-08 12:52:53'),
(404, 1, 3, 1, 'FEVIGUM LIME PIDILITE 18ML', '30009101', NULL, NULL, 31, 1, NULL, 394, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:54:05', '2019-04-08 12:54:05'),
(405, 1, 3, 1, 'RANGEELA PAPER GLITTER 6 SHADES 30ML', '30009102', NULL, NULL, 31, 1, NULL, 395, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:54:52', '2019-04-08 12:54:52'),
(406, 1, 3, 1, 'FEVICOL SUPER GLUE 3G CN', '30008054', NULL, NULL, 31, 1, NULL, 396, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 12:55:47', '2019-04-08 12:55:47'),
(407, 1, 3, 1, 'Johnson Baby Hair Oil 100 ml (Ind)', '2100049', NULL, NULL, 12, 1, NULL, 397, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 13:00:23', '2019-04-08 13:00:23'),
(408, 1, 3, 1, 'Johnson Milk Lotion Ma 100 ml', '2100083', NULL, NULL, 1, 1, NULL, 398, 1, NULL, 0, 0, '', 0, 0, 1, 1, '2019-04-08 13:03:03', '2019-04-08 13:03:03'),
(409, 1, 3, 1, 'Johnson Baby Pink Lotion 100 ml', '2100087', NULL, NULL, 1, 1, NULL, 399, 1, NULL, 0, 0, '', 0, 0, 1, 1, '2019-04-08 13:04:05', '2019-04-08 13:04:05'),
(410, 1, 3, 1, 'Johnson Baby Pink Lotion 300 ml (Italy)', '2100090', NULL, NULL, 1, 1, NULL, 400, 1, NULL, 0, 0, '', 0, 0, 1, 1, '2019-04-08 13:08:06', '2019-04-08 13:08:06'),
(411, 1, 3, 1, 'Johnson Baby Milk Cream 50g Tube(ind.)', '2100102', NULL, NULL, 6, 1, NULL, 401, 1, NULL, 0, 0, '', 1, 0, 1, 1, '2019-04-08 13:31:57', '2019-04-08 13:31:57'),
(412, 1, 3, 1, 'Johnson Baby Cream 50gm Tube(ind.)', '2100103', NULL, NULL, 6, 1, NULL, 402, 1, NULL, 0, 0, '', 0, 0, 1, 1, '2019-04-08 13:33:11', '2019-04-08 13:33:11');

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

--
-- Dumping data for table `priceinfos`
--

INSERT INTO `priceinfos` (`price_id`, `item_id`, `purchase_price`, `sale_price`, `status`, `created_by`, `updated_by`, `created_at`, `updated_at`) VALUES
(256, 257, 0.00, 0.00, 1, 1, NULL, '2019-04-07 11:05:18', '0000-00-00 00:00:00'),
(257, 258, 0.00, 0.00, 1, 1, NULL, '2019-04-07 11:59:54', '0000-00-00 00:00:00'),
(258, 259, 0.00, 0.00, 1, 1, NULL, '2019-04-07 12:51:37', '0000-00-00 00:00:00'),
(260, 262, 0.00, 0.00, 1, 1, NULL, '2019-04-07 13:41:31', '0000-00-00 00:00:00'),
(261, 263, 0.00, 0.00, 1, 1, NULL, '2019-04-07 13:47:32', '0000-00-00 00:00:00'),
(262, 264, 0.00, 0.00, 1, 1, NULL, '2019-04-07 13:52:42', '0000-00-00 00:00:00'),
(263, 265, 0.00, 0.00, 1, 1, NULL, '2019-04-07 13:58:51', '0000-00-00 00:00:00'),
(264, 266, 0.00, 0.00, 1, 1, NULL, '2019-04-07 14:01:59', '0000-00-00 00:00:00'),
(265, 267, 0.00, 0.00, 1, 1, NULL, '2019-04-07 14:03:10', '0000-00-00 00:00:00'),
(266, 268, 0.00, 0.00, 1, 1, NULL, '2019-04-07 14:04:06', '0000-00-00 00:00:00'),
(267, 269, 0.00, 0.00, 1, 1, NULL, '2019-04-07 14:05:19', '0000-00-00 00:00:00'),
(268, 270, 0.00, 0.00, 1, 1, NULL, '2019-04-07 14:06:08', '0000-00-00 00:00:00'),
(269, 271, 0.00, 0.00, 1, 1, NULL, '2019-04-07 14:11:44', '0000-00-00 00:00:00'),
(270, 272, 0.00, 0.00, 1, 1, NULL, '2019-04-07 14:17:35', '0000-00-00 00:00:00'),
(271, 273, 0.00, 0.00, 1, 1, NULL, '2019-04-07 14:20:40', '0000-00-00 00:00:00'),
(272, 274, 0.00, 0.00, 1, 1, NULL, '2019-04-07 14:24:21', '0000-00-00 00:00:00'),
(273, 275, 0.00, 0.00, 1, 1, NULL, '2019-04-07 14:25:05', '0000-00-00 00:00:00'),
(274, 276, 0.00, 0.00, 1, 1, NULL, '2019-04-07 14:26:57', '0000-00-00 00:00:00'),
(275, 277, 0.00, 0.00, 1, 1, NULL, '2019-04-07 14:52:21', '0000-00-00 00:00:00'),
(276, 278, 0.00, 0.00, 1, 1, NULL, '2019-04-07 14:55:24', '0000-00-00 00:00:00'),
(277, 279, 0.00, 0.00, 1, 1, NULL, '2019-04-07 14:58:19', '0000-00-00 00:00:00'),
(278, 280, 0.00, 0.00, 1, 1, NULL, '2019-04-07 14:58:52', '0000-00-00 00:00:00'),
(279, 281, 0.00, 0.00, 1, 1, NULL, '2019-04-07 15:01:15', '0000-00-00 00:00:00'),
(280, 282, 0.00, 0.00, 1, 1, NULL, '2019-04-07 15:19:29', '0000-00-00 00:00:00'),
(281, 283, 0.00, 0.00, 1, 1, NULL, '2019-04-07 15:20:14', '0000-00-00 00:00:00'),
(282, 284, 0.00, 0.00, 1, 1, NULL, '2019-04-07 15:20:52', '0000-00-00 00:00:00'),
(283, 285, 0.00, 0.00, 1, 1, NULL, '2019-04-07 15:21:56', '0000-00-00 00:00:00'),
(284, 286, 0.00, 0.00, 1, 1, NULL, '2019-04-07 15:23:19', '0000-00-00 00:00:00'),
(285, 287, 0.00, 0.00, 1, 1, NULL, '2019-04-07 15:23:56', '0000-00-00 00:00:00'),
(286, 288, 0.00, 0.00, 1, 1, NULL, '2019-04-07 15:24:46', '0000-00-00 00:00:00'),
(287, 289, 0.00, 0.00, 1, 1, NULL, '2019-04-07 15:35:39', '0000-00-00 00:00:00'),
(288, 290, 0.00, 0.00, 1, 1, NULL, '2019-04-07 16:55:36', '0000-00-00 00:00:00'),
(289, 291, 0.00, 0.00, 1, 1, NULL, '2019-04-07 16:56:16', '0000-00-00 00:00:00'),
(290, 292, 0.00, 0.00, 1, 1, NULL, '2019-04-07 16:56:50', '0000-00-00 00:00:00'),
(291, 293, 0.00, 0.00, 1, 1, NULL, '2019-04-07 16:59:26', '0000-00-00 00:00:00'),
(292, 294, 0.00, 0.00, 1, 1, NULL, '2019-04-07 17:12:55', '0000-00-00 00:00:00'),
(293, 295, 0.00, 0.00, 1, 1, NULL, '2019-04-07 17:19:13', '0000-00-00 00:00:00'),
(294, 296, 0.00, 0.00, 1, 1, NULL, '2019-04-07 17:22:06', '0000-00-00 00:00:00'),
(295, 297, 0.00, 0.00, 1, 1, NULL, '2019-04-07 17:28:08', '0000-00-00 00:00:00'),
(296, 298, 0.00, 0.00, 1, 1, NULL, '2019-04-07 17:30:31', '0000-00-00 00:00:00'),
(297, 299, 0.00, 0.00, 1, 1, NULL, '2019-04-07 17:31:18', '0000-00-00 00:00:00'),
(298, 300, 0.00, 0.00, 1, 1, NULL, '2019-04-07 17:31:56', '0000-00-00 00:00:00'),
(299, 301, 0.00, 0.00, 1, 1, NULL, '2019-04-07 17:32:52', '0000-00-00 00:00:00'),
(300, 302, 0.00, 0.00, 1, 1, NULL, '2019-04-07 17:33:38', '0000-00-00 00:00:00'),
(301, 303, 0.00, 0.00, 1, 1, NULL, '2019-04-07 17:34:21', '0000-00-00 00:00:00'),
(302, 304, 0.00, 0.00, 1, 1, NULL, '2019-04-07 17:35:06', '0000-00-00 00:00:00'),
(303, 305, 0.00, 0.00, 1, 1, NULL, '2019-04-07 17:39:00', '0000-00-00 00:00:00'),
(304, 306, 0.00, 0.00, 1, 1, NULL, '2019-04-07 17:39:45', '0000-00-00 00:00:00'),
(305, 307, 0.00, 0.00, 1, 1, NULL, '2019-04-07 22:33:59', '0000-00-00 00:00:00'),
(306, 308, 0.00, 0.00, 1, 1, NULL, '2019-04-07 22:35:09', '0000-00-00 00:00:00'),
(307, 309, 0.00, 0.00, 1, 1, NULL, '2019-04-07 22:35:51', '0000-00-00 00:00:00'),
(308, 310, 0.00, 0.00, 1, 1, NULL, '2019-04-07 22:36:36', '0000-00-00 00:00:00'),
(309, 311, 0.00, 0.00, 1, 1, NULL, '2019-04-07 22:37:42', '0000-00-00 00:00:00'),
(310, 312, 0.00, 0.00, 1, 1, NULL, '2019-04-07 22:38:39', '0000-00-00 00:00:00'),
(311, 313, 0.00, 0.00, 1, 1, NULL, '2019-04-07 22:39:25', '0000-00-00 00:00:00'),
(312, 314, 0.00, 0.00, 1, 1, NULL, '2019-04-07 22:41:09', '0000-00-00 00:00:00'),
(313, 315, 0.00, 0.00, 1, 1, NULL, '2019-04-07 22:42:13', '0000-00-00 00:00:00'),
(314, 316, 0.00, 0.00, 1, 1, NULL, '2019-04-07 22:47:13', '0000-00-00 00:00:00'),
(315, 322, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:00:23', '0000-00-00 00:00:00'),
(316, 323, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:01:29', '0000-00-00 00:00:00'),
(317, 324, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:02:28', '0000-00-00 00:00:00'),
(318, 325, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:07:02', '0000-00-00 00:00:00'),
(319, 326, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:36:38', '0000-00-00 00:00:00'),
(320, 327, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:46:28', '0000-00-00 00:00:00'),
(321, 328, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:47:45', '0000-00-00 00:00:00'),
(322, 329, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:48:38', '0000-00-00 00:00:00'),
(323, 330, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:49:28', '0000-00-00 00:00:00'),
(324, 331, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:50:14', '0000-00-00 00:00:00'),
(325, 332, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:50:59', '0000-00-00 00:00:00'),
(326, 333, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:52:00', '0000-00-00 00:00:00'),
(327, 334, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:52:58', '0000-00-00 00:00:00'),
(328, 335, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:54:04', '0000-00-00 00:00:00'),
(329, 336, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:54:54', '0000-00-00 00:00:00'),
(330, 337, 0.00, 0.00, 1, 1, NULL, '2019-04-07 23:56:27', '0000-00-00 00:00:00'),
(331, 338, 0.00, 0.00, 1, 1, NULL, '2019-04-08 00:01:54', '0000-00-00 00:00:00'),
(332, 339, 0.00, 0.00, 1, 1, NULL, '2019-04-08 00:02:38', '0000-00-00 00:00:00'),
(333, 340, 0.00, 0.00, 1, 1, NULL, '2019-04-08 00:03:35', '0000-00-00 00:00:00'),
(334, 342, 0.00, 0.00, 1, 1, NULL, '2019-04-08 00:04:31', '0000-00-00 00:00:00'),
(335, 343, 0.00, 0.00, 1, 1, NULL, '2019-04-08 00:05:43', '0000-00-00 00:00:00'),
(336, 344, 0.00, 0.00, 1, 1, NULL, '2019-04-08 00:06:20', '0000-00-00 00:00:00'),
(337, 345, 0.00, 0.00, 1, 1, NULL, '2019-04-08 00:07:27', '0000-00-00 00:00:00'),
(338, 346, 0.00, 0.00, 1, 1, NULL, '2019-04-08 00:09:13', '0000-00-00 00:00:00'),
(339, 347, 0.00, 0.00, 1, 1, NULL, '2019-04-08 00:10:19', '0000-00-00 00:00:00'),
(340, 348, 0.00, 0.00, 1, 1, NULL, '2019-04-08 00:11:34', '0000-00-00 00:00:00'),
(341, 349, 0.00, 0.00, 1, 1, NULL, '2019-04-08 00:12:42', '0000-00-00 00:00:00'),
(342, 350, 0.00, 0.00, 1, 1, NULL, '2019-04-08 00:14:27', '0000-00-00 00:00:00'),
(343, 351, 0.00, 0.00, 1, 1, NULL, '2019-04-08 00:15:18', '0000-00-00 00:00:00'),
(344, 352, 0.00, 0.00, 1, 1, NULL, '2019-04-08 00:16:28', '0000-00-00 00:00:00'),
(345, 353, 0.00, 0.00, 1, 1, NULL, '2019-04-08 00:17:22', '0000-00-00 00:00:00'),
(346, 354, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:20:04', '0000-00-00 00:00:00'),
(347, 355, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:21:08', '0000-00-00 00:00:00'),
(348, 356, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:21:52', '0000-00-00 00:00:00'),
(349, 357, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:22:25', '0000-00-00 00:00:00'),
(350, 358, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:23:05', '0000-00-00 00:00:00'),
(351, 359, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:23:56', '0000-00-00 00:00:00'),
(352, 360, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:25:56', '0000-00-00 00:00:00'),
(353, 361, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:27:08', '0000-00-00 00:00:00'),
(354, 362, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:29:18', '0000-00-00 00:00:00'),
(355, 363, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:30:04', '0000-00-00 00:00:00'),
(356, 364, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:33:55', '0000-00-00 00:00:00'),
(357, 365, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:35:13', '0000-00-00 00:00:00'),
(358, 366, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:35:48', '0000-00-00 00:00:00'),
(359, 367, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:36:38', '0000-00-00 00:00:00'),
(360, 368, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:39:44', '0000-00-00 00:00:00'),
(361, 369, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:40:17', '0000-00-00 00:00:00'),
(362, 370, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:40:45', '0000-00-00 00:00:00'),
(363, 371, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:41:53', '0000-00-00 00:00:00'),
(364, 372, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:42:37', '0000-00-00 00:00:00'),
(365, 373, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:44:01', '0000-00-00 00:00:00'),
(366, 374, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:44:34', '0000-00-00 00:00:00'),
(367, 375, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:45:13', '0000-00-00 00:00:00'),
(368, 376, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:46:01', '0000-00-00 00:00:00'),
(369, 377, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:46:40', '0000-00-00 00:00:00'),
(370, 378, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:47:10', '0000-00-00 00:00:00'),
(371, 379, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:47:48', '0000-00-00 00:00:00'),
(372, 380, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:48:28', '0000-00-00 00:00:00'),
(373, 381, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:49:40', '0000-00-00 00:00:00'),
(374, 382, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:50:38', '0000-00-00 00:00:00'),
(375, 383, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:51:10', '0000-00-00 00:00:00'),
(376, 384, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:52:47', '0000-00-00 00:00:00'),
(377, 385, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:53:30', '0000-00-00 00:00:00'),
(378, 386, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:54:59', '0000-00-00 00:00:00'),
(379, 387, 0.00, 0.00, 1, 1, NULL, '2019-04-08 11:59:38', '0000-00-00 00:00:00'),
(380, 388, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:00:13', '0000-00-00 00:00:00'),
(381, 389, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:01:32', '0000-00-00 00:00:00'),
(382, 390, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:04:18', '0000-00-00 00:00:00'),
(383, 391, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:25:32', '0000-00-00 00:00:00'),
(384, 392, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:26:14', '0000-00-00 00:00:00'),
(385, 393, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:26:54', '0000-00-00 00:00:00'),
(386, 394, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:27:38', '0000-00-00 00:00:00'),
(387, 395, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:28:13', '0000-00-00 00:00:00'),
(388, 396, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:29:52', '0000-00-00 00:00:00'),
(389, 399, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:46:35', '0000-00-00 00:00:00'),
(390, 400, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:48:23', '0000-00-00 00:00:00'),
(391, 401, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:49:06', '0000-00-00 00:00:00'),
(392, 402, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:51:56', '0000-00-00 00:00:00'),
(393, 403, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:52:53', '0000-00-00 00:00:00'),
(394, 404, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:54:05', '0000-00-00 00:00:00'),
(395, 405, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:54:52', '0000-00-00 00:00:00'),
(396, 406, 0.00, 0.00, 1, 1, NULL, '2019-04-08 12:55:47', '0000-00-00 00:00:00'),
(397, 407, 0.00, 0.00, 1, 1, NULL, '2019-04-08 13:00:23', '0000-00-00 00:00:00'),
(398, 408, 0.00, 0.00, 1, 1, NULL, '2019-04-08 13:03:03', '0000-00-00 00:00:00'),
(399, 409, 0.00, 0.00, 1, 1, NULL, '2019-04-08 13:04:05', '0000-00-00 00:00:00'),
(400, 410, 0.00, 0.00, 1, 1, NULL, '2019-04-08 13:08:06', '0000-00-00 00:00:00'),
(401, 411, 0.00, 0.00, 1, 1, NULL, '2019-04-08 13:31:57', '0000-00-00 00:00:00'),
(402, 412, 0.00, 0.00, 1, 1, NULL, '2019-04-08 13:33:11', '0000-00-00 00:00:00');

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
(1, 'MR Traders', 1);

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
(1, 'Metro and Co.', 'metro_and_co', '', '', '', '', '0125', 'metro@gmail.com', 0, 0, 1, 1, 1, '2018-04-15 17:47:46', '2019-01-28 20:12:10'),
(2, 'Emon Store', 'emon', '', 'Old Town', 'Old Town', '', '0257318193', 'emon@gmail.com', 0, 0, 1, 1, 1, '2019-04-07 12:43:36', '2019-04-07 12:44:14'),
(3, 'MR Traders', 'mrtrade', '', 'ad', 'ad', '', '1245', 'mr@gmail.com', 0, 0, 1, 1, NULL, '2019-04-07 13:09:07', '0000-00-00 00:00:00');

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
(1, 1, 1, 1, 0, NULL, '2015-12-08 15:51:27', '0000-00-00 00:00:00'),
(2, 2, 1, 1, 1, NULL, '2015-12-08 15:53:53', '0000-00-00 00:00:00'),
(3, 3, 1, 1, 1, NULL, '2015-12-08 15:53:53', '0000-00-00 00:00:00'),
(4, 4, 1, 1, 1, NULL, '2015-12-08 15:53:53', '0000-00-00 00:00:00'),
(5, 5, 1, 1, 1, NULL, '2015-12-08 15:53:53', '0000-00-00 00:00:00'),
(6, 7, 1, 1, 1, NULL, '2015-12-08 15:53:53', '0000-00-00 00:00:00'),
(7, 8, 1, 1, 1, NULL, '2015-12-08 15:53:53', '0000-00-00 00:00:00'),
(8, 9, 1, 1, 1, NULL, '2015-12-08 15:53:53', '0000-00-00 00:00:00'),
(9, 10, 1, 1, 1, NULL, '2015-12-08 15:53:53', '0000-00-00 00:00:00'),
(10, 11, 1, 1, 1, NULL, '2015-12-08 15:53:53', '0000-00-00 00:00:00'),
(11, 1, 2, 1, 1, NULL, '2015-12-13 10:23:58', '0000-00-00 00:00:00'),
(12, 2, 2, 1, 1, NULL, '2015-12-13 10:23:58', '0000-00-00 00:00:00'),
(13, 3, 2, 1, 1, NULL, '2015-12-13 10:23:58', '0000-00-00 00:00:00'),
(14, 4, 2, 1, 1, NULL, '2015-12-13 10:23:58', '0000-00-00 00:00:00'),
(15, 5, 2, 1, 1, NULL, '2015-12-13 10:23:58', '0000-00-00 00:00:00'),
(18, 9, 2, 1, 1, NULL, '2015-12-13 10:23:58', '0000-00-00 00:00:00'),
(19, 10, 2, 1, 1, NULL, '2015-12-13 10:23:58', '0000-00-00 00:00:00'),
(21, 1, 3, 1, 1, NULL, '2016-01-23 02:12:13', '0000-00-00 00:00:00'),
(22, 2, 3, 1, 1, NULL, '2016-01-23 02:12:13', '0000-00-00 00:00:00'),
(23, 3, 3, 1, 1, NULL, '2016-01-23 02:12:13', '0000-00-00 00:00:00'),
(24, 4, 3, 1, 1, NULL, '2016-01-23 02:12:13', '0000-00-00 00:00:00'),
(25, 5, 3, 1, 1, NULL, '2016-01-23 02:12:13', '0000-00-00 00:00:00'),
(28, 9, 3, 1, 1, NULL, '2016-01-23 02:12:13', '0000-00-00 00:00:00'),
(29, 10, 3, 1, 1, NULL, '2016-01-23 02:12:13', '0000-00-00 00:00:00'),
(37, 8, 4, 1, 1, NULL, '2016-01-23 02:24:11', '0000-00-00 00:00:00'),
(40, 11, 4, 1, 1, NULL, '2016-01-23 02:24:12', '0000-00-00 00:00:00'),
(47, 8, 5, 1, 1, NULL, '2016-01-24 02:52:08', '0000-00-00 00:00:00'),
(50, 11, 5, 1, 1, NULL, '2016-01-24 02:52:08', '0000-00-00 00:00:00'),
(57, 8, 6, 1, 1, NULL, '2016-01-24 03:02:23', '0000-00-00 00:00:00'),
(60, 11, 6, 1, 1, NULL, '2016-01-24 03:02:23', '0000-00-00 00:00:00'),
(67, 8, 7, 1, 1, NULL, '2016-01-24 04:43:46', '0000-00-00 00:00:00'),
(70, 11, 7, 1, 1, NULL, '2016-01-24 04:43:46', '0000-00-00 00:00:00'),
(71, 1, 8, 1, 1, NULL, '2016-01-24 23:31:26', '0000-00-00 00:00:00'),
(72, 2, 8, 1, 1, NULL, '2016-01-24 23:31:26', '0000-00-00 00:00:00'),
(73, 3, 8, 1, 1, NULL, '2016-01-24 23:31:26', '0000-00-00 00:00:00'),
(74, 4, 8, 1, 1, NULL, '2016-01-24 23:31:26', '0000-00-00 00:00:00'),
(75, 5, 8, 1, 1, NULL, '2016-01-24 23:31:26', '0000-00-00 00:00:00'),
(76, 7, 8, 1, 1, NULL, '2016-01-24 23:31:26', '0000-00-00 00:00:00'),
(77, 8, 8, 1, 1, NULL, '2016-01-24 23:31:26', '0000-00-00 00:00:00'),
(78, 9, 8, 1, 1, NULL, '2016-01-24 23:31:26', '0000-00-00 00:00:00'),
(79, 10, 8, 1, 1, NULL, '2016-01-24 23:31:26', '0000-00-00 00:00:00'),
(80, 11, 8, 1, 1, NULL, '2016-01-24 23:31:26', '0000-00-00 00:00:00'),
(81, 1, 9, 1, 1, NULL, '2016-01-25 23:28:24', '0000-00-00 00:00:00'),
(82, 2, 9, 1, 1, NULL, '2016-01-25 23:28:24', '0000-00-00 00:00:00'),
(83, 3, 9, 1, 1, NULL, '2016-01-25 23:28:24', '0000-00-00 00:00:00'),
(84, 4, 9, 1, 1, NULL, '2016-01-25 23:28:24', '0000-00-00 00:00:00'),
(85, 5, 9, 1, 1, NULL, '2016-01-25 23:28:24', '0000-00-00 00:00:00'),
(86, 7, 9, 1, 1, NULL, '2016-01-25 23:28:24', '0000-00-00 00:00:00'),
(87, 8, 9, 1, 1, NULL, '2016-01-25 23:28:24', '0000-00-00 00:00:00'),
(88, 9, 9, 1, 1, NULL, '2016-01-25 23:28:24', '0000-00-00 00:00:00'),
(89, 10, 9, 1, 1, NULL, '2016-01-25 23:28:24', '0000-00-00 00:00:00'),
(90, 11, 9, 1, 1, NULL, '2016-01-25 23:28:24', '0000-00-00 00:00:00'),
(97, 8, 10, 1, 1, NULL, '2016-01-25 23:51:09', '0000-00-00 00:00:00'),
(100, 11, 10, 1, 1, NULL, '2016-01-25 23:51:09', '0000-00-00 00:00:00'),
(101, 1, 4, 1, 1, NULL, '2016-01-29 03:12:20', '0000-00-00 00:00:00'),
(102, 2, 4, 1, 1, NULL, '2016-01-29 03:12:20', '0000-00-00 00:00:00'),
(103, 3, 4, 1, 1, NULL, '2016-01-29 03:12:20', '0000-00-00 00:00:00'),
(104, 4, 4, 1, 1, NULL, '2016-01-29 03:12:20', '0000-00-00 00:00:00'),
(105, 7, 4, 1, 1, NULL, '2016-01-29 03:12:21', '0000-00-00 00:00:00'),
(106, 9, 4, 1, 1, NULL, '2016-01-29 03:12:21', '0000-00-00 00:00:00'),
(109, 11, 11, 1, 1, NULL, '2017-08-20 16:02:05', '0000-00-00 00:00:00'),
(110, 11, 12, 1, 1, NULL, '2017-08-20 17:01:21', '0000-00-00 00:00:00'),
(111, 11, 13, 1, 1, NULL, '2017-08-20 20:57:22', '0000-00-00 00:00:00'),
(112, 1, 14, 1, 1, NULL, '2017-08-20 21:02:38', '0000-00-00 00:00:00'),
(116, 8, 15, 1, 1, NULL, '2017-08-25 13:05:15', '0000-00-00 00:00:00'),
(117, 1, 12, 1, 1, NULL, '2017-08-27 22:49:25', '0000-00-00 00:00:00'),
(118, 2, 12, 1, 1, NULL, '2017-08-27 22:49:25', '0000-00-00 00:00:00'),
(119, 3, 12, 1, 1, NULL, '2017-08-27 22:49:25', '0000-00-00 00:00:00'),
(120, 4, 12, 1, 1, NULL, '2017-08-27 22:49:25', '0000-00-00 00:00:00'),
(121, 8, 11, 1, 1, NULL, '2017-11-19 13:45:35', '0000-00-00 00:00:00'),
(122, 2, 14, 1, 1, NULL, '2017-12-11 20:26:35', '0000-00-00 00:00:00'),
(123, 4, 14, 1, 1, NULL, '2017-12-11 20:26:35', '0000-00-00 00:00:00'),
(124, 5, 14, 1, 1, NULL, '2017-12-11 20:26:35', '0000-00-00 00:00:00'),
(125, 7, 14, 1, 1, NULL, '2017-12-11 20:26:35', '0000-00-00 00:00:00'),
(126, 3, 14, 1, 1, NULL, '2017-12-11 20:30:32', '0000-00-00 00:00:00'),
(127, 8, 14, 1, 1, NULL, '2017-12-11 20:30:32', '0000-00-00 00:00:00'),
(128, 9, 14, 1, 1, NULL, '2017-12-11 20:30:32', '0000-00-00 00:00:00'),
(129, 10, 14, 1, 1, NULL, '2017-12-11 20:30:32', '0000-00-00 00:00:00'),
(130, 11, 14, 1, 1, NULL, '2017-12-11 20:30:32', '0000-00-00 00:00:00'),
(131, 7, 2, 1, 1, NULL, '2018-02-17 16:26:39', '0000-00-00 00:00:00'),
(132, 8, 2, 1, 1, NULL, '2018-02-17 16:26:39', '0000-00-00 00:00:00'),
(133, 11, 2, 1, 1, NULL, '2018-02-17 16:26:39', '0000-00-00 00:00:00'),
(134, 7, 3, 1, 1, NULL, '2018-02-17 16:28:47', '0000-00-00 00:00:00'),
(135, 8, 3, 1, 1, NULL, '2018-02-17 16:28:47', '0000-00-00 00:00:00'),
(136, 11, 3, 1, 1, NULL, '2018-02-17 16:28:47', '0000-00-00 00:00:00'),
(137, 1, 18, 1, 1, NULL, '2018-03-21 10:06:46', '0000-00-00 00:00:00'),
(138, 2, 18, 1, 1, NULL, '2018-03-21 10:06:46', '0000-00-00 00:00:00'),
(139, 3, 18, 1, 1, NULL, '2018-03-21 10:06:46', '0000-00-00 00:00:00'),
(140, 4, 18, 1, 1, NULL, '2018-03-21 10:06:46', '0000-00-00 00:00:00'),
(141, 5, 18, 1, 1, NULL, '2018-03-21 10:06:46', '0000-00-00 00:00:00'),
(142, 7, 18, 1, 1, NULL, '2018-03-21 10:06:46', '0000-00-00 00:00:00'),
(143, 8, 18, 1, 1, NULL, '2018-03-21 10:06:46', '0000-00-00 00:00:00'),
(144, 9, 18, 1, 1, NULL, '2018-03-21 10:06:46', '0000-00-00 00:00:00'),
(145, 10, 18, 1, 1, NULL, '2018-03-21 10:06:46', '0000-00-00 00:00:00'),
(146, 11, 18, 1, 1, NULL, '2018-03-21 10:06:46', '0000-00-00 00:00:00'),
(147, 1, 19, 1, 1, NULL, '2018-04-02 10:48:06', '0000-00-00 00:00:00'),
(148, 2, 19, 1, 1, NULL, '2018-04-02 10:48:06', '0000-00-00 00:00:00'),
(149, 3, 19, 1, 1, NULL, '2018-04-02 10:48:06', '0000-00-00 00:00:00'),
(150, 4, 19, 1, 1, NULL, '2018-04-02 10:48:06', '0000-00-00 00:00:00'),
(151, 5, 19, 1, 1, NULL, '2018-04-02 10:48:06', '0000-00-00 00:00:00'),
(152, 7, 19, 1, 1, NULL, '2018-04-02 10:48:06', '0000-00-00 00:00:00'),
(153, 8, 19, 1, 1, NULL, '2018-04-02 10:48:06', '0000-00-00 00:00:00'),
(154, 9, 19, 1, 1, NULL, '2018-04-02 10:48:06', '0000-00-00 00:00:00'),
(155, 10, 19, 1, 1, NULL, '2018-04-02 10:48:06', '0000-00-00 00:00:00'),
(156, 11, 19, 1, 1, NULL, '2018-04-02 10:48:06', '0000-00-00 00:00:00');

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
(1, 1, 1, 1, '2015-04-26 12:30:14', NULL),
(2, 2, 1, 1, '2015-04-26 12:30:14', NULL),
(3, 3, 1, 1, '2015-04-26 12:30:32', NULL),
(4, 4, 1, 1, '2015-04-26 12:30:32', NULL),
(5, 5, 1, 1, '2015-05-02 00:31:44', NULL),
(6, 7, 0, 1, '2015-05-02 00:31:44', NULL),
(7, 8, 1, 1, '2015-05-02 00:32:49', NULL),
(8, 9, 1, 1, '2015-05-06 11:50:31', NULL),
(9, 10, 1, 1, '2015-05-06 11:50:31', NULL),
(10, 11, 1, 1, '2015-05-31 04:24:24', NULL);

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
(1, 'Add new Item', 'admin.itemAddForm', 1, '2015-04-07 04:37:01', '0000-00-00 00:00:00'),
(2, 'Barcode Print', 'barcode.post', 1, '2015-04-07 04:38:34', '0000-00-00 00:00:00'),
(3, 'WareHouse Items View', 'admin.godownItem', 1, '2015-04-07 04:47:44', '0000-00-00 00:00:00'),
(4, 'Recently Added Item', 'admin.getRecentItems', 1, '2015-04-07 04:45:18', '0000-00-00 00:00:00'),
(5, 'Damage Products', 'damage.index', 1, '2015-05-02 00:25:26', NULL),
(7, 'Return to WareHouse', 'send.returnToGodown', 1, '2015-05-02 00:25:51', NULL),
(8, 'Sales Return -Customer', 'saleReturn.index', 1, '2015-05-02 00:26:18', NULL),
(9, 'Return Receive', 'returnReceive', 1, '2015-05-06 11:49:45', NULL),
(10, 'Purchase Return to Supplier', 'purchase.returnToSupplier', 1, '2015-05-06 11:49:45', NULL),
(11, 'Item wise Return from customer', 'admin.returnQtyFromCustomer', 1, '2015-05-31 04:23:23', NULL);

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
  ADD UNIQUE KEY `article_number` (`article_number`),
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
  MODIFY `cus_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
  MODIFY `emp_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

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
  MODIFY `category_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `itemdamages`
--
ALTER TABLE `itemdamages`
  MODIFY `i_damage_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `iteminfos`
--
ALTER TABLE `iteminfos`
  MODIFY `item_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=413;

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
  MODIFY `price_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=403;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
  MODIFY `supp_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
