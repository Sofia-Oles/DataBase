-- lab5

-- об'єднання 
SELECT * FROM users1  
UNION SELECT * FROM users2;

-- перетин
SELECT * FROM users2
WHERE user_id IN (SELECT user_id FROM users1); 

-- різниця
SELECT * FROM users1 
WHERE user_id NOT IN (SELECT user_id FROM users2); 

-- декартовий
SELECT * FROM users2, users1;      













