use lawcompany;
CREATE FUNCTION mycms_encode (pass VARCHAR(50))
    RETURNS TINYBLOB
    RETURN AES_ENCRYPT(pass, 'key-key');

CREATE FUNCTION mycms_decode (pass TINYBLOB)
    RETURNS VARCHAR(48)
    RETURN AES_DECRYPT(UNHEX(pass), 'key-key');

SET GLOBAL log_bin_trust_function_creators = 1;

#кодування паролів таблиці user
UPDATE user_of_company SET user_password = HEX(mycms_encode(user_password));
SELECT user_surname, user_password FROM user_of_company;

#deкодування паролів таблиці user
UPDATE user_of_company SET user_password = mycms_decode(user_password);
SELECT user_surname, user_password FROM user_of_company;

#запис уже кодованого пасворду
insert into user_of_company(user_name, user_surname, user_email, user_password, passport_id)
value
('Ior', 'ovych', 'gn@gmail.com', HEX(mycms_encode('dedgern')), 13);

# функція, яка визначає всі майбутні замовлення заданого клієнта
DELIMITER //
CREATE FUNCTION future_orders ( i INT )
RETURNS INT
BEGIN
   DECLARE res INT;
   SET res = 0;
   SELECT count(order_id) into res FROM orders where user_id=i and order_date >=CURRENT_TIMESTAMP();
   RETURN res;
END; //
DELIMITER ;

SELECT future_orders (1);


-- Процедура повинна посортувати по спаданню lawyer, які найняли найбільше людських замовлень за певний проміжок, 
-- а люди зробили замовлення на певну суму
-- У процедуру потрібно передати ім’я lawyer, а також першу і другу дату. Результати обчислень будуть записуватись у таблицю Stats, 
-- яку процедура завжди очищує (командою TRUNCATE stats) і заповнює з нуля.

DELIMITER //
CREATE PROCEDURE clients_count (IN service_price integer, IN date1 DATEtime, IN date2 DATEtime)
BEGIN
 DECLARE error VARCHAR(50);
 SET error = "Entered incorrect data's";
 IF (date1 <= date2) THEN
 BEGIN
 CREATE TABLE IF NOT EXISTS Stats(lawyer_name VARCHAR(45) NOT NULL, lawyer_surname VARCHAR(45) NOT NULL, clients INT UNSIGNED);
 TRUNCATE Stats;
 INSERT INTO Stats
 SELECT lawyer.lawyer_name, lawyer.lawyer_surname, COUNT(orders.user_id) as clients
 FROM orders
 INNER JOIN lawyer ON orders.lawyer_id = lawyer.lawyer_id
 INNER JOIN service ON orders.service_id = service.service_id
 WHERE service.service_price >= service_price
 AND orders.order_date >= date1
 AND orders.order_date <= date2
 -- AND orders.user_id in
     -- (SELECT distinct user_id FROM orders)
 GROUP BY lawyer.lawyer_surname
 ORDER BY clients DESC;
 END;
 ELSE SELECT error;
 END IF;
END //
DELIMITER ;

CALL clients_count(500, '2018-01-01', '2022-01-01' );
SELECT * FROM Stats;