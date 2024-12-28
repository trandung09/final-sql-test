create database `sendo-db`;

use `sendo-db`;

# -- Bảng roles
CREATE TABLE roles (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       name VARCHAR(50) UNIQUE NOT NULL
);

-- Bảng accounts
CREATE TABLE accounts (
                          id INT PRIMARY KEY AUTO_INCREMENT,
                          user_name VARCHAR(100) NOT NULL,
                          phone_number VARCHAR(50) UNIQUE NOT NULL,
                          password VARCHAR(100) NOT NULL,
                          status INT NOT NULL,
                          created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                          updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng role_accounts
CREATE TABLE role_accounts (
                               role_id INT NOT NULL,
                               account_id INT NOT NULL,
                               PRIMARY KEY (role_id, account_id),
                               FOREIGN KEY (role_id) REFERENCES roles(id),
                               FOREIGN KEY (account_id) REFERENCES accounts(id)
);

-- Bảng users
CREATE TABLE users (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       full_name VARCHAR(100) NOT NULL,
                       email VARCHAR(100) NOT NULL,
                       gender INT NOT NULL,
                       birth_date DATE,
                       avatar_image_url VARCHAR(255),
                       account_id INT NOT NULL,
                       FOREIGN KEY (account_id) REFERENCES accounts(id)
);

-- Bảng shipping_address
CREATE TABLE shipping_address (
                                  id INT PRIMARY KEY AUTO_INCREMENT,
                                  full_name VARCHAR(255) NOT NULL,
                                  country VARCHAR(255) NOT NULL,
                                  city VARCHAR(255) NOT NULL,
                                  district VARCHAR(255) NOT NULL,
                                  commune VARCHAR(255),
                                  home_address VARCHAR(255) NOT NULL,
                                  address_note TEXT,
                                  is_default BOOLEAN DEFAULT FALSE,
                                  account_id INT NOT NULL,
                                  FOREIGN KEY (account_id) REFERENCES accounts(id)
);

-- Bảng orders
CREATE TABLE orders (
                        id INT PRIMARY KEY AUTO_INCREMENT,
                        order_note TEXT,
                        status INT NOT NULL,
                        shipping_fee DOUBLE NOT NULL,
                        order_price DOUBLE NOT NULL,
                        discount DOUBLE,
                        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        account_id INT NOT NULL,
                        shipping_address_id INT NOT NULL,
                        payment_method_id INT,
                        payment_id INT,
                        shipping_method BOOLEAN NOT NULL,
                        store_id INT,
                        FOREIGN KEY (account_id) REFERENCES accounts(id),
                        FOREIGN KEY (shipping_address_id) REFERENCES shipping_address(id),
                        FOREIGN KEY (payment_method_id) REFERENCES payment_methods(id),
                        FOREIGN KEY (store_id) REFERENCES stores(id)
);

-- Bảng order_items
CREATE TABLE order_items (
                             id INT PRIMARY KEY AUTO_INCREMENT,
                             product_id INT NOT NULL,
                             quantity INT NOT NULL,
                             price DOUBLE NOT NULL,
                             order_id INT NOT NULL,
                             FOREIGN KEY (order_id) REFERENCES orders(id),
                             FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Bảng payment_methods
CREATE TABLE payment_methods (
                                 id INT PRIMARY KEY AUTO_INCREMENT,
                                 name VARCHAR(255) NOT NULL,
                                 transaction_code VARCHAR(255)
);

-- Bảng payments
CREATE TABLE payments (
                          id INT PRIMARY KEY AUTO_INCREMENT,
                          status INT NOT NULL,
                          amount_payable DOUBLE NOT NULL,
                          account_id INT NOT NULL,
                          order_id INT NOT NULL,
                          completed_at DATETIME,
                          FOREIGN KEY (account_id) REFERENCES accounts(id),
                          FOREIGN KEY (order_id) REFERENCES orders(id)
);

-- Bảng shipping_units
CREATE TABLE shipping_units (
                                id INT PRIMARY KEY AUTO_INCREMENT,
                                name VARCHAR(255) NOT NULL
);

-- Bảng stores
CREATE TABLE stores (
                        id INT PRIMARY KEY AUTO_INCREMENT,
                        name VARCHAR(100) NOT NULL,
                        avatar_image_url VARCHAR(255),
                        cover_image_url VARCHAR(255),
                        email VARCHAR(100) NOT NULL,
                        owner_identity_card VARCHAR(100) NOT NULL,
                        tax_code VARCHAR(50),
                        industry VARCHAR(100),
                        description TEXT,
                        website_url VARCHAR(255) UNIQUE,
                        address VARCHAR(255) NOT NULL,
                        followers INT DEFAULT 0,
                        status INT NOT NULL,
                        created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                        updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        account_id INT NOT NULL,
                        FOREIGN KEY (account_id) REFERENCES accounts(id)
);

-- Bảng store_shipping_units
CREATE TABLE store_shipping_units (
                                      store_id INT NOT NULL,
                                      shipping_unit_id INT NOT NULL,
                                      PRIMARY KEY (store_id, shipping_unit_id),
                                      FOREIGN KEY (store_id) REFERENCES stores(id),
                                      FOREIGN KEY (shipping_unit_id) REFERENCES shipping_units(id)
);

-- Bảng industries
CREATE TABLE industries (
                            id INT PRIMARY KEY AUTO_INCREMENT,
                            name VARCHAR(255) UNIQUE NOT NULL,
                            description TEXT,
                            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                            updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                            created_by INT,
                            FOREIGN KEY (created_by) REFERENCES accounts(id)
);

-- Bảng store_industries
CREATE TABLE store_industries (
                                  store_id INT NOT NULL,
                                  industry_id INT NOT NULL,
                                  PRIMARY KEY (store_id, industry_id),
                                  FOREIGN KEY (store_id) REFERENCES stores(id),
                                  FOREIGN KEY (industry_id) REFERENCES industries(id)
);

-- Bảng categories
CREATE TABLE categories (
                            id INT PRIMARY KEY AUTO_INCREMENT,
                            name VARCHAR(150) UNIQUE NOT NULL,
                            description TEXT,
                            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                            updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                            industry_id INT NOT NULL,
                            FOREIGN KEY (industry_id) REFERENCES industries(id)
);

-- Bảng products
CREATE TABLE products (
                          id INT PRIMARY KEY AUTO_INCREMENT,
                          name VARCHAR(150) NOT NULL,
                          price DOUBLE NOT NULL,
                          stock_quantity INT NOT NULL,
                          sold_quantity INT DEFAULT 0,
                          short_description TEXT,
                          description TEXT,
                          main_image_url VARCHAR(255),
                          category_id INT NOT NULL,
                          store_id INT NOT NULL,
                          has_discount BOOLEAN DEFAULT FALSE,
                          discount_from_store DOUBLE,
                          created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                          updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                          FOREIGN KEY (category_id) REFERENCES categories(id),
                          FOREIGN KEY (store_id) REFERENCES stores(id)
);

-- Bảng product_images
CREATE TABLE product_images (
                                id INT PRIMARY KEY AUTO_INCREMENT,
                                image_url VARCHAR(255) NOT NULL,
                                product_id INT NOT NULL,
                                FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Bảng notifications
CREATE TABLE notifications (
                               id INT PRIMARY KEY AUTO_INCREMENT,
                               title VARCHAR(255) NOT NULL,
                               content TEXT NOT NULL,
                               account_id INT NOT NULL,
                               is_public BOOLEAN DEFAULT FALSE,
                               created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                               updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               FOREIGN KEY (account_id) REFERENCES accounts(id)
);

-- Bảng carts
CREATE TABLE carts (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       account_id INT NOT NULL,
                       FOREIGN KEY (account_id) REFERENCES accounts(id)
);

-- Bảng cart_items
CREATE TABLE cart_items (
                            id INT PRIMARY KEY AUTO_INCREMENT,
                            product_id INT NOT NULL,
                            quantity INT NOT NULL,
                            cart_id INT NOT NULL,
                            FOREIGN KEY (cart_id) REFERENCES carts(id),
                            FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Bảng reviews
CREATE TABLE reviews (
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         rating INT NOT NULL,
                         comment TEXT,
                         created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                         updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                         account_id INT NOT NULL,
                         order_id INT NOT NULL,
                         FOREIGN KEY (order_id) REFERENCES orders(id),
                         FOREIGN KEY (account_id) REFERENCES accounts(id)
);

-- Bảng coupons
CREATE TABLE coupons (
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         code VARCHAR(25) UNIQUE NOT NULL,
                         created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                         expiry_date DATETIME NOT NULL,
                         quantity INT NOT NULL,
                         is_active BOOLEAN DEFAULT TRUE
);

-- Bảng account_coupons
CREATE TABLE account_coupons (
                                 account_id INT NOT NULL,
                                 coupon_id INT NOT NULL,
                                 PRIMARY KEY (account_id, coupon_id),
                                 FOREIGN KEY (account_id) REFERENCES accounts(id),
                                 FOREIGN KEY (coupon_id) REFERENCES coupons(id)
);

-- Bảng coupon_conditions
CREATE TABLE coupon_conditions (
                                   id INT PRIMARY KEY AUTO_INCREMENT,
                                   operator VARCHAR(50) NOT NULL,
                                   condition_type VARCHAR(50) NOT NULL
);

-- Bảng coupon_couponconditions
CREATE TABLE coupon_couponconditions (
                                         coupon_id INT NOT NULL,
                                         coupon_condition_id INT NOT NULL,
                                         PRIMARY KEY (coupon_id, coupon_condition_id),
                                         FOREIGN KEY (coupon_id) REFERENCES coupons(id),
                                         FOREIGN KEY (coupon_condition_id) REFERENCES coupon_conditions(id)
);

-- Bảng attributes
CREATE TABLE attributes (
                            id INT PRIMARY KEY AUTO_INCREMENT,
                            name VARCHAR(255) NOT NULL,
                            created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                            updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Bảng product_attributes
CREATE TABLE product_attributes (
                                    product_id INT NOT NULL,
                                    attribute_id INT NOT NULL,
                                    PRIMARY KEY (product_id, attribute_id),
                                    FOREIGN KEY (product_id) REFERENCES products(id),
                                    FOREIGN KEY (attribute_id) REFERENCES attributes(id)
);

-- Bảng attribute_values
CREATE TABLE attribute_values (
                                  id INT PRIMARY KEY AUTO_INCREMENT,
                                  value VARCHAR(255) NOT NULL,
                                  color VARCHAR(50),
                                  attribute_id INT NOT NULL,
                                  FOREIGN KEY (attribute_id) REFERENCES attributes(id)
);

-- Bảng product_variants
CREATE TABLE product_variants (
                                  id INT PRIMARY KEY AUTO_INCREMENT,
                                  product_id INT NOT NULL,
                                  quantity INT NOT NULL,
                                  FOREIGN KEY (product_id) REFERENCES products(id)
);

-- Bảng product_variant_attributes
CREATE TABLE product_variant_attributes (
                                            attribute_id INT NOT NULL,
                                            product_variant_id INT NOT NULL,
                                            PRIMARY KEY (attribute_id, product_variant_id),
                                            FOREIGN KEY (attribute_id) REFERENCES attributes(id),
                                            FOREIGN KEY (product_variant_id) REFERENCES product_variants(id)
);
