
-- Insert data into roles table
INSERT INTO roles (name) VALUES
                             ('Admin'),
                             ('Customer'),
                             ('Store Manager'),
                             ('Guest'),
                             ('Support');

-- Insert data into accounts table
INSERT INTO accounts (user_name, phone_number, password, status) VALUES
                                                                     ('adminuser', '0123456789', 'adminpass', 1),
                                                                     ('customer1', '0987654321', 'password1', 1),
                                                                     ('storemanager', '1234567890', 'storepass', 1),
                                                                     ('guestuser', '2345678901', 'guestpass', 0),
                                                                     ('supportuser', '3456789012', 'supportpass', 1);

-- Insert data into role_accounts table
INSERT INTO role_accounts (role_id, account_id) VALUES
                                                    (1, 1),
                                                    (2, 2),
                                                    (3, 3),
                                                    (4, 4),
                                                    (5, 5);

-- Insert data into users table
INSERT INTO users (full_name, email, gender, birth_date, account_id) VALUES
                                                                         ('Admin User', 'admin@domain.com', 1, '1980-01-01', 1),
                                                                         ('Customer One', 'customer1@domain.com', 1, '1990-02-01', 2),
                                                                         ('Store Manager', 'store@domain.com', 1, '1985-03-01', 3),
                                                                         ('Guest User', 'guest@domain.com', 2, '2000-04-01', 4),
                                                                         ('Support User', 'support@domain.com', 1, '1995-05-01', 5);

-- Insert data into shipping_address table
INSERT INTO shipping_address (full_name, country, city, district, commune, home_address, address_note, is_default, account_id) VALUES
                                                                                                                                   ('John Doe', 'Vietnam', 'Hanoi', 'Cau Giay', 'My Dinh', '123 Main St', 'Near the park', TRUE, 1),
                                                                                                                                   ('Jane Doe', 'Vietnam', 'Ho Chi Minh City', 'District 1', NULL, '456 Some St', 'Near the mall', FALSE, 2),
                                                                                                                                   ('Michael Smith', 'Vietnam', 'Da Nang', 'Son Tra', 'An Hai', '789 Beach Road', 'Beach view', TRUE, 3),
                                                                                                                                   ('Emily Johnson', 'Vietnam', 'Hanoi', 'Dong Da', NULL, '101 Old St', 'Old town', FALSE, 4),
                                                                                                                                   ('David Brown', 'Vietnam', 'Hue', 'Thua Thien', NULL, '202 New Road', 'Near the river', FALSE, 5);

-- Insert data into orders table
INSERT INTO orders (order_note, status, shipping_fee, order_price, discount, account_id, shipping_address_id, shipping_method, store_id) VALUES
                                                                                                                                             ('Order 1 for Customer1', 1, 20.0, 100.0, 10.0, 1, 1, TRUE, 1),
                                                                                                                                             ('Order 2 for Customer2', 0, 15.0, 200.0, 15.0, 1, 2, FALSE, 2),
                                                                                                                                             ('Order 3 for Customer3', 1, 25.0, 300.0, 20.0, 1, 3, TRUE, 3),
                                                                                                                                             ('Order 4 for Customer4', 2, 10.0, 150.0, 5.0, 2, 4, FALSE, 4),
                                                                                                                                             ('Order 5 for Customer4', 1, 30.0, 250.0, 25.0, 2, 5, TRUE, 4);

-- Insert data into order_items table
INSERT INTO order_items (product_id, quantity, price, order_id) VALUES
                                                                    (1, 2, 50.0, 1),
                                                                    (2, 1, 200.0, 2),
                                                                    (3, 3, 100.0, 3),
                                                                    (4, 2, 75.0, 4),
                                                                    (5, 1, 250.0, 5);

-- Insert data into payment_methods table
INSERT INTO payment_methods (name, transaction_code) VALUES
                                                         ('Credit Card', 'TRX001'),
                                                         ('PayPal', 'TRX002'),
                                                         ('Bank Transfer', 'TRX003'),
                                                         ('Cash on Delivery', 'TRX004'),
                                                         ('Voucher', 'TRX005');

-- Insert data into payments table
INSERT INTO payments (status, amount_payable, account_id, order_id, completed_at) VALUES
                                                                                      (1, 90.0, 2, 1, NOW()),
                                                                                      (0, 170.0, 3, 2, NULL),
                                                                                      (1, 280.0, 4, 3, NOW()),
                                                                                      (2, 140.0, 2, 4, NOW()),
                                                                                      (1, 225.0, 5, 5, NOW());


-- Insert data into stores table
INSERT INTO stores (name, avatar_image_url, cover_image_url, email,
                    owner_identity_card, tax_code, industry, description, website_url, address, followers, status, account_id)
VALUES
    ('Store 1', 'avatar1.jpg', 'cover1.jpg', 'store1@domain.com', 'ID123', 'TC001', 'Electronics', 'Electronics store', 'www.store1.com', '123 Store St', 100, 1, 1),
    ('Store 2', 'avatar2.jpg', 'cover2.jpg', 'store2@domain.com', 'ID124', 'TC002', 'Furniture', 'Furniture store', 'www.store2.com', '456 Store Ave', 150, 1, 2),
    ('Store 3', 'avatar3.jpg', 'cover3.jpg', 'store3@domain.com', 'ID125', 'TC003', 'Clothing', 'Clothing store', 'www.store3.com', '789 Fashion St', 200, 1, 3),
    ('Store 4', 'avatar4.jpg', 'cover4.jpg', 'store4@domain.com', 'ID126', 'TC004', 'Groceries', 'Grocery store', 'www.store4.com', '101 Food St', 300, 1, 4),
    ('Store 5', 'avatar5.jpg', 'cover5.jpg', 'store5@domain.com', 'ID127', 'TC005', 'Books', 'Bookstore', 'www.store5.com', '202 Book Rd', 400, 1, 4);

-- Insert data into products table
INSERT INTO products (name, price, stock_quantity, sold_quantity, short_description, description, main_image_url, category_id, store_id) VALUES
                                                                                                                                             ('Product 1', 50.0, 100, 10, 'Electronics gadget', 'A high-quality gadget for all your needs', 'product1.jpg', 1, 1),
                                                                                                                                             ('Product 2', 200.0, 50, 5, 'Luxury Furniture', 'Elegant and comfortable furniture for your home', 'product2.jpg', 2, 2),
                                                                                                                                             ('Product 3', 100.0, 200, 30, 'Fashionable T-Shirt', 'Stylish and comfortable t-shirt', 'product3.jpg', 3, 3),
                                                                                                                                             ('Product 4', 75.0, 150, 20, 'Grocery Item', 'Fresh and organic grocery items', 'product4.jpg', 4, 4),
                                                                                                                                             ('Product 5', 250.0, 20, 2, 'Best-Selling Book', 'A bestseller for avid readers', 'product5.jpg', 5, 5);

-- Insert data into product_images table
INSERT INTO product_images (image_url, product_id) VALUES
                                                       ('product1_image1.jpg', 1),
                                                       ('product2_image1.jpg', 2),
                                                       ('product3_image1.jpg', 3),
                                                       ('product4_image1.jpg', 4),
                                                       ('product5_image1.jpg', 5);


-- Insert data into carts table
INSERT INTO carts (account_id) VALUES
                                   (1),
                                   (2),
                                   (3),
                                   (4),
                                   (5);

-- Insert data into cart_items table
INSERT INTO cart_items (product_id, quantity, cart_id) VALUES
                                                           (1, 1, 1),
                                                           (2, 2, 2),
                                                           (3, 1, 3),
                                                           (4, 3, 4),
                                                           (5, 1, 5);

-- Insert data into reviews table
INSERT INTO reviews (rating, comment, account_id, order_id) VALUES
                                                                (5, 'Excellent product!', 2, 1),
                                                                (4, 'Very comfortable.', 3, 2),
                                                                (3, 'Not bad, could be improved.', 4, 3),
                                                                (5, 'Loved it, highly recommended!', 5, 4),
                                                                (4, 'Good quality, decent value.', 2, 5);

INSERT INTO industries (name, description, created_at, updated_at, created_by)
VALUES
    ('Electronics', 'Industry focused on the production and trade of electronic devices and components', NOW(), NOW(), 1),
    ('Fashion', 'Industry focusing on the design, manufacture, and retail of clothing and accessories', NOW(), NOW(), 2),
    ('Food and Beverages', 'Industry related to the production, distribution, and retail of food and drinks', NOW(), NOW(), 3),
    ('Furniture', 'Industry specializing in the production and sale of furniture for homes and offices', NOW(), NOW(), 4),
    ('Health and Beauty', 'Industry related to personal care products, cosmetics, and wellness services', NOW(), NOW(), 5);

INSERT INTO categories (name, description, created_at, updated_at, industry_id)
VALUES
    ('Smartphones', 'Category for smartphones and mobile devices', NOW(), NOW(), 1),
    ('Clothing', 'Category for all types of clothing including men, women, and children', NOW(), NOW(), 2),
    ('Snacks', 'Category for all types of packaged and ready-to-eat snacks', NOW(), NOW(), 3),
    ('Office Furniture', 'Category for office desks, chairs, and other furniture for workplaces', NOW(), NOW(), 4),
    ('Cosmetics', 'Category for skincare, makeup, and beauty products', NOW(), NOW(), 5);
