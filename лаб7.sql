-- lab7

-- 1)Знайдемо ім’я та по-батькові клієнта з номером 
SELECT user_of_company.user_name, user_of_company.user_surname FROM user_of_company
WHERE user_of_company.user_id = 5;

-- 2)всіх користувачів за замовленням
SELECT user_of_company.user_id, user_of_company.user_name, user_of_company.user_surname,
orders.order_date, orders.service_id 
FROM user_of_company LEFT JOIN orders ON user_of_company.user_id = orders.user_id;

-- 3) Виберемо користувачів, яких обслуговував адвокат з id 1
SELECT user_of_company.user_id, user_of_company.user_name, user_of_company.user_surname, orders.order_date, orders.service_id 
FROM user_of_company 
INNER JOIN orders ON user_of_company.user_id = orders.user_id 
where orders.lawyer_id=1;

-- 4)Виведемо інформацію про сервіс, який вибрали клієнти, яких обслужили працівники з id 2 та 3.
select user_of_company.user_name, user_of_company.user_surname, orders.lawyer_id, orders.order_date, service.service_name, service.service_description
from (user_of_company
inner join orders on user_of_company.user_id=orders.user_id) 
inner join service on orders.service_id=service.service_id;
-- 5)Переглянемо інформацію про 5 останніх замовлень сервісу
-- order by orders.order_date desc limit 5;

-- 6) користувачі які не зробили замовлення
SELECT user_of_company.user_name, user_of_company.user_surname FROM
user_of_company
WHERE NOT EXISTS
(SELECT * FROM orders WHERE orders.user_id = user_of_company.user_id);
