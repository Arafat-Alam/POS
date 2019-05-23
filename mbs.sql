-- --------------------------------------------------------
-- Host:                         192.168.0.150
-- Server version:               10.1.38-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             9.5.0.5196
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for mbs
CREATE DATABASE IF NOT EXISTS `mbs` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `mbs`;

-- Dumping structure for table mbs.branch_info
CREATE TABLE IF NOT EXISTS `branch_info` (
  `branch_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `branch_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table mbs.companynames
CREATE TABLE IF NOT EXISTS `companynames` (
  `company_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_name` varchar(50) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '0=inactive, 1=active',
  `created_by` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`company_id`),
  UNIQUE KEY `company_name` (`company_name`),
  KEY `FK_companynames_empinfos` (`created_by`),
  KEY `FK_companynames_empinfos_2` (`updated_by`),
  KEY `company_id` (`company_id`),
  CONSTRAINT `FK_companynames_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_companynames_empinfos_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table mbs.companyprofiles
CREATE TABLE IF NOT EXISTS `companyprofiles` (
  `company_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_name` text COLLATE utf8_unicode_ci NOT NULL,
  `address` text COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `web_address` text COLLATE utf8_unicode_ci NOT NULL,
  `return_policy` int(11) NOT NULL DEFAULT '0' COMMENT '0=No, 1=Yes',
  `max_inv_dis_percent` int(3) NOT NULL,
  `language` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `time_zone` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `print_recipt_a_sale` int(11) NOT NULL DEFAULT '0' COMMENT '0=No, 1=Yes',
  `quick_sending_receiving` int(11) NOT NULL DEFAULT '0',
  `theme` int(11) NOT NULL DEFAULT '0' COMMENT '0=style0, 1=style1, 2=style2, 3=style3',
  `back_date_sales` int(11) NOT NULL DEFAULT '0' COMMENT '1=yes,0=no',
  `back_date_purchase` int(11) NOT NULL COMMENT '1=yes,0=no',
  `back_date_return` int(11) NOT NULL COMMENT '1=yes,0=no',
  `install_complete` int(11) NOT NULL DEFAULT '0' COMMENT '0=No, 1=Yes',
  `year` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `company_id` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.cusduediscounts
CREATE TABLE IF NOT EXISTS `cusduediscounts` (
  `c_due_discount_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `c_due_payment_id` int(10) DEFAULT NULL,
  `cus_id` int(10) unsigned NOT NULL,
  `amount` double(12,3) NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `c_due_payment_id` (`c_due_discount_id`),
  KEY `cusduepayments_c_due_payment_id_index` (`c_due_discount_id`),
  KEY `cusduepayments_cus_id_foreign` (`cus_id`),
  KEY `cusduepayments_created_by_foreign` (`created_by`),
  KEY `cusduepayments_updated_by_foreign` (`updated_by`),
  CONSTRAINT `cusduediscounts_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `cusduediscounts_ibfk_2` FOREIGN KEY (`cus_id`) REFERENCES `customerinfos` (`cus_id`) ON UPDATE CASCADE,
  CONSTRAINT `cusduediscounts_ibfk_4` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table mbs.cusduepayments
CREATE TABLE IF NOT EXISTS `cusduepayments` (
  `c_due_payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cus_id` int(10) unsigned NOT NULL,
  `payment_type_id` int(10) unsigned NOT NULL,
  `amount` double(12,3) NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `c_due_payment_id` (`c_due_payment_id`),
  KEY `cusduepayments_c_due_payment_id_index` (`c_due_payment_id`),
  KEY `cusduepayments_cus_id_foreign` (`cus_id`),
  KEY `cusduepayments_payment_type_id_foreign` (`payment_type_id`),
  KEY `cusduepayments_created_by_foreign` (`created_by`),
  KEY `cusduepayments_updated_by_foreign` (`updated_by`),
  CONSTRAINT `cusduepayments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `cusduepayments_cus_id_foreign` FOREIGN KEY (`cus_id`) REFERENCES `customerinfos` (`cus_id`) ON UPDATE CASCADE,
  CONSTRAINT `cusduepayments_payment_type_id_foreign` FOREIGN KEY (`payment_type_id`) REFERENCES `paymenttypes` (`payment_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `cusduepayments_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.customerarticles
CREATE TABLE IF NOT EXISTS `customerarticles` (
  `customer_article_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(10) unsigned NOT NULL DEFAULT '0',
  `item_id` int(10) unsigned NOT NULL DEFAULT '0',
  `article_name` varchar(50) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '0=inactive, 1=active',
  `created_by` int(10) unsigned NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`customer_article_id`),
  UNIQUE KEY `customer_id` (`customer_id`,`item_id`),
  KEY `FK_companynames_empinfos` (`created_by`),
  KEY `FK_companynames_empinfos_2` (`updated_by`),
  CONSTRAINT `customerarticles_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `customerarticles_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table mbs.customerinfos
CREATE TABLE IF NOT EXISTS `customerinfos` (
  `cus_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cus_card_id` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `branch_id` int(10) unsigned NOT NULL DEFAULT '1',
  `cus_type_id` int(10) unsigned NOT NULL,
  `full_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `user_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `mobile` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `present_address` text COLLATE utf8_unicode_ci NOT NULL,
  `shipping_address` text COLLATE utf8_unicode_ci,
  `password` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `permanent_address` text COLLATE utf8_unicode_ci,
  `profile_image` text COLLATE utf8_unicode_ci,
  `national_id` bigint(20) DEFAULT NULL,
  `email` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `advance_payment` int(11) DEFAULT '0',
  `due` double DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `created_by` int(10) unsigned NOT NULL DEFAULT '1',
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `customerinfos_user_name_unique` (`user_name`),
  UNIQUE KEY `cus_id` (`cus_id`),
  UNIQUE KEY `customerinfos_cus_card_id_unique` (`cus_card_id`),
  UNIQUE KEY `national_id` (`national_id`),
  KEY `customerinfos_cus_id_index` (`cus_id`),
  KEY `customerinfos_cus_type_id_foreign` (`cus_type_id`),
  KEY `customerinfos_created_by_foreign` (`created_by`),
  KEY `customerinfos_updated_by_foreign` (`updated_by`),
  CONSTRAINT `FK_customerinfos_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `customerinfos_cus_type_id_foreign` FOREIGN KEY (`cus_type_id`) REFERENCES `customertypes` (`cus_type_id`) ON UPDATE CASCADE,
  CONSTRAINT `customerinfos_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.customertypes
CREATE TABLE IF NOT EXISTS `customertypes` (
  `cus_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cus_type_name` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `discount_percent` double(12,3) NOT NULL,
  `point_unit` double(12,3) NOT NULL COMMENT 'per unit point =?',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `cus_type_id` (`cus_type_id`),
  UNIQUE KEY `cus_type_name` (`cus_type_name`),
  KEY `customertypes_cus_type_id_index` (`cus_type_id`),
  KEY `customertypes_created_by_foreign` (`created_by`),
  KEY `customertypes_updated_by_foreign` (`updated_by`),
  CONSTRAINT `customertypes_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `customertypes_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.damageinvoices
CREATE TABLE IF NOT EXISTS `damageinvoices` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` int(10) unsigned NOT NULL,
  `damage_invoice_id` varchar(14) NOT NULL,
  `amount` double(12,3) NOT NULL,
  `date` date NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '0=inactive, 1=active',
  `created_by` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` int(10) unsigned DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `damage_invoice_id` (`damage_invoice_id`),
  KEY `FK_damageinvoices_empinfos` (`created_by`),
  KEY `FK_damageinvoices_empinfos_2` (`updated_by`),
  KEY `FK_damageinvoices_branch_info` (`branch_id`),
  CONSTRAINT `FK_damageinvoices_branch_info` FOREIGN KEY (`branch_id`) REFERENCES `branch_info` (`branch_id`),
  CONSTRAINT `FK_damageinvoices_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_damageinvoices_empinfos_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table mbs.empinfos
CREATE TABLE IF NOT EXISTS `empinfos` (
  `emp_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` int(10) unsigned NOT NULL DEFAULT '0',
  `role` int(11) NOT NULL DEFAULT '1' COMMENT '0=g_emp, 1=s_emp, 2=super_admin',
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
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `active_session` tinyint(4) DEFAULT '0' COMMENT '0=hasn''t , 1 = has active session',
  `last_logged_ip` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `emp_id` (`emp_id`),
  UNIQUE KEY `empinfos_user_name_unique` (`user_name`),
  KEY `empinfos_emp_id_index` (`emp_id`),
  KEY `empinfos_created_by_foreign` (`created_by`),
  KEY `empinfos_updated_by_foreign` (`updated_by`),
  CONSTRAINT `empinfos_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `empinfos_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.empwisesalary
CREATE TABLE IF NOT EXISTS `empwisesalary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_id` int(10) unsigned NOT NULL,
  `invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `emp_id` int(10) unsigned NOT NULL,
  `amount` double(16,3) NOT NULL COMMENT 'payable amount',
  `due` double(16,3) unsigned NOT NULL,
  `date` date NOT NULL,
  `salary_month` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sale_invoice_id` (`invoice_id`),
  KEY `saleinvoices_created_by_foreign` (`emp_id`),
  KEY `saleinvoices_updated_by_foreign` (`updated_by`),
  KEY `FK_empwisesalary_empinfos` (`created_by`),
  KEY `FK_empwisesalary_branch_info` (`branch_id`),
  CONSTRAINT `FK_empwisesalary_branch_info` FOREIGN KEY (`branch_id`) REFERENCES `branch_info` (`branch_id`),
  CONSTRAINT `FK_empwisesalary_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `empwisesalary_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `empwisesalary_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table mbs.godownitems
CREATE TABLE IF NOT EXISTS `godownitems` (
  `branch_id` int(10) unsigned NOT NULL,
  `godown_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `price_id` int(10) unsigned NOT NULL,
  `available_quantity` double(12,4) NOT NULL,
  `quantity_ability_flag` int(11) NOT NULL DEFAULT '1' COMMENT '0=quantity not available,  1=quentity available',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` int(10) unsigned DEFAULT NULL COMMENT 'last item quantity increasing id',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sending_by` int(10) unsigned DEFAULT NULL COMMENT 'last item sending id to stock',
  `sending_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `receiving_by` int(10) unsigned DEFAULT NULL COMMENT 'last item receiving id from stock',
  `receiving_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`item_id`,`price_id`),
  UNIQUE KEY `godown_item_id` (`godown_item_id`),
  KEY `godownitems_godown_item_id_index` (`godown_item_id`),
  KEY `godownitems_price_id_foreign` (`price_id`),
  KEY `godownitems_created_by_foreign` (`created_by`),
  KEY `godownitems_updated_by_foreign` (`updated_by`),
  KEY `FK_godownitems_empinfos` (`sending_by`),
  KEY `FK_godownitems_empinfos_2` (`receiving_by`),
  KEY `FK_godownitems_branch_info` (`branch_id`),
  CONSTRAINT `FK_godownitems_empinfos` FOREIGN KEY (`sending_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_godownitems_empinfos_2` FOREIGN KEY (`receiving_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `godownitems_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `godownitems_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `iteminfos` (`item_id`) ON UPDATE CASCADE,
  CONSTRAINT `godownitems_price_id_foreign` FOREIGN KEY (`price_id`) REFERENCES `priceinfos` (`price_id`) ON UPDATE CASCADE,
  CONSTRAINT `godownitems_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.incomeexpensetype
CREATE TABLE IF NOT EXISTS `incomeexpensetype` (
  `type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  `used_for` int(1) NOT NULL COMMENT '1=for income, 2=for expense',
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '0=inactive, 1=active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_by` int(11) unsigned NOT NULL,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` int(11) unsigned DEFAULT NULL,
  PRIMARY KEY (`type_id`),
  UNIQUE KEY `type_name` (`type_name`),
  KEY `FK_incomeexpensetype_empinfos` (`created_by`),
  KEY `FK_incomeexpensetype_empinfos_2` (`updated_by`),
  CONSTRAINT `FK_incomeexpensetype_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_incomeexpensetype_empinfos_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='used for type setting of other income and other expense';

-- Data exporting was unselected.
-- Dumping structure for table mbs.itembrands
CREATE TABLE IF NOT EXISTS `itembrands` (
  `brand_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `brand_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `offer` int(4) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `brand_id` (`brand_id`),
  UNIQUE KEY `itembrands_brand_name_unique` (`brand_name`),
  KEY `itembrands_brand_id_index` (`brand_id`),
  KEY `itembrands_created_by_foreign` (`created_by`),
  KEY `itembrands_updated_by_foreign` (`updated_by`),
  CONSTRAINT `itembrands_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `itembrands_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.itemcategorys
CREATE TABLE IF NOT EXISTS `itemcategorys` (
  `category_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `category_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `offer` int(4) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `category_id` (`category_id`),
  UNIQUE KEY `itemcategorys_category_name_unique` (`category_name`),
  KEY `itemcategorys_category_id_index` (`category_id`),
  KEY `itemcategorys_created_by_foreign` (`created_by`),
  KEY `itemcategorys_updated_by_foreign` (`updated_by`),
  CONSTRAINT `itemcategorys_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `itemcategorys_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.itemdamages
CREATE TABLE IF NOT EXISTS `itemdamages` (
  `i_damage_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `damage_invoice_id` varchar(14) NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `price_id` int(10) unsigned NOT NULL,
  `quantity` double(12,4) NOT NULL,
  `amount` double(12,3) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`i_damage_id`),
  KEY `FK_itemdamages_empinfos` (`created_by`),
  KEY `FK_itemdamages_iteminfos` (`item_id`),
  KEY `FK_itemdamages_empinfos_2` (`updated_by`),
  KEY `FK_itemdamages_priceinfos` (`price_id`),
  KEY `damageinvoices_itemdamages` (`damage_invoice_id`),
  CONSTRAINT `FK_itemdamages_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_itemdamages_empinfos_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_itemdamages_iteminfos` FOREIGN KEY (`item_id`) REFERENCES `iteminfos` (`item_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_itemdamages_priceinfos` FOREIGN KEY (`price_id`) REFERENCES `priceinfos` (`price_id`) ON UPDATE CASCADE,
  CONSTRAINT `damageinvoices_itemdamages` FOREIGN KEY (`damage_invoice_id`) REFERENCES `damageinvoices` (`damage_invoice_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table mbs.iteminfos
CREATE TABLE IF NOT EXISTS `iteminfos` (
  `item_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_id` int(10) unsigned DEFAULT '0',
  `supplier_id` int(10) unsigned DEFAULT '0',
  `item_company_id` int(10) unsigned DEFAULT '0',
  `item_name` varchar(60) COLLATE utf8_unicode_ci NOT NULL,
  `upc_code` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `article_number` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `carton` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `category_id` int(10) unsigned NOT NULL,
  `brand_id` int(10) unsigned DEFAULT NULL,
  `location_id` int(10) unsigned DEFAULT NULL,
  `price_id` int(10) unsigned NOT NULL,
  `unit` int(10) NOT NULL DEFAULT '1' COMMENT '1=pcs,2=doz,3=set',
  `tax_amount` double DEFAULT NULL COMMENT 'tax in percentage',
  `offer_type` int(1) unsigned NOT NULL COMMENT '1=item,2=category,3=brand',
  `offer` int(11) NOT NULL,
  `description` text COLLATE utf8_unicode_ci,
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `item_id` (`item_id`),
  UNIQUE KEY `item_name` (`item_name`),
  UNIQUE KEY `upc_code` (`upc_code`),
  UNIQUE KEY `article_number` (`article_number`),
  KEY `iteminfos_item_id_index` (`item_id`),
  KEY `iteminfos_category_id_foreign` (`category_id`),
  KEY `iteminfos_brand_id_foreign` (`brand_id`),
  KEY `iteminfos_created_by_foreign` (`created_by`),
  KEY `iteminfos_updated_by_foreign` (`updated_by`),
  KEY `location_id` (`location_id`),
  CONSTRAINT `brand_id_foreign` FOREIGN KEY (`brand_id`) REFERENCES `itembrands` (`brand_id`) ON UPDATE CASCADE,
  CONSTRAINT `iteminfos_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `itemcategorys` (`category_id`) ON UPDATE CASCADE,
  CONSTRAINT `iteminfos_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `iteminfos_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `location_id_foreign` FOREIGN KEY (`location_id`) REFERENCES `itemlocations` (`location_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=413 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.itemlocations
CREATE TABLE IF NOT EXISTS `itemlocations` (
  `location_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `location_name` varchar(30) NOT NULL,
  `status` int(10) unsigned NOT NULL DEFAULT '1',
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`location_id`),
  UNIQUE KEY `location_name` (`location_name`),
  KEY `FK_itemlocations_empinfos_2` (`updated_by`),
  KEY `FK_itemlocations_empinfos` (`created_by`),
  CONSTRAINT `FK_itemlocations_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_itemlocations_empinfos_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table mbs.itempurchases
CREATE TABLE IF NOT EXISTS `itempurchases` (
  `branch_id` int(10) unsigned NOT NULL,
  `i_purchase_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sup_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `price_id` int(10) unsigned NOT NULL,
  `quantity` double(12,4) NOT NULL,
  `discount` double(12,3) NOT NULL,
  `amount` double(12,3) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `i_purchase_id` (`i_purchase_id`),
  KEY `itempurchases_i_purchase_id_index` (`i_purchase_id`),
  KEY `itempurchases_sup_invoice_id_foreign` (`sup_invoice_id`),
  KEY `itempurchases_item_id_foreign` (`item_id`),
  KEY `itempurchases_price_id_foreign` (`price_id`),
  KEY `itempurchases_created_by_foreign` (`created_by`),
  KEY `itempurchases_updated_by_foreign` (`updated_by`),
  KEY `FK_itempurchases_branch_info` (`branch_id`),
  CONSTRAINT `FK_itempurchases_branch_info` FOREIGN KEY (`branch_id`) REFERENCES `branch_info` (`branch_id`),
  CONSTRAINT `FK_itempurchases_empinfos` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_itempurchases_empinfos_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_itempurchases_iteminfos` FOREIGN KEY (`item_id`) REFERENCES `iteminfos` (`item_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_itempurchases_priceinfos` FOREIGN KEY (`price_id`) REFERENCES `priceinfos` (`price_id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_itempurchases_supinvoices` FOREIGN KEY (`sup_invoice_id`) REFERENCES `supinvoices` (`sup_invoice_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.itempurchases_order
CREATE TABLE IF NOT EXISTS `itempurchases_order` (
  `i_purchase_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` int(10) unsigned NOT NULL,
  `sup_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `price_id` int(10) unsigned NOT NULL,
  `quantity` double(12,4) NOT NULL,
  `discount` double(12,3) NOT NULL,
  `amount` double(12,3) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `i_purchase_id` (`i_purchase_id`),
  KEY `itempurchases_i_purchase_id_index` (`i_purchase_id`),
  KEY `itempurchases_sup_invoice_id_foreign` (`sup_invoice_id`),
  KEY `itempurchases_item_id_foreign` (`item_id`),
  KEY `itempurchases_price_id_foreign` (`price_id`),
  KEY `itempurchases_created_by_foreign` (`created_by`),
  KEY `itempurchases_updated_by_foreign` (`updated_by`),
  KEY `FK_itempurchases_order_branch_info` (`branch_id`),
  CONSTRAINT `FK_itempurchases_order_branch_info` FOREIGN KEY (`branch_id`) REFERENCES `branch_info` (`branch_id`),
  CONSTRAINT `itempurchases_order_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `itempurchases_order_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `itempurchases_order_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `iteminfos` (`item_id`) ON UPDATE CASCADE,
  CONSTRAINT `itempurchases_order_ibfk_4` FOREIGN KEY (`price_id`) REFERENCES `priceinfos` (`price_id`) ON UPDATE CASCADE,
  CONSTRAINT `itempurchases_order_ibfk_5` FOREIGN KEY (`sup_invoice_id`) REFERENCES `supinvoices_order` (`sup_invoice_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table mbs.itemsales
CREATE TABLE IF NOT EXISTS `itemsales` (
  `branch_id` int(10) unsigned NOT NULL,
  `i_sale_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sale_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `price_id` int(10) unsigned NOT NULL,
  `quantity` double(12,4) NOT NULL,
  `discount` double(12,3) NOT NULL,
  `tax` double(12,3) NOT NULL,
  `amount` double(12,3) NOT NULL,
  `item_point` double(12,3) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `i_sale_id` (`i_sale_id`),
  KEY `itemsales_i_sale_id_index` (`i_sale_id`),
  KEY `itemsales_sale_invoice_id_foreign` (`sale_invoice_id`),
  KEY `itemsales_item_id_foreign` (`item_id`),
  KEY `itemsales_price_id_foreign` (`price_id`),
  KEY `itemsales_created_by_foreign` (`created_by`),
  KEY `itemsales_updated_by_foreign` (`updated_by`),
  KEY `FK_itemsales_branch_info` (`branch_id`),
  CONSTRAINT `FK_itemsales_saleinvoices` FOREIGN KEY (`sale_invoice_id`) REFERENCES `saleinvoices` (`sale_invoice_id`) ON UPDATE CASCADE,
  CONSTRAINT `itemsales_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `itemsales_item_id_foreign` FOREIGN KEY (`item_id`) REFERENCES `iteminfos` (`item_id`) ON UPDATE CASCADE,
  CONSTRAINT `itemsales_price_id_foreign` FOREIGN KEY (`price_id`) REFERENCES `priceinfos` (`price_id`) ON UPDATE CASCADE,
  CONSTRAINT `itemsales_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=90 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.itemsales_order
CREATE TABLE IF NOT EXISTS `itemsales_order` (
  `branch_id` int(10) unsigned NOT NULL,
  `i_sale_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sale_order_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `item_id` int(10) unsigned DEFAULT NULL,
  `price_id` int(10) unsigned NOT NULL,
  `quantity` double(12,4) NOT NULL,
  `discount` double(12,3) unsigned DEFAULT NULL,
  `tax` double(12,3) unsigned DEFAULT NULL,
  `amount` double(12,3) unsigned DEFAULT NULL,
  `item_point` double(12,3) unsigned DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL DEFAULT '2018',
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  UNIQUE KEY `i_sale_id` (`i_sale_id`),
  KEY `itemsales_i_sale_id_index` (`i_sale_id`),
  KEY `itemsales_sale_invoice_id_foreign` (`sale_order_invoice_id`),
  KEY `itemsales_item_id_foreign` (`item_id`),
  KEY `itemsales_price_id_foreign` (`price_id`),
  KEY `itemsales_created_by_foreign` (`created_by`),
  KEY `itemsales_updated_by_foreign` (`updated_by`),
  KEY `FK_itemsales_branch_info` (`branch_id`),
  CONSTRAINT `itemsales_order_ibfk_1` FOREIGN KEY (`sale_order_invoice_id`) REFERENCES `saleinvoices_order` (`sale_order_invoice_id`) ON UPDATE CASCADE,
  CONSTRAINT `itemsales_order_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `itemsales_order_ibfk_3` FOREIGN KEY (`item_id`) REFERENCES `iteminfos` (`item_id`) ON UPDATE CASCADE,
  CONSTRAINT `itemsales_order_ibfk_4` FOREIGN KEY (`price_id`) REFERENCES `priceinfos` (`price_id`) ON UPDATE CASCADE,
  CONSTRAINT `itemsales_order_ibfk_5` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table mbs.loangottens
CREATE TABLE IF NOT EXISTS `loangottens` (
  `loan_gotten_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_person_name` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'it can be person or company name',
  `amount` double(12,3) NOT NULL,
  `reasion` text COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `pay_amount` double(12,3) NOT NULL DEFAULT '0.000' COMMENT 'will be update after each paid transaction',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1=not paid, 0=paid',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `loan_gotten_id` (`loan_gotten_id`),
  KEY `loangottens_loan_gotten_id_index` (`loan_gotten_id`),
  KEY `loangottens_created_by_foreign` (`created_by`),
  KEY `loangottens_updated_by_foreign` (`updated_by`),
  CONSTRAINT `loangottens_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `loangottens_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.loanpays
CREATE TABLE IF NOT EXISTS `loanpays` (
  `loan_pay_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_person_name` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'it can be person or company name',
  `amount` double(12,3) NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1=Active, 0=Inactive',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `loan_pay_id` (`loan_pay_id`),
  KEY `loanpays_loan_pay_id_index` (`loan_pay_id`),
  KEY `loanpays_created_by_foreign` (`created_by`),
  KEY `loanpays_updated_by_foreign` (`updated_by`),
  CONSTRAINT `loanpays_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `loanpays_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.loanprovides
CREATE TABLE IF NOT EXISTS `loanprovides` (
  `loan_provide_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_person_name` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'it can be person or company name',
  `amount` double(12,3) NOT NULL,
  `reasion` text COLLATE utf8_unicode_ci NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `pay_amount` double(12,3) NOT NULL DEFAULT '0.000' COMMENT 'will be update after each paid transaction',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1=not paid, 0=paid',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `loan_provide_id` (`loan_provide_id`),
  KEY `loanprovides_loan_provide_id_index` (`loan_provide_id`),
  KEY `loanprovides_created_by_foreign` (`created_by`),
  KEY `loanprovides_updated_by_foreign` (`updated_by`),
  CONSTRAINT `loanprovides_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `loanprovides_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.loanreceives
CREATE TABLE IF NOT EXISTS `loanreceives` (
  `loan_receive_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `company_person_name` text COLLATE utf8_unicode_ci NOT NULL COMMENT 'it can be person or company name',
  `amount` double(12,3) NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1=Active, 0=Inactive',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `loan_receive_id` (`loan_receive_id`),
  KEY `loanreceives_loan_receive_id_index` (`loan_receive_id`),
  KEY `loanreceives_created_by_foreign` (`created_by`),
  KEY `loanreceives_updated_by_foreign` (`updated_by`),
  CONSTRAINT `loanreceives_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `loanreceives_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.migrations
CREATE TABLE IF NOT EXISTS `migrations` (
  `migration` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.moduleemppermissions
CREATE TABLE IF NOT EXISTS `moduleemppermissions` (
  `module_emp_p_id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(10) unsigned NOT NULL,
  `emp_id` int(10) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`module_id`,`emp_id`),
  UNIQUE KEY `module_emp_p_id` (`module_emp_p_id`),
  KEY `moduleemppermissions_module_emp_p_id_index` (`module_emp_p_id`),
  KEY `moduleemppermissions_emp_id_foreign` (`emp_id`),
  KEY `moduleemppermissions_created_by_foreign` (`created_by`),
  KEY `moduleemppermissions_updated_by_foreign` (`updated_by`)
) ENGINE=InnoDB AUTO_INCREMENT=199 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.modulenames
CREATE TABLE IF NOT EXISTS `modulenames` (
  `module_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `module_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `module_url` text COLLATE utf8_unicode_ci NOT NULL,
  `icon` text COLLATE utf8_unicode_ci NOT NULL,
  `sorting` int(11) NOT NULL COMMENT 'For showing module with user define sequence',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `module_id` (`module_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.modulepermissions
CREATE TABLE IF NOT EXISTS `modulepermissions` (
  `m_permission_id` int(11) NOT NULL AUTO_INCREMENT,
  `module_id` int(10) unsigned NOT NULL,
  `company_id` int(10) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`module_id`,`company_id`),
  UNIQUE KEY `m_permission_id` (`m_permission_id`),
  KEY `modulepermissions_m_permission_id_index` (`m_permission_id`),
  KEY `modulepermissions_company_id_foreign` (`company_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.otherexpenses
CREATE TABLE IF NOT EXISTS `otherexpenses` (
  `branch_id` int(10) unsigned NOT NULL,
  `other_expense_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `expense_type_id` int(10) unsigned NOT NULL,
  `amount` double(12,3) NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1=pending, 0=received',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `other_expense_id` (`other_expense_id`),
  KEY `otherexpenses_other_expense_id_index` (`other_expense_id`),
  KEY `otherexpenses_created_by_foreign` (`created_by`),
  KEY `otherexpenses_updated_by_foreign` (`updated_by`),
  KEY `FK_otherexpenses_incomeexpensetype` (`expense_type_id`),
  KEY `FK_otherexpenses_branch_info` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.otherincomes
CREATE TABLE IF NOT EXISTS `otherincomes` (
  `branch_id` int(10) unsigned NOT NULL,
  `other_income_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `income_type_id` int(11) unsigned NOT NULL,
  `amount` double(12,3) NOT NULL,
  `comment` text COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1=pending, 0=received',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `other_income_id` (`other_income_id`),
  KEY `otherincomes_other_income_id_index` (`other_income_id`),
  KEY `otherincomes_created_by_foreign` (`created_by`),
  KEY `otherincomes_updated_by_foreign` (`updated_by`),
  KEY `FK_otherincomes_incomeexpensetype` (`income_type_id`),
  KEY `FK_otherincomes_branch_info` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.paymenttypes
CREATE TABLE IF NOT EXISTS `paymenttypes` (
  `payment_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `payment_type_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `payment_type_id` (`payment_type_id`),
  UNIQUE KEY `paymenttypes_payment_type_name_unique` (`payment_type_name`),
  KEY `paymenttypes_payment_type_id_index` (`payment_type_id`),
  KEY `paymenttypes_created_by_foreign` (`created_by`),
  KEY `paymenttypes_updated_by_foreign` (`updated_by`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.pointincreasingrecords
CREATE TABLE IF NOT EXISTS `pointincreasingrecords` (
  `point_increasing_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cus_id` int(10) unsigned NOT NULL,
  `no_of_point` int(11) NOT NULL,
  `sale_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1=Active, 0=Inactive',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `point_increasing_id` (`point_increasing_id`),
  KEY `pointincreasingrecords_point_increasing_id_index` (`point_increasing_id`),
  KEY `pointincreasingrecords_cus_id_foreign` (`cus_id`),
  KEY `pointincreasingrecords_sale_invoice_id_foreign` (`sale_invoice_id`),
  KEY `pointincreasingrecords_created_by_foreign` (`created_by`),
  KEY `pointincreasingrecords_updated_by_foreign` (`updated_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.pointusingrecords
CREATE TABLE IF NOT EXISTS `pointusingrecords` (
  `point_using_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cus_id` int(10) unsigned NOT NULL,
  `use_point` int(11) NOT NULL,
  `point_taka` int(11) NOT NULL,
  `benifited_way` int(11) NOT NULL DEFAULT '1' COMMENT '1=on item, 0=hand cash',
  `sale_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1=Active, 0=Inactive',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `point_using_id` (`point_using_id`),
  KEY `pointusingrecords_point_using_id_index` (`point_using_id`),
  KEY `pointusingrecords_cus_id_foreign` (`cus_id`),
  KEY `pointusingrecords_sale_invoice_id_foreign` (`sale_invoice_id`),
  KEY `pointusingrecords_created_by_foreign` (`created_by`),
  KEY `pointusingrecords_updated_by_foreign` (`updated_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.priceinfos
CREATE TABLE IF NOT EXISTS `priceinfos` (
  `price_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `purchase_price` double(12,2) NOT NULL,
  `sale_price` double(12,2) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`item_id`,`purchase_price`,`sale_price`),
  UNIQUE KEY `price_id` (`price_id`),
  KEY `priceinfos_price_id_index` (`price_id`),
  KEY `priceinfos_created_by_foreign` (`created_by`),
  KEY `priceinfos_updated_by_foreign` (`updated_by`)
) ENGINE=InnoDB AUTO_INCREMENT=406 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=DYNAMIC;

-- Data exporting was unselected.
-- Dumping structure for table mbs.purchasereturntosupplier
CREATE TABLE IF NOT EXISTS `purchasereturntosupplier` (
  `branch_id` int(10) unsigned NOT NULL,
  `purchase_return_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sup_r_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `price_id` int(10) unsigned NOT NULL,
  `quantity` double(12,4) NOT NULL,
  `discount` double(12,3) NOT NULL,
  `amount` double(12,3) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `i_sup_return_id` (`purchase_return_id`),
  KEY `purchasertosuppliers_i_sup_return_id_index` (`purchase_return_id`),
  KEY `purchasertosuppliers_sup_r_invoice_id_foreign` (`sup_r_invoice_id`),
  KEY `purchasertosuppliers_item_id_foreign` (`item_id`),
  KEY `purchasertosuppliers_price_id_foreign` (`price_id`),
  KEY `purchasertosuppliers_created_by_foreign` (`created_by`),
  KEY `purchasertosuppliers_updated_by_foreign` (`updated_by`),
  KEY `FK_purchasereturntosupplier_branch_info` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.receivingitems
CREATE TABLE IF NOT EXISTS `receivingitems` (
  `branch_id` int(10) unsigned NOT NULL,
  `receiving_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `price_id` int(10) unsigned NOT NULL,
  `quantity` double NOT NULL,
  `sending_date` datetime NOT NULL,
  `receive_cancel_date` datetime NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0 = received 1 = pending, 2=cancelled',
  `year` int(11) NOT NULL,
  `sending_by` int(10) unsigned NOT NULL,
  `receive_cancel_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `receiving_item_id` (`receiving_item_id`),
  KEY `receivingitems_receiving_item_id_index` (`receiving_item_id`),
  KEY `receivingitems_item_id_foreign` (`item_id`),
  KEY `receivingitems_price_id_foreign` (`price_id`),
  KEY `receivingitems_created_by_foreign` (`sending_by`),
  KEY `receivingitems_updated_by_foreign` (`receive_cancel_by`),
  KEY `FK_receivingitems_branch_info` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.returnreceivingitems
CREATE TABLE IF NOT EXISTS `returnreceivingitems` (
  `branch_id` int(10) unsigned NOT NULL,
  `r_receiving_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `item_id` int(10) unsigned NOT NULL,
  `price_id` int(10) unsigned NOT NULL,
  `quantity` double NOT NULL,
  `returning_date` datetime NOT NULL,
  `receive_cancel_date` datetime NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '1=pending, 0=received 2=cancle',
  `year` int(11) NOT NULL,
  `returning_by` int(10) unsigned NOT NULL,
  `receive_cancel_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `r_receiving_item_id` (`r_receiving_item_id`),
  KEY `returnreceivingitems_r_receiving_item_id_index` (`r_receiving_item_id`),
  KEY `returnreceivingitems_item_id_foreign` (`item_id`),
  KEY `returnreceivingitems_price_id_foreign` (`price_id`),
  KEY `returnreceivingitems_created_by_foreign` (`returning_by`),
  KEY `returnreceivingitems_updated_by_foreign` (`receive_cancel_by`),
  KEY `FK_returnreceivingitems_branch_info` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.saleinvoices
CREATE TABLE IF NOT EXISTS `saleinvoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_id` int(10) unsigned NOT NULL,
  `sale_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `cus_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'can be 0 for unregister customer',
  `payment_type_id` int(10) unsigned NOT NULL,
  `po_no` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `discount` double(12,3) DEFAULT NULL,
  `total_point` double(12,3) DEFAULT NULL,
  `point_use_taka` int(11) NOT NULL,
  `amount` double NOT NULL COMMENT 'payable amount',
  `pay` double(12,3) NOT NULL,
  `due` double(12,3) NOT NULL,
  `pay_note` int(11) NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sale_invoice_id` (`sale_invoice_id`),
  KEY `saleinvoices_payment_type_id_foreign` (`payment_type_id`),
  KEY `saleinvoices_created_by_foreign` (`created_by`),
  KEY `saleinvoices_updated_by_foreign` (`updated_by`),
  KEY `FK_saleinvoices_customerinfos` (`cus_id`),
  KEY `FK_saleinvoices_branch_info` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.saleinvoices_order
CREATE TABLE IF NOT EXISTS `saleinvoices_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_id` int(10) unsigned NOT NULL,
  `sale_order_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `cus_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'can be 0 for unregister customer',
  `payment_type_id` int(10) unsigned NOT NULL,
  `discount` double(12,3) DEFAULT NULL,
  `total_point` double(12,3) DEFAULT NULL,
  `point_use_taka` int(11) DEFAULT NULL,
  `amount` double DEFAULT NULL COMMENT 'payable amount',
  `pay` double(12,3) DEFAULT NULL,
  `due` double(12,3) DEFAULT NULL,
  `pay_note` int(11) DEFAULT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL DEFAULT '2018',
  `created_by` int(10) unsigned DEFAULT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `sale_invoice_id` (`sale_order_invoice_id`),
  KEY `saleinvoices_payment_type_id_foreign` (`payment_type_id`),
  KEY `saleinvoices_created_by_foreign` (`created_by`),
  KEY `saleinvoices_updated_by_foreign` (`updated_by`),
  KEY `FK_saleinvoices_customerinfos` (`cus_id`),
  KEY `FK_saleinvoices_branch_info` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table mbs.salereturninvoices
CREATE TABLE IF NOT EXISTS `salereturninvoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_id` int(10) unsigned NOT NULL,
  `sale_r_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `sale_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `cus_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT 'can be 0 for unregister customer',
  `payment_type_id` int(10) unsigned NOT NULL,
  `amount` double(12,3) NOT NULL,
  `less_amount` double(12,3) NOT NULL COMMENT 'loss amount of customer for return',
  `transaction_date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sale_return_invoice_id` (`sale_r_invoice_id`),
  KEY `salereturninvoices_payment_type_id_foreign` (`payment_type_id`),
  KEY `salereturninvoices_created_by_foreign` (`created_by`),
  KEY `salereturninvoices_updated_by_foreign` (`updated_by`),
  KEY `FK_salereturninvoices_saleinvoices` (`sale_invoice_id`),
  KEY `FK_salereturninvoices_customerinfos` (`cus_id`),
  KEY `FK_salereturninvoices_branch_info` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.salereturntostocks
CREATE TABLE IF NOT EXISTS `salereturntostocks` (
  `branch_id` int(10) unsigned NOT NULL,
  `i_sale_return_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sale_r_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `price_id` int(10) unsigned NOT NULL,
  `quantity` double(12,4) NOT NULL,
  `discount` double(12,3) NOT NULL,
  `tax` double(12,4) NOT NULL,
  `amount` double(12,3) NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `i_sale_return_id` (`i_sale_return_id`),
  KEY `salereturntostocks_i_sale_return_id_index` (`i_sale_return_id`),
  KEY `salereturntostocks_sale_r_invoice_id_foreign` (`sale_r_invoice_id`),
  KEY `salereturntostocks_item_id_foreign` (`item_id`),
  KEY `salereturntostocks_price_id_foreign` (`price_id`),
  KEY `salereturntostocks_created_by_foreign` (`created_by`),
  KEY `salereturntostocks_updated_by_foreign` (`updated_by`),
  KEY `FK_salereturntostocks_branch_info` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.smemppermissions
CREATE TABLE IF NOT EXISTS `smemppermissions` (
  `s_m_emp_p_id` int(11) NOT NULL AUTO_INCREMENT,
  `sub_module_id` int(10) unsigned NOT NULL,
  `emp_id` int(10) unsigned NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`sub_module_id`,`emp_id`),
  UNIQUE KEY `s_m_emp_p_id` (`s_m_emp_p_id`),
  KEY `smemppermissions_s_m_emp_p_id_index` (`s_m_emp_p_id`),
  KEY `smemppermissions_emp_id_foreign` (`emp_id`),
  KEY `smemppermissions_created_by_foreign` (`created_by`),
  KEY `smemppermissions_updated_by_foreign` (`updated_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.stockitems
CREATE TABLE IF NOT EXISTS `stockitems` (
  `stock_item_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `branch_id` int(10) unsigned NOT NULL,
  `item_id` int(10) unsigned NOT NULL,
  `price_id` int(10) unsigned NOT NULL,
  `available_quantity` double(12,2) NOT NULL,
  `quantity_ability_flag` int(11) NOT NULL DEFAULT '1' COMMENT '0=quantity not available,  1=quentity available',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=quantity not available,  1=quentity available',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_by` int(10) unsigned DEFAULT NULL,
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `sending_by` int(10) unsigned DEFAULT NULL,
  `sending_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `receiving_by` int(10) unsigned DEFAULT NULL,
  `receiving_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`item_id`,`price_id`,`branch_id`),
  UNIQUE KEY `stock_item_id` (`stock_item_id`),
  KEY `stockitems_stock_item_id_index` (`stock_item_id`),
  KEY `stockitems_price_id_foreign` (`price_id`),
  KEY `stockitems_created_by_foreign` (`created_by`),
  KEY `stockitems_updated_by_foreign` (`updated_by`),
  KEY `FK_stockitems_empinfos` (`sending_by`),
  KEY `FK_stockitems_empinfos_2` (`receiving_by`),
  KEY `FK_stockitems_branch_info` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.submodulenames
CREATE TABLE IF NOT EXISTS `submodulenames` (
  `sub_module_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sub_module_name` varchar(30) COLLATE utf8_unicode_ci NOT NULL,
  `module_id` int(10) unsigned NOT NULL,
  `sub_module_url` text COLLATE utf8_unicode_ci NOT NULL,
  `sub_module_icon` text COLLATE utf8_unicode_ci NOT NULL,
  `sorting` int(11) NOT NULL COMMENT 'For showing sub module with user define sequence',
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `sub_module_id` (`sub_module_id`),
  KEY `submodulenames_sub_module_id_index` (`sub_module_id`),
  KEY `submodulenames_module_id_foreign` (`module_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.sub_companies
CREATE TABLE IF NOT EXISTS `sub_companies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `company_name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.supduepayments
CREATE TABLE IF NOT EXISTS `supduepayments` (
  `s_due_payment_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `supp_id` int(10) unsigned NOT NULL,
  `branch_id` int(10) unsigned NOT NULL,
  `payment_type_id` int(10) unsigned NOT NULL,
  `amount` double(12,3) NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `s_due_payment_id` (`s_due_payment_id`),
  KEY `supduepayments_s_due_payment_id_index` (`s_due_payment_id`),
  KEY `supduepayments_supp_id_foreign` (`supp_id`),
  KEY `supduepayments_payment_type_id_foreign` (`payment_type_id`),
  KEY `supduepayments_created_by_foreign` (`created_by`),
  KEY `supduepayments_updated_by_foreign` (`updated_by`),
  KEY `FK_supduepayments_branch_info` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.supinvoices
CREATE TABLE IF NOT EXISTS `supinvoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_id` int(10) unsigned NOT NULL,
  `sup_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `sup_memo_no` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `supp_id` int(10) unsigned DEFAULT '0' COMMENT '0 means unregistrad customer',
  `payment_type_id` int(10) unsigned NOT NULL,
  `discount` double(12,3) NOT NULL,
  `amount` double NOT NULL COMMENT 'payable amount',
  `pay` double(12,3) NOT NULL,
  `due` double(12,3) NOT NULL,
  `transaction_date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) DEFAULT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sup_invoice_id` (`sup_invoice_id`),
  UNIQUE KEY `sup_memo_no` (`sup_memo_no`),
  KEY `supinvoices_supp_id_foreign` (`supp_id`),
  KEY `supinvoices_payment_type_id_foreign` (`payment_type_id`),
  KEY `supinvoices_created_by_foreign` (`created_by`),
  KEY `supinvoices_updated_by_foreign` (`updated_by`),
  KEY `sup_invoice_id_2` (`sup_invoice_id`),
  KEY `FK_supinvoices_branch_info` (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.supinvoices_order
CREATE TABLE IF NOT EXISTS `supinvoices_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_id` int(10) unsigned NOT NULL,
  `sup_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `sup_memo_no` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `supp_id` int(10) unsigned DEFAULT '0' COMMENT '0 means unregistrad customer',
  `payment_type_id` int(10) unsigned NOT NULL,
  `discount` double(12,3) NOT NULL,
  `amount` double NOT NULL COMMENT 'payable amount',
  `pay` double(12,3) NOT NULL,
  `due` double(12,3) NOT NULL,
  `transaction_date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sup_invoice_id` (`sup_invoice_id`),
  UNIQUE KEY `sup_memo_no` (`sup_memo_no`),
  KEY `supinvoices_supp_id_foreign` (`supp_id`),
  KEY `supinvoices_payment_type_id_foreign` (`payment_type_id`),
  KEY `supinvoices_created_by_foreign` (`created_by`),
  KEY `supinvoices_updated_by_foreign` (`updated_by`),
  KEY `sup_invoice_id_2` (`sup_invoice_id`),
  KEY `FK_supinvoices_order_branch_info` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table mbs.supplierduediscounts
CREATE TABLE IF NOT EXISTS `supplierduediscounts` (
  `s_due_discount_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `s_due_payment_id` int(10) DEFAULT NULL,
  `supp_id` int(10) unsigned NOT NULL,
  `amount` double(12,3) NOT NULL,
  `date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `c_due_payment_id` (`s_due_discount_id`),
  KEY `cusduepayments_c_due_payment_id_index` (`s_due_discount_id`),
  KEY `cusduepayments_cus_id_foreign` (`supp_id`),
  KEY `cusduepayments_created_by_foreign` (`created_by`),
  KEY `cusduepayments_updated_by_foreign` (`updated_by`),
  CONSTRAINT `supplierduediscounts_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE,
  CONSTRAINT `supplierduediscounts_ibfk_2` FOREIGN KEY (`supp_id`) REFERENCES `supplierinfos` (`supp_id`) ON UPDATE CASCADE,
  CONSTRAINT `supplierduediscounts_ibfk_3` FOREIGN KEY (`updated_by`) REFERENCES `empinfos` (`emp_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci ROW_FORMAT=COMPACT;

-- Data exporting was unselected.
-- Dumping structure for table mbs.supplierinfos
CREATE TABLE IF NOT EXISTS `supplierinfos` (
  `supp_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
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
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  UNIQUE KEY `supp_id` (`supp_id`),
  UNIQUE KEY `supplierinfos_user_name_unique` (`user_name`),
  KEY `supplierinfos_supp_id_index` (`supp_id`),
  KEY `supplierinfos_created_by_foreign` (`created_by`),
  KEY `supplierinfos_updated_by_foreign` (`updated_by`),
  KEY `supp_id_2` (`supp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.supplierreturninvoices
CREATE TABLE IF NOT EXISTS `supplierreturninvoices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `branch_id` int(10) unsigned NOT NULL,
  `sup_r_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `sup_invoice_id` varchar(14) COLLATE utf8_unicode_ci NOT NULL,
  `supp_id` int(10) unsigned NOT NULL,
  `payment_type_id` int(10) unsigned NOT NULL,
  `amount` double(12,3) NOT NULL,
  `less_amount` double(12,3) NOT NULL COMMENT 'loss amount of customer for return',
  `transaction_date` date NOT NULL,
  `status` int(11) NOT NULL DEFAULT '1' COMMENT '0=Inactive, 1=Active',
  `year` int(11) NOT NULL,
  `created_by` int(10) unsigned NOT NULL,
  `updated_by` int(10) unsigned DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `updated_at` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sup_r_invoice_id` (`sup_r_invoice_id`),
  KEY `supplierreturninvoices_supp_id_foreign` (`supp_id`),
  KEY `supplierreturninvoices_payment_type_id_foreign` (`payment_type_id`),
  KEY `supplierreturninvoices_created_by_foreign` (`created_by`),
  KEY `supplierreturninvoices_updated_by_foreign` (`updated_by`),
  KEY `FK_supplierreturninvoices_supinvoices` (`sup_invoice_id`),
  KEY `FK_supplierreturninvoices_branch_info` (`branch_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- Data exporting was unselected.
-- Dumping structure for table mbs.urlemppermissions
CREATE TABLE IF NOT EXISTS `urlemppermissions` (
  `url_emp_p_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url_id` int(10) unsigned NOT NULL,
  `emp_id` int(10) unsigned NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '0 = inactive 1 = active',
  `created_by` int(11) NOT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`url_emp_p_id`),
  KEY `FK_urlemppermissions_empinfos` (`emp_id`),
  KEY `FK_urlemppermissions_urlnames` (`url_id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table mbs.urlnamepermissions
CREATE TABLE IF NOT EXISTS `urlnamepermissions` (
  `url_permission_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `url_id` int(10) unsigned NOT NULL,
  `company_id` int(10) unsigned NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '0 = inactive 1 = active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`url_permission_id`),
  KEY `FK_urlnamepermissions_urlnames` (`url_id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
-- Dumping structure for table mbs.urlnames
CREATE TABLE IF NOT EXISTS `urlnames` (
  `url_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `url_name` varchar(30) NOT NULL,
  `url_address` varchar(50) NOT NULL,
  `status` int(1) NOT NULL DEFAULT '1' COMMENT '0 = inactive 1 = active',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`url_id`),
  UNIQUE KEY `url_name` (`url_name`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Data exporting was unselected.
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
