-- lab6

-- проекції
CREATE VIEW orders2 
AS SELECT DISTINCT order_id, order_date, order_comment, service_id
FROM orders;
SELECT * FROM orders2;  	

CREATE VIEW service2 
AS SELECT DISTINCT service_id, service_name, service_price
FROM service;
SELECT * FROM service2;  	

-- селект з умовою
SELECT *  FROM service2
WHERE service_price > 500 AND service_price <= 2200;

-- натуральне зєднання  
SELECT service2.service_id, service2.service_name, service2.service_price,
orders2.order_id, orders2.order_date, orders2.service_id
FROM service2, orders2
WHERE service2.service_id = orders2.service_id 
-- AND service2.service_price >= 300;
