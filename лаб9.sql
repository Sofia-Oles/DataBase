-- lab9

-- кількість замовлень кожного клієнта
SELECT user_of_company.user_name, user_of_company.user_surname, COUNT(orders.user_id)
FROM (orders JOIN user_of_company) 
WHERE orders.user_id=user_of_company.user_id
GROUP BY orders.user_id;

-- Вивести кількість клієнтів кожного місяця
SELECT YEAR(orders.order_date) AS year, MONTHNAME(orders.order_date) AS month,
COUNT(orders.user_id) AS count_of_users
FROM orders
GROUP BY year, month WITH ROLLUP;

-- всі послуги в порядку спадання, вартість яких менша за середню вартість
SELECT service_name, service_description, service_price
FROM service
WHERE service_price < (SELECT AVG(service_price) FROM service)
ORDER BY service_price DESC;

-- Визначимо найактивнішого клієнта цього року
SELECT user_of_company.user_name, user_of_company.user_surname, 
	COUNT(orders.order_id) AS count_of_orders
FROM user_of_company INNER JOIN orders 
ON user_of_company.user_id=orders.user_id
WHERE YEAR(orders.order_date)=(YEAR(CURRENT_DATE))
GROUP BY orders.user_id
ORDER BY count_of_orders DESC
LIMIT 1;


select user_of_company.user_name, user_of_company.user_surname, count(user_has_trainings.training_id)
from user_of_company join user_has_trainings
where user_of_company.user_id=user_has_trainings.user_id
group by user_has_trainings.training_id;





















