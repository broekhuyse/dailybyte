DROP DATABASE IF EXISTS cs4471;
CREATE DATABASE cs4471;
USE cs4471;

CREATE TABLE user (
	id INT AUTO_INCREMENT PRIMARY KEY,
	email VARCHAR(255) NOT NULL UNIQUE,
	password VARCHAR(255) NOT NULL,
	token VARCHAR(255) UNIQUE
);

CREATE TABLE service (
	service_id VARCHAR(20) PRIMARY KEY
);

CREATE TABLE subscription (
	user_id INT NOT NULL,
	service_id VARCHAR(20) NOT NULL,
	FOREIGN KEY (user_id) REFERENCES user(id),
	FOREIGN KEY (service_id) REFERENCES service(service_id)
);

CREATE TABLE news (
	newsid INT AUTO_INCREMENT PRIMARY KEY, 
	category VARCHAR(20) NOT NULL,
	title VARCHAR(550) NOT NULL UNIQUE, 
	url VARCHAR(500) NOT NULL, 
	description VARCHAR(500) NOT NULL, 
	country VARCHAR(50) NOT NULL
);
CREATE TABLE covid(
	cid INT AUTO_INCREMENT PRIMARY KEY,
	active_case INT,
	cases INT,
	cumulative_cases INT NOT NULL,
	cumulative_vaccine INT NOT NULL,
	cumulative_death INT NOT NULL,
	death INT, 
	date DATE NOT NULL,
	province VARCHAR(40) NOT NULL
);

INSERT INTO service (service_id) VALUES ("news");
INSERT INTO service (service_id) VALUES ("covid");
INSERT INTO service (service_id) VALUES ("weather");
INSERT INTO service (service_id) VALUES ("stock");