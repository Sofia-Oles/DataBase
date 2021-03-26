-- lab4

-- заповнення табл
INSERT INTO lawyer(lawyer_id, lawyer_name, lawyer_surname, lawyer_email, lawyer_phone_number, lawyer_password, lawyer_degree) 
VALUES (1, 'Andriy','Levytskiy','law@gmail.com', '0953232567', 'yourlawyer', 'LNU faculty of law'); 
SELECT * FROM lawyer;

-- групове
INSERT INTO lawyer(lawyer_name, lawyer_surname, lawyer_email, lawyer_phone_number, lawyer_password, lawyer_degree) 
VALUES ('Bogdan','Pavlyk','bodik@gmail.com', '0950908667', '1111', 'LNU faculty of law'),
('Ivan','Novozh','novozhlaw@gmail.com', '0931254888', '1novozh9', 'NULP faculty of law'),
('Nika','Zaiets','zaiets@ukr.net', '0989962289', 'kalka', 'UCU faculty of law');
SELECT * FROM lawyer;

-- з файлу
USE lawcompany;
LOAD DATA INFILE 'C:\\users.txt' INTO TABLE user_of_company;
SELECT * FROM user_of_company ;

-- апдейт значень
UPDATE passport_data SET passport_series = 'KK'  
WHERE passport_id = 4; 

-- видалення
DELETE FROM passport_data WHERE passport_id = 6;

