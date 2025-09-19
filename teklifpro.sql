-- 1) ROLES
CREATE TABLE IF NOT EXISTS `roles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT 'user',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_roles_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

INSERT INTO `roles` (`id`,`name`) VALUES
(1,'admin'),(2,'user')
ON DUPLICATE KEY UPDATE `name`=VALUES(`name`);

-- 2) USERS
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `status` enum('active','inactive') DEFAULT 'active',
  `role_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_users_username` (`username`),
  KEY `idx_users_role_id` (`role_id`),
  CONSTRAINT `fk_users_role_id`
    FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`)
    ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

-- 3) CATEGORIES
CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `unit_type` enum('kg/m','adet','m','m²') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_categories_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

INSERT INTO `categories` (`id`,`name`,`unit_type`) VALUES
(1,'Alüminyum','m'),
(2,'Aksesuar','adet'),
(3,'Fitil','m'),
(4,'Cam','kg/m')
ON DUPLICATE KEY UPDATE
  `name`=VALUES(`name`),
  `unit_type`=VALUES(`unit_type`);

  -- 4) COMPANY
CREATE TABLE IF NOT EXISTS `company` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `logo` text DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_company_user_id` (`user_id`),
  CONSTRAINT `fk_company_user_id`
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

-- 5) CUSTOMERS
CREATE TABLE IF NOT EXISTS `customers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `company` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `tax_number` varchar(255) DEFAULT NULL,
  `tax_office` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_customers_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

-- 6) GENERALOFFERS
CREATE TABLE IF NOT EXISTS `generaloffers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `quote_no` varchar(50) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `company_id` int(11) DEFAULT NULL,
  `offer_date` date DEFAULT NULL,
  `assembly_type` varchar(100) DEFAULT NULL,
  `delivery_time` varchar(100) DEFAULT NULL,
  `payment_method` varchar(100) DEFAULT NULL,
  `validity_days` int(11) DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `installment_term` varchar(100) DEFAULT NULL,
  `payment_type` enum('cash','installment') NOT NULL DEFAULT 'cash',
  `term_months` int(11) DEFAULT NULL,
  `interest_mode` enum('percent','fixed') DEFAULT NULL,
  `interest_value` decimal(12,2) DEFAULT NULL,
  `interest_amount` decimal(12,2) DEFAULT NULL,
  `total_with_interest` decimal(12,2) DEFAULT NULL,
  `monthly_installment` decimal(12,2) DEFAULT NULL,
  `grace_days` int(11) DEFAULT 0,
  `payment_term` varchar(100) DEFAULT NULL,
  `offer_validity` varchar(100) DEFAULT NULL,
  `maturity_period` varchar(100) DEFAULT NULL,
  `discount_rate` decimal(5,2) DEFAULT NULL,
  `discount_amount` decimal(10,2) DEFAULT NULL,
  `vat_rate` decimal(5,2) DEFAULT NULL,
  `vat_amount` decimal(10,2) DEFAULT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  `profit_percent` decimal(5,2) DEFAULT NULL,
  `profit_amount` decimal(15,2) DEFAULT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `approval_token` varchar(64) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `note` text DEFAULT NULL,
  `shared_at` datetime DEFAULT NULL,
  `shared_by` int(11) DEFAULT NULL,
  `share_count` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `idx_generaloffers_customer_id` (`customer_id`),
  KEY `idx_generaloffers_company_id` (`company_id`),
  KEY `idx_generaloffers_status` (`status`),
  KEY `idx_generaloffers_shared_by` (`shared_by`),
  CONSTRAINT `fk_generaloffers_customer`
    FOREIGN KEY (`customer_id`) REFERENCES `customers`(`id`)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT `fk_generaloffers_company`
    FOREIGN KEY (`company_id`) REFERENCES `company`(`id`)
    ON UPDATE CASCADE ON DELETE SET NULL,
  CONSTRAINT `fk_generaloffers_shared_by`
    FOREIGN KEY (`shared_by`) REFERENCES `users`(`id`)
    ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

-- 7) PRODUCTS
CREATE TABLE IF NOT EXISTS `products` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `product_code` varchar(100) NOT NULL,
  `name` varchar(255) NOT NULL,
  `unit` varchar(50) DEFAULT NULL,
  `channel_count` tinyint(3) UNSIGNED DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `image_data` longblob DEFAULT NULL,
  `image_mime` varchar(100) DEFAULT NULL,
  `image_url` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `weight_per_meter` decimal(10,3) DEFAULT NULL,
  `vat_rate` decimal(5,2) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `price_unit` enum('USD','EUR','TRY') NOT NULL DEFAULT 'TRY',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_products_product_code` (`product_code`),
  KEY `idx_products_category_id` (`category_id`),
  CONSTRAINT `fk_products_category`
    FOREIGN KEY (`category_id`) REFERENCES `categories`(`id`)
    ON UPDATE CASCADE ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

-- (Örnek veri – idempotent)
INSERT INTO `products`
(`id`,`product_code`,`name`,`unit`,`channel_count`,`color`,`image_data`,`image_mime`,`image_url`,`description`,`unit_price`,`weight_per_meter`,`vat_rate`,`category_id`,`price_unit`) VALUES
(1,'ALU-001','Motor Kutusu','kg/m',NULL,NULL,NULL,NULL,'uploads/prod_689d81d38629d6.14295177.png',NULL,5.00,2.400,20.00,1,'USD'),
(2,'ALU-002','Motor Kapak','kg/m',NULL,NULL,NULL,NULL,'uploads/prod_689d83510c2a44.96354635.png',NULL,5.00,0.761,20.00,1,'USD'),
(3,'ALU-003','Alt Kasa','kg/m',NULL,NULL,NULL,NULL,'uploads/prod_689d85047bba91.68459718.png',NULL,5.00,1.216,20.00,1,'USD'),
(4,'ALU-004','Tutamak','kg/m',NULL,NULL,NULL,NULL,'uploads/prod_689d884a53bad5.13649486.png',NULL,5.00,0.880,20.00,1,'USD'),
(5,'ALU-005','Kenetli Baza','kg/m',NULL,NULL,NULL,NULL,'uploads/prod_689d8990be6917.46468808.png',NULL,5.00,0.617,20.00,1,'USD'),
(6,'ALU-006','Küpeşte Bazası','kg/m',NULL,NULL,NULL,NULL,'uploads/prod_689d8a28b1e5c6.80846706.png',NULL,5.00,0.491,20.00,1,'USD'),
(7,'ALU-007','Küpeşte','kg/m',NULL,NULL,NULL,NULL,'uploads/prod_689d8be7c30299.00007194.png',NULL,5.00,0.399,20.00,1,'USD'),
(8,'ALU-008','Yatay Tek Cam Çıtası','kg/m',NULL,NULL,NULL,NULL,'uploads/prod_689d8c5daf3dc7.71006811.png',NULL,5.00,0.240,20.00,1,'USD'),
(9,'ALU-009','Dikey Tek Cam Çıtası','kg/m',NULL,NULL,NULL,NULL,'uploads/prod_689d8c6315c9c9.78615292.png',NULL,5.00,0.240,20.00,1,'USD'),
(10,'ALU-010','Dikme','kg/m',NULL,NULL,NULL,NULL,'uploads/prod_689d8d1a3f97f6.66118957.png',NULL,5.00,1.692,20.00,1,'USD'),
(11,'ALU-011','Orta Dikme','kg/m',NULL,NULL,NULL,NULL,'uploads/prod_689d8ddde19423.72245843.png',NULL,5.00,0.589,20.00,1,'USD'),
(12,'ALU-012','Son Kapatma','kg/m',NULL,NULL,NULL,NULL,'uploads/prod_689d8e53630e23.99446192.png',NULL,5.00,0.980,20.00,1,'USD'),
(13,'ALU-013','Kanat','kg/m',NULL,NULL,NULL,NULL,'uploads/prod_689d979f9d9095.83107493.png',NULL,5.00,1.499,20.00,1,'USD'),
(14,'ALU-014','Dikey Baza','kg/m',NULL,NULL,NULL,NULL,'uploads/prod_689d98fb17a318.00944727.png',NULL,5.00,0.627,20.00,1,'USD'),
(17,'ALU-015','Motor Borusu','m',NULL,NULL,NULL,NULL,'uploads/prod_689dba8ccbd6a4.05135182.png',NULL,4.00,1.000,20.00,2,'USD'),
(18,'FIT-001','Motor Kutu Contası','m',NULL,NULL,NULL,NULL,'uploads/prod_689dbaa5c1c036.57568229.png',NULL,0.80,1.000,20.00,3,'USD'),
(19,'FIT-002','Kanat Contası','m',NULL,NULL,NULL,NULL,'uploads/prod_689dbabf730f57.59776694.png',NULL,0.70,1.000,20.00,3,'USD'),
(20,'PRD-01','Kıl Fitil','m',NULL,NULL,NULL,NULL,'uploads/prod_689dbad192dca3.02797000.jpg',NULL,0.20,1.000,20.00,3,'USD'),
(21,'AKS-001','Plastik Set','set',NULL,NULL,NULL,NULL,'uploads/prod_689daf670db319.58780229.png',NULL,38.00,1.000,20.00,2,'USD'),
(22,'AKS-021','Zincir','set',NULL,NULL,NULL,NULL,'uploads/prod_68ac63b68913d6.69131013.png',NULL,20.00,1.000,20.00,2,'USD'),
(24,'PRD-02','Cam','m²',NULL,NULL,NULL,NULL,NULL,NULL,42.00,1.000,20.00,4,'USD'),
(25,'PRD-03','Cuppon','adet',NULL,NULL,NULL,NULL,NULL,NULL,3200.00,1.000,20.00,2,'TRY'),
(26,'PRD-04','Somfy','adet',NULL,NULL,NULL,NULL,NULL,NULL,3300.00,1.000,20.00,2,'TRY'),
(27,'PRD-05','Mosel','adet',NULL,NULL,NULL,NULL,NULL,NULL,3400.00,1.000,20.00,2,'TRY'),
(28,'PRD-06','Asa','adet',NULL,NULL,NULL,NULL,NULL,NULL,3500.00,1.000,20.00,2,'TRY'),
(29,'PRD-07','Kumanda','adet',NULL,NULL,NULL,NULL,NULL,NULL,750.00,1.000,20.00,2,'TRY')
ON DUPLICATE KEY UPDATE
  `name`=VALUES(`name`),
  `unit`=VALUES(`unit`),
  `unit_price`=VALUES(`unit_price`),
  `vat_rate`=VALUES(`vat_rate`),
  `category_id`=VALUES(`category_id`),
  `price_unit`=VALUES(`price_unit`);

-- 8) SLIDINGSYSTEMS
CREATE TABLE IF NOT EXISTS `slidingsystems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `general_offer_id` int(11) DEFAULT NULL,
  `system_type` varchar(100) DEFAULT NULL,
  `width` decimal(10,2) DEFAULT NULL,
  `height` decimal(10,2) DEFAULT NULL,
  `wing_type` varchar(100) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `ral_code` varchar(50) DEFAULT NULL,
  `lock_type` varchar(100) DEFAULT NULL,
  `glass_type` varchar(100) DEFAULT NULL,
  `glass_color` varchar(50) DEFAULT NULL,
  `profit_rate` decimal(5,2) DEFAULT NULL,
  `profit_amount` decimal(10,2) DEFAULT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_slidingsystems_offer_id` (`general_offer_id`),
  CONSTRAINT `fk_slidingsystems_offer`
    FOREIGN KEY (`general_offer_id`) REFERENCES `generaloffers`(`id`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

-- 9) GUILLOTINESYSTEMS
CREATE TABLE IF NOT EXISTS `guillotinesystems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `general_offer_id` int(11) DEFAULT NULL,
  `system_type` varchar(100) DEFAULT NULL,
  `width` decimal(10,2) DEFAULT NULL,
  `height` decimal(10,2) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `motor_system` varchar(100) DEFAULT NULL,
  `remote_quantity` int(11) DEFAULT NULL,
  `ral_code` varchar(50) DEFAULT NULL,
  `paint_face` varchar(100) DEFAULT NULL,
  `glass_type` varchar(100) DEFAULT NULL,
  `glass_color` varchar(50) DEFAULT NULL,
  `profit_margin` decimal(5,2) DEFAULT NULL,
  `profit_rate` decimal(5,2) DEFAULT NULL,
  `profit_amount` decimal(10,2) DEFAULT NULL,
  `total_amount` decimal(15,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_guillotine_offer_id` (`general_offer_id`),
  CONSTRAINT `fk_guillotine_offer`
    FOREIGN KEY (`general_offer_id`) REFERENCES `generaloffers`(`id`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

-- 10) THEMES
CREATE TABLE IF NOT EXISTS `themes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `theme` varchar(100) DEFAULT NULL,
  `primary_color` varchar(20) DEFAULT NULL,
  `secondary_color` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_themes_user_id` (`user_id`),
  CONSTRAINT `fk_themes_user`
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
    ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

-- AUTO_INCREMENT düzeyleri (isteğe bağlı – tablo boş değilse motor kendisi ilerletir)
ALTER TABLE `categories` AUTO_INCREMENT=5;
ALTER TABLE `company` AUTO_INCREMENT=2;
ALTER TABLE `customers` AUTO_INCREMENT=4;
ALTER TABLE `generaloffers` AUTO_INCREMENT=18;
ALTER TABLE `guillotinesystems` AUTO_INCREMENT=2;
ALTER TABLE `products` AUTO_INCREMENT=30;
ALTER TABLE `roles` AUTO_INCREMENT=3;
ALTER TABLE `themes` AUTO_INCREMENT=13;
ALTER TABLE `users` AUTO_INCREMENT=7;
