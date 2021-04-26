-- lab8

-- sort by username 
SELECT user_name, user_surname FROM user_of_company
WHERE user_name LIKE '%ia'
ORDER BY user_surname ASC;

-- sort 
USE lawcompany;
SELECT user_id, lawyer_id, order_date, order_comment FROM orders
ORDER BY order_date;

-- group + order
SELECT user_of_company.user_name, user_of_company.user_surname, orders.order_date 
FROM user_of_company INNER JOIN orders 
ON user_of_company.user_id=orders.user_id
GROUP BY user_name
ORDER BY user_name;

SELECT user_of_company.user_name, user_of_company.user_surname, COUNT(orders.user_id)
FROM (orders INNER JOIN user_of_company) WHERE orders.user_id=user_of_company.user_id
GROUP BY orders.user_id;

SELECT YEAR(orders.order_date) AS year, MONTHNAME(orders.order_date) AS month,
COUNT(orders.user_id) AS count_of_users
FROM orders
GROUP BY year, month WITH ROLLUP;

SELECT service_name, service_description, service_price
FROM service
WHERE service_price < (SELECT AVG(service_price) FROM service)
ORDER BY service_price DESC;

SELECT user_of_company.user_name, user_of_company.user_surname,
	COUNT(orders.order_id) AS count_of_orders
FROM user_of_company INNER JOIN orders 
ON user_of_company.user_id=orders.user_id
WHERE YEAR(orders.order_date)=(YEAR(CURRENT_DATE))
GROUP BY orders.user_id
ORDER BY count_of_orders DESC
LIMIT 1;





