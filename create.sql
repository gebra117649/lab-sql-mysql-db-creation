-- -----------------------------------------------------
-- 1. Creating and selecting a database
-- -----------------------------------------------------

CREATE DATABASE IF NOT EXISTS lab_mysql;
USE lab_mysql;

-- -----------------------------------------------------
-- 2. Dropping and recreating tables (DROP + CREATE)
-- -----------------------------------------------------

SET FOREIGN_KEY_CHECKS = 0; 
-- Temporarily disables key verification for a clean wipe

DROP TABLE IF EXISTS invoice;
DROP TABLE IF EXISTS car;
DROP TABLE IF EXISTS car_model;
DROP TABLE IF EXISTS salesperson;
DROP TABLE IF EXISTS branch;
DROP TABLE IF EXISTS customer_address;
DROP TABLE IF EXISTS customer;

SET FOREIGN_KEY_CHECKS = 1; 
-- Re-enabling key verification

-- -----------------------------------------------------
-- 3. CREATE TABLE Statements
-- -----------------------------------------------------

CREATE TABLE `car_model`(
    `model_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `manufacturer` VARCHAR(255) NOT NULL,
    `model` VARCHAR(255) NOT NULL,
    `fuel_type` VARCHAR(255) NULL,
    `body_type` VARCHAR(255) NULL,
    `transmission` VARCHAR(255) NULL
);

CREATE TABLE `car`(
    `car_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `VIN` VARCHAR(255) NOT NULL,
    `model_id` BIGINT UNSIGNED NOT NULL,
    `year` INT NOT NULL,
    `color` VARCHAR(255) NULL,
    `list_price` DECIMAL(10,2) NOT NULL
);
ALTER TABLE `car` ADD UNIQUE `car_vin_unique`(`VIN`);

CREATE TABLE `customer`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `customer_id` VARCHAR(255) NOT NULL,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `primary_phone` VARCHAR(255) NOT NULL,
    `additional_phone` VARCHAR(255) NULL
);
ALTER TABLE `customer` ADD UNIQUE `customer_customer_id_unique`(`customer_id`);

CREATE TABLE `customer_address`(
    `address_id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `customer_id` VARCHAR(255) NOT NULL,
    `address_type` VARCHAR(255) NOT NULL,
    `country` VARCHAR(255) NOT NULL,
    `state` VARCHAR(255) NULL,
    `city` VARCHAR(255) NOT NULL,
    `street_address` VARCHAR(255) NOT NULL,
    `zip_code` VARCHAR(255) NOT NULL
);

CREATE TABLE `branch`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `branch_id` VARCHAR(255) NOT NULL,
    `branch_name` VARCHAR(255) NOT NULL,
    `country` VARCHAR(255) NOT NULL,
    `state` VARCHAR(255) NULL,
    `city` VARCHAR(255) NOT NULL,
    `street_address` VARCHAR(255) NOT NULL,
    `zip_code` VARCHAR(255) NOT NULL
);
ALTER TABLE `branch` ADD UNIQUE `branch_branch_id_unique`(`branch_id`);

CREATE TABLE `salesperson`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `staff_id` VARCHAR(255) NOT NULL,
    `first_name` VARCHAR(255) NOT NULL,
    `last_name` VARCHAR(255) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `phone_number` VARCHAR(255) NOT NULL,
    `branch_id` VARCHAR(255) NOT NULL
);
ALTER TABLE `salesperson` ADD UNIQUE `salesperson_staff_id_unique`(`staff_id`);

CREATE TABLE `invoice`(
    `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `invoice_nr` VARCHAR(255) NOT NULL,
    `date` DATE NOT NULL,
    `car_id` BIGINT UNSIGNED NOT NULL,
    `customer_id` VARCHAR(255) NOT NULL,
    `staff_id` VARCHAR(255) NOT NULL,
    `sale_price` DECIMAL(10,2) NOT NULL
);

-- -----------------------------------------------------
-- 4. CONSTRAINTS & FOREIGN KEYS
-- -----------------------------------------------------

-- UNIQUE CONSTRAINTS
ALTER TABLE `invoice` ADD UNIQUE `invoice_invoice_nr_unique`(`invoice_nr`);
ALTER TABLE `invoice` ADD UNIQUE `invoice_car_id_unique`(`car_id`);

-- FOREIGN KEYS
ALTER TABLE `customer_address` ADD CONSTRAINT `fk_customer_address_customer` 
FOREIGN KEY(`customer_id`) REFERENCES `customer`(`customer_id`);

ALTER TABLE `car` ADD CONSTRAINT `fk_car_car_model` 
FOREIGN KEY(`model_id`) REFERENCES `car_model`(`model_id`);

ALTER TABLE `salesperson` ADD CONSTRAINT `fk_salesperson_branch` 
FOREIGN KEY(`branch_id`) REFERENCES `branch`(`branch_id`);

ALTER TABLE `invoice` ADD CONSTRAINT `fk_invoice_car` 
FOREIGN KEY(`car_id`) REFERENCES `car`(`car_id`);

ALTER TABLE `invoice` ADD CONSTRAINT `fk_invoice_customer` 
FOREIGN KEY(`customer_id`) REFERENCES `customer`(`customer_id`);

ALTER TABLE `invoice` ADD CONSTRAINT `fk_invoice_salesperson` 
FOREIGN KEY(`staff_id`) REFERENCES `salesperson`(`staff_id`);