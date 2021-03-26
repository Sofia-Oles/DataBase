-- lab3

-- Видалення зв’язку між таблицями шляхом видалення обмеження для таблиці, 
-- a саме зв'язок між таблицями user_of_company та user_has_trainings: (m:m)
ALTER TABLE user_has_trainings
DROP FOREIGN KEY user_has_trainings_ibfk_1,
DROP INDEX user_id;
-- Перевіряємо результат за допомогою операторів:
-- SHOW INDEX FROM \ SHOW CREATE TABLE

-- delete field
ALTER TABLE training
DROP COLUMN training_price;

-- change field
ALTER TABLE training
MODIFY COLUMN training_theme varchar(100) NULL;

-- add new unique field to existed table
ALTER TABLE training
ADD COLUMN classification varchar(100) NOT NULL AFTER training_theme,
ADD CONSTRAINT UNIQUE class_version (classification);

-- при видаленні юзера видалялись всі записи
ALTER TABLE orders
DROP FOREIGN KEY orders_ibfk_1,
ADD CONSTRAINT user_id FOREIGN KEY (user_id)
REFERENCES user_of_company (user_id) ON DELETE CASCADE;


