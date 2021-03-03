USE lawcompany;
CREATE TABLE passport_data(
	passport_id INT AUTO_INCREMENT,
    passport_series VARCHAR(2) NOT NULL,
    passport_number INT NOT NULL,
    published_by VARCHAR(45) NOT NULL,
    date_of_birth DATE NOT NULL,
    PRIMARY KEY(passport_id)
);
CREATE TABLE user_of_company (
	user_id INT AUTO_INCREMENT,
    user_name VARCHAR(45) NOT NULL,
    user_surname VARCHAR(45) NOT NULL,
    user_email VARCHAR(45) UNIQUE NOT NULL,
    user_password VARCHAR(45) NOT NULL,
    PRIMARY KEY(user_id),
    passport_id INT UNIQUE NOT NULL,
    FOREIGN KEY(passport_id) REFERENCES passport_data(passport_id)
);
CREATE TABLE lawyer(
	lawyer_id INT AUTO_INCREMENT,
    lawyer_name VARCHAR(45) NOT NULL,
    lawyer_surname VARCHAR(45) NOT NULL,
    lawyer_email VARCHAR(45) UNIQUE NOT NULL,
    lawyer_phone_number INT UNIQUE NOT NULL,
    lawyer_password VARCHAR(45) NOT NULL,
    lawyer_degree VARCHAR(45) NOT NULL,
    PRIMARY KEY(lawyer_id)
);
CREATE TABLE service(
	service_id INT AUTO_INCREMENT,
    service_name VARCHAR(45) NOT NULL,
    service_description VARCHAR(100) NOT NULL,
    service_time TIME NOT NULL,
    service_price INT NOT NULL,
	PRIMARY KEY(service_id)
);
CREATE TABLE orders(
	order_id INT AUTO_INCREMENT,
    user_id INT NOT NULL,
    FOREIGN KEY(user_id) REFERENCES user_of_company(user_id),
    lawyer_id INT NOT NULL,
    FOREIGN KEY(lawyer_id) REFERENCES lawyer(lawyer_id),
    order_date DATETIME NOT NULL,
    order_comment VARCHAR(100) NOT NULL,
    PRIMARY KEY(order_id),
    service_id INT UNIQUE NOT NULL,
    FOREIGN KEY(service_id) REFERENCES service(service_id)
);
CREATE TABLE training(
	training_id INT AUTO_INCREMENT,
    training_theme VARCHAR(45) NOT NULL,
    count_of_users INT NOT NULL,
    training_duration TIME NOT NULL,
    training_date DATETIME NOT NULL,
    training_price INT NOT NULL,
    PRIMARY KEY(training_id)
);
CREATE TABLE lawyer_has_trainings(
	lawyer_id INT NOT NULL,
    training_id INT NOT NULL,
    FOREIGN KEY (lawyer_id) REFERENCES lawyer(lawyer_id), 
    FOREIGN KEY (training_id) REFERENCES training(training_id),
    UNIQUE (lawyer_id, training_id)
);
CREATE TABLE user_has_trainings(
	user_id INT NOT NULL,
    training_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES user_of_company(user_id), 
    FOREIGN KEY (training_id) REFERENCES training(training_id),
    UNIQUE (user_id, training_id)
);