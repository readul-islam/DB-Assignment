-- Active: 1709377974996@@127.0.0.1@5432@test
CREATE Table product_category (
    id INT PRIMARY KEY, name VARCHAR(50), "desc" TEXT, create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, deleted_at TIMESTAMP DEFAULT NULL
);
-- drop TABLE product_category;

-- INSERT INTO product_category()

CREATE Table product (
    id INT PRIMARY KEY, name VARCHAR(255), 'desc' TEXT, SKU VARCHAR(50), category_id INT REFERENCES product_category (id) NOT NULL, inventory_id INT REFERENCES product_inventory (id), price DECIMAL(10, 2), discount_id INT REFERENCES discount (id), create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, deleted_at TIMESTAMP DEFAULT NULL
);

CREATE TABLE product_inventory (
    id INT PRIMARY KEY NOT NULL, quantity INT,
    create_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, modified_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, deleted_at TIMESTAMP DEFAULT NULL
);
