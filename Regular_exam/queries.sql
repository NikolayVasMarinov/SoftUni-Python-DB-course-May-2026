CREATE TABLE brands (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE classifications (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(30) NOT NULL UNIQUE
);

CREATE TABLE customers (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    address VARCHAR(150) NOT NULL,
    phone VARCHAR(30) NOT NULL UNIQUE,
    loyalty_card BOOLEAN NOT NULL DEFAULT(FALSE)
);

CREATE TABLE items (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    quantity INT NOT NULL CHECK(quantity >= 0),
    price NUMERIC(12, 2) NOT NULL CHECK(price > 0.00),
    description TEXT,
    brand_id INT NOT NULL REFERENCES brands(id) ON DELETE CASCADE ON UPDATE CASCADE,
    classification_id INT NOT NULL REFERENCES classifications(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE orders (
  id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  created_at TIMESTAMP NOT NULL DEFAULT(NOW()),
  customer_id INT NOT NULL REFERENCES customers(id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE reviews (
    customer_id INT NOT NULL REFERENCES customers(id) ON DELETE CASCADE ON UPDATE CASCADE,
    item_id INT NOT NULL REFERENCES items(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(customer_id, item_id),
    created_at TIMESTAMP NOT NULL DEFAULT(NOW()),
    rating NUMERIC(3, 1) NOT NULL DEFAULT(0.0) CHECK(rating <= 10.0)
);

CREATE TABLE orders_items (
    order_id INT NOT NULL REFERENCES orders(id) ON DELETE CASCADE ON UPDATE CASCADE,
    item_id INT NOT NULL REFERENCES items(id) ON DELETE CASCADE ON UPDATE CASCADE,
    PRIMARY KEY(order_id, item_id),
    quantity INT NOT NULL CHECK(quantity >= 0)
);



INSERT INTO items(name, quantity, price, description, brand_id, classification_id)
    SELECT
        CONCAT('Item', created_at),
        customer_id,
        rating * 5,
        NULL,
        item_id,
        (SELECT MIN(item_id) FROM reviews LIMIT 1)
    FROM reviews
    ORDER BY item_id, created_at
    LIMIT 10;



UPDATE reviews
SET
    rating = CASE
                WHEN item_id = customer_id THEN rating = 10.0
                WHEN item_id < customer_id THEN rating = 5.5
                ELSE rating
            END;


DELETE FROM customers
WHERE id NOT IN (SELECT customer_id FROM orders);



SELECT
    id,
    last_name,
    loyalty_card
FROM customers
WHERE loyalty_card IS TRUE AND last_name ILIKE '%m%'
ORDER BY last_name DESC, id;



SELECT
    id,
    TO_CHAR(created_at, 'DD-MM-YYYY'),
    customer_id
FROM orders
WHERE customer_id BETWEEN 15 AND 30 AND created_at > '01-01-2025'
ORDER BY TO_CHAR(created_at, 'DD-MM-YYYY'), customer_id DESC, id
LIMIT 5;



SELECT
    i.name,
    CONCAT(UPPER(b.name), '/', LOWER(c.name)) AS promotion,
    CONCAT('On sale: ', i.description) AS description,
    i.quantity
FROM items AS i
    JOIN brands AS b ON i.brand_id = b.id
    JOIN classifications as C ON i.classification_id = c.id
WHERE i.id NOT IN (SELECT item_id FROM orders_items)
ORDER BY i.quantity DESC, i.name;



SELECT
    id AS customer_id,
    CONCAT(first_name, ' ', last_name) AS full_name,
    (SELECT COUNT(*) FROM orders WHERE customers.id = customer_id) AS total_orders,
    CASE loyalty_card
        WHEN TRUE THEN 'Loyal Customer'
        ELSE 'Regular Customer'
    END AS loyalty_status
FROM customers
WHERE id NOT IN (SELECT customer_id FROM reviews) AND id IN (SELECT customer_id FROM orders)
ORDER BY total_orders DESC, customer_id;



SELECT
    i.name AS item_name,
    ROUND(AVG(r.rating), 2) AS average_rating,
    (SELECT COUNT(*) FROM reviews WHERE i.id = item_id) AS total_reviews,
    b.name,
    c.name
FROM items AS i
    JOIN brands AS b ON i.brand_id = b.id
    JOIN classifications as C ON i.classification_id = c.id
    JOIN reviews AS r ON i.id = r.item_id
GROUP BY i.id, b.name, c.name
HAVING COUNT(r.customer_id) >= 3
ORDER BY AVG(r.rating) DESC, item_name
LIMIT 3;



CREATE FUNCTION udf_classification_items_count(classification_name VARCHAR(30))
RETURNS TEXT
AS $$
    DECLARE items_count INT;
    BEGIN
        SELECT
            COUNT(*) INTO items_count
        FROM classifications AS c
            JOIN items as i on i.classification_id = c.id
        WHERE c.name = classification_name;
    RETURN
		CASE
			WHEN items_count = 0 THEN 'No items found.'
            ELSE CONCAT('Found ', items_count, ' items.')
        END;
	END;
$$
LANGUAGE plpgsql;



CREATE PROCEDURE udp_update_loyalty_status(min_orders INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE customers
    SET
        loyalty_card =
            CASE
                WHEN
                    min_orders <= (SELECT
                                       COUNT(*)
                                   FROM orders
                                   WHERE customer_id = customers.id)
                THEN TRUE
                ELSE loyalty_card
            END;
END; $$;
