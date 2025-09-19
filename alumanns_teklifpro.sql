SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;


CREATE TABLE categories (
  id int(11) NOT NULL,
  name varchar(255) NOT NULL,
  unit_type enum('kg/m','adet','m','m²') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

CREATE TABLE company (
  id int(11) NOT NULL,
  user_id int(11) NOT NULL,
  logo text DEFAULT NULL,
  name varchar(255) NOT NULL,
  email varchar(255) DEFAULT NULL,
  phone varchar(50) DEFAULT NULL,
  address text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

CREATE TABLE customers (
  id int(11) NOT NULL,
  first_name varchar(255) NOT NULL,
  last_name varchar(255) DEFAULT NULL,
  company_name varchar(255) DEFAULT NULL,
  company varchar(255) DEFAULT NULL,
  email varchar(255) DEFAULT NULL,
  phone varchar(50) DEFAULT NULL,
  address text DEFAULT NULL,
  tax_number varchar(255) DEFAULT NULL,
  tax_office varchar(255) DEFAULT NULL,
  city varchar(255) DEFAULT NULL,
  country varchar(255) DEFAULT NULL,
  notes text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

CREATE TABLE generaloffers (
  id int(11) NOT NULL,
  quote_no varchar(50) DEFAULT NULL,
  customer_id int(11) DEFAULT NULL,
  company_id int(11) DEFAULT NULL,
  offer_date date DEFAULT NULL,
  assembly_type varchar(100) DEFAULT NULL,
  delivery_time varchar(100) DEFAULT NULL,
  payment_method varchar(100) DEFAULT NULL,
  validity_days int(11) DEFAULT NULL,
  valid_until date DEFAULT NULL,
  installment_term varchar(100) DEFAULT NULL,
  payment_type enum('cash','installment') NOT NULL DEFAULT 'cash',
  term_months int(11) DEFAULT NULL,
  interest_mode enum('percent','fixed') DEFAULT NULL,
  interest_value decimal(12,2) DEFAULT NULL,
  interest_amount decimal(12,2) DEFAULT NULL,
  total_with_interest decimal(12,2) DEFAULT NULL,
  monthly_installment decimal(12,2) DEFAULT NULL,
  grace_days int(11) DEFAULT 0,
  payment_term varchar(100) DEFAULT NULL,
  offer_validity varchar(100) DEFAULT NULL,
  maturity_period varchar(100) DEFAULT NULL,
  discount_rate decimal(5,2) DEFAULT NULL,
  discount_amount decimal(10,2) DEFAULT NULL,
  vat_rate decimal(5,2) DEFAULT NULL,
  vat_amount decimal(10,2) DEFAULT NULL,
  total_amount decimal(15,2) DEFAULT NULL,
  profit_percent decimal(5,2) DEFAULT NULL,
  profit_amount decimal(15,2) DEFAULT NULL,
  status varchar(20) NOT NULL DEFAULT 'pending',
  approval_token varchar(64) DEFAULT NULL,
  approved_at datetime DEFAULT NULL,
  note text DEFAULT NULL,
  shared_at datetime DEFAULT NULL,
  shared_by int(11) DEFAULT NULL,
  share_count int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

CREATE TABLE guillotinesystems (
  id int(11) NOT NULL,
  general_offer_id int(11) DEFAULT NULL,
  system_type varchar(100) DEFAULT NULL,
  width decimal(10,2) DEFAULT NULL,
  height decimal(10,2) DEFAULT NULL,
  quantity int(11) DEFAULT NULL,
  motor_system varchar(100) DEFAULT NULL,
  remote_quantity int(11) DEFAULT NULL,
  ral_code varchar(50) DEFAULT NULL,
  paint_face varchar(100) DEFAULT NULL,
  glass_type varchar(100) DEFAULT NULL,
  glass_color varchar(50) DEFAULT NULL,
  profit_margin decimal(5,2) DEFAULT NULL,
  profit_rate decimal(5,2) DEFAULT NULL,
  profit_amount decimal(10,2) DEFAULT NULL,
  total_amount decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

CREATE TABLE products (
  id int(11) NOT NULL,
  product_code varchar(100) NOT NULL,
  name varchar(255) NOT NULL,
  unit varchar(50) DEFAULT NULL,
  channel_count tinyint(3) UNSIGNED DEFAULT NULL,
  color varchar(50) DEFAULT NULL,
  image_data longblob DEFAULT NULL,
  image_mime varchar(100) DEFAULT NULL,
  image_url text DEFAULT NULL,
  description text DEFAULT NULL,
  unit_price decimal(10,2) DEFAULT NULL,
  weight_per_meter decimal(10,3) DEFAULT NULL,
  vat_rate decimal(5,2) DEFAULT NULL,
  category_id int(11) DEFAULT NULL,
  price_unit enum('USD','EUR','TRY') NOT NULL DEFAULT 'TRY'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

CREATE TABLE roles (
  id int(11) NOT NULL,
  name varchar(255) NOT NULL DEFAULT 'user'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

CREATE TABLE slidingsystems (
  id int(11) NOT NULL,
  general_offer_id int(11) DEFAULT NULL,
  system_type varchar(100) DEFAULT NULL,
  width decimal(10,2) DEFAULT NULL,
  height decimal(10,2) DEFAULT NULL,
  wing_type varchar(100) DEFAULT NULL,
  quantity int(11) DEFAULT NULL,
  ral_code varchar(50) DEFAULT NULL,
  lock_type varchar(100) DEFAULT NULL,
  glass_type varchar(100) DEFAULT NULL,
  glass_color varchar(50) DEFAULT NULL,
  profit_rate decimal(5,2) DEFAULT NULL,
  profit_amount decimal(10,2) DEFAULT NULL,
  total_amount decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

CREATE TABLE themes (
  id int(11) NOT NULL,
  user_id int(11) DEFAULT NULL,
  theme varchar(100) DEFAULT NULL,
  primary_color varchar(20) DEFAULT NULL,
  secondary_color varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;

CREATE TABLE users (
  id int(11) NOT NULL,
  first_name varchar(255) NOT NULL,
  last_name varchar(255) NOT NULL,
  username varchar(100) NOT NULL,
  password varchar(255) NOT NULL,
  email varchar(255) NOT NULL,
  created_at datetime DEFAULT current_timestamp(),
  status enum('active','inactive') DEFAULT 'active',
  role_id int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_turkish_ci;


ALTER TABLE categories
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY uq_categories_name (name);

ALTER TABLE company
  ADD PRIMARY KEY (id),
  ADD KEY idx_company_user_id (user_id);

ALTER TABLE customers
  ADD PRIMARY KEY (id),
  ADD KEY idx_customers_email (email);

ALTER TABLE generaloffers
  ADD PRIMARY KEY (id),
  ADD KEY idx_generaloffers_customer_id (customer_id),
  ADD KEY idx_generaloffers_company_id (company_id),
  ADD KEY idx_generaloffers_status (status),
  ADD KEY idx_generaloffers_shared_by (shared_by);

ALTER TABLE guillotinesystems
  ADD PRIMARY KEY (id),
  ADD KEY idx_guillotine_offer_id (general_offer_id);

ALTER TABLE products
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY uq_products_product_code (product_code),
  ADD KEY idx_products_category_id (category_id);

ALTER TABLE roles
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY uq_roles_name (name);

ALTER TABLE slidingsystems
  ADD PRIMARY KEY (id),
  ADD KEY idx_slidingsystems_offer_id (general_offer_id);

ALTER TABLE themes
  ADD PRIMARY KEY (id),
  ADD KEY idx_themes_user_id (user_id);

ALTER TABLE users
  ADD PRIMARY KEY (id),
  ADD UNIQUE KEY uq_users_username (username),
  ADD KEY idx_users_role_id (role_id);


ALTER TABLE categories
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE company
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE customers
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE generaloffers
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE guillotinesystems
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE products
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE roles
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE slidingsystems
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE themes
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;

ALTER TABLE users
  MODIFY id int(11) NOT NULL AUTO_INCREMENT;


ALTER TABLE company
  ADD CONSTRAINT fk_company_user_id FOREIGN KEY (user_id) REFERENCES `users` (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE generaloffers
  ADD CONSTRAINT fk_generaloffers_company FOREIGN KEY (company_id) REFERENCES company (id) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT fk_generaloffers_customer FOREIGN KEY (customer_id) REFERENCES customers (id) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT fk_generaloffers_shared_by FOREIGN KEY (shared_by) REFERENCES `users` (id) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE guillotinesystems
  ADD CONSTRAINT fk_guillotine_offer FOREIGN KEY (general_offer_id) REFERENCES generaloffers (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE products
  ADD CONSTRAINT fk_products_category FOREIGN KEY (category_id) REFERENCES categories (id) ON DELETE SET NULL ON UPDATE CASCADE;

ALTER TABLE slidingsystems
  ADD CONSTRAINT fk_slidingsystems_offer FOREIGN KEY (general_offer_id) REFERENCES generaloffers (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE themes
  ADD CONSTRAINT fk_themes_user FOREIGN KEY (user_id) REFERENCES `users` (id) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE users
  ADD CONSTRAINT fk_users_role_id FOREIGN KEY (role_id) REFERENCES `roles` (id) ON DELETE SET NULL ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
