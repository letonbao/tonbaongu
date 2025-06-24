-- SQL schema for clothing e-commerce (Shopee-like)
-- Drop old tables if exist
DROP TABLE IF EXISTS cart_items;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS notifications;
DROP TABLE IF EXISTS product_reviews;
DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS product_variants;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS user_addresses;
DROP TABLE IF EXISTS users;

-- USERS
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) UNIQUE,
  email VARCHAR(100) UNIQUE,
  phone VARCHAR(20) UNIQUE,
  password VARCHAR(255) NOT NULL,
  gender ENUM('male','female','other') DEFAULT NULL,
  dob DATE DEFAULT NULL,
  role ENUM('user','admin') DEFAULT 'user',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- USER ADDRESSES
CREATE TABLE user_addresses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  address_line VARCHAR(255) NOT NULL,
  city VARCHAR(100) NOT NULL,
  province VARCHAR(100) NOT NULL,
  postal_code VARCHAR(20),
  is_default BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- PRODUCTS
CREATE TABLE products (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  description TEXT,
  category ENUM('T-Shirts','Shirts','Jackets & Coats','Pants','Shorts','Knitwear','Suits & Blazers','Hoodies','Underwear','Loungewear') NOT NULL,
  gender_target ENUM('male','female','kids','unisex') NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- PRODUCT VARIANTS
CREATE TABLE product_variants (
  id INT AUTO_INCREMENT PRIMARY KEY,
  product_id INT NOT NULL,
  color ENUM('white','black','purple','pink','blue','silver','red','yellow','green','brown','gray','orange') NOT NULL,
  size ENUM('S','M','L','XL','XXL','XXXL') NOT NULL,
  material ENUM('Cotton','Linen','Wool','Polyester','Denim','Leather','Silk','Nylon') NOT NULL,
  style ENUM('T-Shirts','Shirts','Jackets & Coats','Pants','Shorts','Knitwear','Suits & Blazers','Hoodies','Underwear','Loungewear') NOT NULL,
  price DECIMAL(15,2) NOT NULL,
  stock INT NOT NULL DEFAULT 0,
  image_url VARCHAR(255),
  status ENUM('active','inactive','out_of_stock') DEFAULT 'active',
  FOREIGN KEY (product_id) REFERENCES products(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ORDERS
CREATE TABLE orders (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  address_id INT NOT NULL,
  order_date DATETIME DEFAULT CURRENT_TIMESTAMP,
  total_amount DECIMAL(15,2) NOT NULL,
  status ENUM('pending','confirmed','shipping','delivered','cancelled') DEFAULT 'pending',
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (address_id) REFERENCES user_addresses(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ORDER ITEMS
CREATE TABLE order_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  product_variant_id INT NOT NULL,
  quantity INT NOT NULL,
  price DECIMAL(15,2) NOT NULL, -- price at order time
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE,
  FOREIGN KEY (product_variant_id) REFERENCES product_variants(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- PRODUCT REVIEWS
CREATE TABLE product_reviews (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  product_id INT NOT NULL,
  order_id INT NOT NULL,
  rating INT NOT NULL CHECK (rating BETWEEN 1 AND 5),
  content TEXT,
  image_url VARCHAR(255),
  video_url VARCHAR(255),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (product_id) REFERENCES products(id),
  FOREIGN KEY (order_id) REFERENCES orders(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- NOTIFICATIONS
CREATE TABLE notifications (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  title VARCHAR(255) NOT NULL,
  content TEXT,
  type ENUM('order_status','sale','voucher','other') DEFAULT 'other',
  is_read BOOLEAN DEFAULT FALSE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- PAYMENTS
CREATE TABLE payments (
  id INT AUTO_INCREMENT PRIMARY KEY,
  order_id INT NOT NULL,
  payment_method ENUM('COD','Bank','Momo','VNPAY','Other') NOT NULL,
  amount DECIMAL(15,2) NOT NULL,
  status ENUM('pending','paid','failed','refunded') DEFAULT 'pending',
  transaction_code VARCHAR(100),
  paid_at DATETIME DEFAULT NULL,
  FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- CART ITEMS
CREATE TABLE cart_items (
  id INT AUTO_INCREMENT PRIMARY KEY,
  user_id INT NOT NULL,
  product_variant_id INT NOT NULL,
  quantity INT NOT NULL DEFAULT 1,
  added_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
  FOREIGN KEY (product_variant_id) REFERENCES product_variants(id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- USERS
INSERT INTO users (username, email, phone, password, gender, dob, role) VALUES
('admin', 'admin@example.com', '0900000000', 'admin123', 'male', '1990-01-01', 'admin'),
('alice', 'alice@gmail.com', '0911111111', 'alicepass', 'female', '2000-05-10', 'user'),
('bob', 'bob@gmail.com', '0922222222', 'bobpass', 'male', '1998-08-20', 'user');

-- USER ADDRESSES
INSERT INTO user_addresses (user_id, address_line, city, province, postal_code, is_default) VALUES
(2, '123 Đường Hoa Hồng', 'Hà Nội', 'Hà Nội', '100000', TRUE),
(3, '456 Đường Hoa Cúc', 'Hồ Chí Minh', 'Hồ Chí Minh', '700000', TRUE);

-- PRODUCTS
INSERT INTO products (name, description, category, gender_target) VALUES
('Áo thun nam basic', 'Áo thun cotton thoáng mát', 'T-Shirts', 'male'),
('Áo len nữ cao cấp', 'Áo len chất liệu wool mềm mại', 'Knitwear', 'female');

-- PRODUCT VARIANTS
INSERT INTO product_variants (product_id, color, size, material, style, price, stock, image_url, status) VALUES
(1, 'black', 'M', 'Cotton', 'T-Shirts', 199000, 10, 'images/shirt_black_m.png', 'active'),
(1, 'white', 'L', 'Cotton', 'T-Shirts', 209000, 5, 'images/shirt_white_l.png', 'active'),
(2, 'pink', 'S', 'Wool', 'Knitwear', 299000, 8, 'images/knitwear_pink_s.png', 'active');

-- ORDERS
INSERT INTO orders (user_id, address_id, order_date, total_amount, status) VALUES
(2, 1, '2024-06-25 10:00:00', 398000, 'delivered'),
(3, 2, '2024-06-26 15:30:00', 299000, 'pending');

-- ORDER ITEMS
INSERT INTO order_items (order_id, product_variant_id, quantity, price) VALUES
(1, 1, 1, 199000),
(1, 2, 1, 199000),
(2, 3, 1, 299000);

-- PRODUCT REVIEWS
INSERT INTO product_reviews (user_id, product_id, order_id, rating, content, image_url, video_url) VALUES
(2, 1, 1, 5, 'Áo đẹp, chất vải tốt!', 'images/review1.png', NULL),
(2, 1, 1, 4, 'Mặc vừa vặn, sẽ ủng hộ tiếp.', NULL, NULL);

-- NOTIFICATIONS
INSERT INTO notifications (user_id, title, content, type, is_read) VALUES
(2, 'Đơn hàng đã giao thành công', 'Đơn hàng #1 của bạn đã được giao.', 'order_status', FALSE),
(3, 'Khuyến mãi hè', 'Giảm giá 10% cho đơn hàng đầu tiên!', 'sale', FALSE);

-- PAYMENTS
INSERT INTO payments (order_id, payment_method, amount, status, transaction_code, paid_at) VALUES
(1, 'COD', 398000, 'paid', 'COD123456', '2024-06-25 10:05:00'),
(2, 'Momo', 299000, 'pending', NULL, NULL);

-- CART ITEMS
INSERT INTO cart_items (user_id, product_variant_id, quantity) VALUES
(2, 3, 2),
(3, 1, 1);
