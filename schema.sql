-- Active: 1709377974996@@127.0.0.1@5432@test
-- product-schema
CREATE Table product_category (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    "desc" TEXT,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP WITHOUT TIME ZONE NULL
);

INSERT INTO
    product_category (id, name, "desc")
VALUES (
        1, 'Electronics', 'Devices, gadgets, and gizmos that run on electricity.'
    ),
    (
        2, 'Clothing', 'Apparel for men, women, and children of all ages.'
    ),
    (
        3, 'Books', 'Printed works of fiction and non-fiction, across various genres.'
    ),
    (
        4, 'Home & Kitchen', 'All essentials and decor for home and kitchen spaces.'
    );

SELECT * FROM product_category

-- product_inventory schema
CREATE TABLE product_inventory (
    id INT PRIMARY KEY NOT NULL,
    quantity INT,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP WITHOUT TIME ZONE NULL
);

INSERT INTO
    product_inventory (id, quantity)
VALUES (1, 100),
    (2, 200),
    (3, 150),
    (4, 50),
    (5, 75);

SELECT * FROM product_inventory

-- discount schema
CREATE TABLE discount (
    id INT PRIMARY KEY NOT NULL,
    name VARCHAR(50),
    "desc" TEXT,
    discount_percent DECIMAL(10, 2),
    "active" BOOLEAN,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP WITHOUT TIME ZONE NULL
);

INSERT INTO
    discount (
        id, name, "desc", discount_percent, "active"
    )
VALUES (
        1, 'Spring Sale', 'Discount applicable for all spring collection items.', 10.00, TRUE
    ),
    (
        2, 'New Customer', 'Discount for new customers on their first purchase.', 15.00, TRUE
    ),
    (
        3, 'Clearance Sale', 'End of season clearance sale on all items.', 20.00, FALSE
    ),
    (
        4, 'Holiday Special', 'Special holiday discount for selected products.', 5.00, TRUE
    ),
    (
        5, 'Bulk Order', 'Discount on orders over $500.', 10.00, TRUE
    );

SELECT * FROM discount;

-- product Schema
CREATE Table product (
    id INT PRIMARY KEY,
    name VARCHAR(255), "desc" TEXT,
    SKU VARCHAR(50),
    category_id INT REFERENCES product_category (id) NOT NULL,
    inventory_id INT REFERENCES product_inventory (id) NOT NULL,
    price DECIMAL(10, 2),
    discount_id INT REFERENCES discount (id),
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    modified_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP WITHOUT TIME ZONE NULL
);

INSERT INTO
    product (
        id, name, "desc", SKU, category_id, inventory_id, price, discount_id
    )
VALUES (
        1, 'Eco-friendly Water Bottle', 'A 32oz water bottle made from recycled materials.', 'WB-32OZ-ECO', 1, 1, 19.99, 1
    ),
    (
        2, 'Wireless Charging Pad', 'Fast-charging pad with minimalist design.', 'CHRG-PAD-001', 1, 2, 35.50, 2
    ),
    (
        3, 'Bluetooth Headphones', 'Noise-cancelling over-ear headphones.', 'BT-HPHONES-NC', 1, 3, 89.99, NULL
    ),
    (
        4, 'Organic Cotton T-Shirt', 'Soft, 100% organic cotton t-shirt in multiple colors.', 'COT-TS-001', 2, 4, 25.00, 4
    ),
    (
        5, 'Fantasy Novel', '"The Last Ember" - A journey through magical realms.', 'BK-FANT-001', 3, 5, 14.99, NULL
    );

SELECT * FROM product;

-- created a function for update_at field
CREATE OR REPLACE FUNCTION update_modified_at() RETURNS 
TRIGGER AS 
$$
BEGIN
	NEW.modified_at = CURRENT_TIMESTAMP;
	RETURN NEW;
END;
$$
language
'plpgsql'; 

-- created a trigger for update product updated_at
CREATE TRIGGER update_modified_at BEFORE
UPDATE ON product FOR EACH ROW
EXECUTE FUNCTION update_modified_at ();

UPDATE product set price = 99.99 WHERE id = 1
