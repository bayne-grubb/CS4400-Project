DROP DATABASE IF EXISTS team13;
CREATE DATABASE team13;
USE team13;
DROP TABLE IF EXISTS User;	 	 	
CREATE TABLE User
(
username VARCHAR(50) NOT NULL UNIQUE,
firstname VARCHAR(50) NOT NULL,
lastname VARCHAR(50) NOT NULL,
password VARCHAR(50) NOT NULL,
status VARCHAR(50) NOT NULL DEFAULT 'Pending',
PRIMARY KEY (username)
);
DROP TABLE IF EXISTS Customer;	
CREATE TABLE Customer
(
username VARCHAR(50) NOT NULL,
PRIMARY KEY (username),
FOREIGN KEY (username) REFERENCES User(username)
);
DROP TABLE IF EXISTS Employee;	
CREATE TABLE Employee
(
username VARCHAR(50) NOT NULL,
PRIMARY KEY (username),
FOREIGN KEY (username) REFERENCES User(username)
);
DROP TABLE IF EXISTS Admin;	
CREATE TABLE Admin
(
username VARCHAR(50) NOT NULL,
PRIMARY KEY (username),
FOREIGN KEY (username) REFERENCES Employee(username)
)
;
DROP TABLE IF EXISTS Company;	
CREATE TABLE Company
(
comName VARCHAR(50) NOT NULL UNIQUE,
PRIMARY KEY (comName)
);
DROP TABLE IF EXISTS Manager;	
CREATE TABLE Manager
(
username VARCHAR(50) NOT NULL UNIQUE,
manStreet VARCHAR(50),
manCity VARCHAR(50),
manState CHAR(3),
manZipcode CHAR(5),
comName VARCHAR(50),
PRIMARY KEY (username), #NEED TO CHANGE BC THIS IS WEAK ENTITY???
FOREIGN KEY (username) REFERENCES Employee(username),
FOREIGN KEY (comName) REFERENCES Company(comName)
);

DROP TABLE IF EXISTS Theater;	
CREATE TABLE Theater
(
thName VARCHAR(50) NOT NULL,
comName VARCHAR(50) NOT NULL,
thCapacity INT NOT NULL,
thStreet VARCHAR(50) NOT NULL,
thCity VARCHAR(50) NOT NULL,
thState VARCHAR(3) NOT NULL,
thZipcode CHAR(5) NOT NULL,
thManagerUsername VARCHAR(50) NOT NULL,
PRIMARY KEY (thName, comName),
FOREIGN KEY (comName) REFERENCES Company(comName),
FOREIGN KEY (thManagerUsername) REFERENCES Manager(username)
);
DROP TABLE IF EXISTS CustomerCreditCard;	
CREATE TABLE CustomerCreditCard
(
username VARCHAR(50),
creditCardNum VARCHAR(16) NOT NULL UNIQUE CHECK(char_length(creditCardNum) = 16),
PRIMARY KEY (creditCardNum),
FOREIGN KEY (username) REFERENCES User(username)
);
DROP TABLE IF EXISTS Movie;	
CREATE TABLE Movie
(
movName VARCHAR(50) NOT NULL,
movReleaseDate DATE NOT NULL,
movDuration INT NOT NULL,
PRIMARY KEY (movName, movReleaseDate)
);
DROP TABLE IF EXISTS MoviePlay;	
CREATE TABLE MoviePlay
(
movName VARCHAR(50) NOT NULL,
movReleaseDate DATE NOT NULL,
movPlayDate DATE NOT NULL,
thName VARCHAR(50) NOT NULL,
comName VARCHAR(50) NOT NULL,
PRIMARY KEY (movName, movReleaseDate, movPlayDate, thName, comName),
FOREIGN KEY (thName, comName) REFERENCES Theater(thName, comName),
FOREIGN KEY (movName, movReleaseDate) REFERENCES Movie(movName, movReleaseDate)
);
DROP TABLE IF EXISTS UserVisitTheater;	
CREATE TABLE UserVisitTheater 
(
username VARCHAR(50) NOT NULL,
thName VARCHAR(50) NOT NULL,
comName VARCHAR(50) NOT NULL,
visitDate DATE NOT NULL,
VisitID INT NOT NULL AUTO_INCREMENT,
PRIMARY KEY (VisitID),
FOREIGN KEY (thName, comName) REFERENCES Theater(thName, comName),
FOREIGN KEY (username) REFERENCES User(username)
);
DROP TABLE IF EXISTS CustomerViewMovie;	
CREATE TABLE CustomerViewMovie
(
movName VARCHAR(50) NOT NULL,
movReleaseDate DATE NOT NULL,
movPlayDate DATE NOT NULL,
thName VARCHAR(50) NOT NULL,
comName VARCHAR(50) NOT NULL,
creditCardNum VARCHAR(16) NOT NULL CHECK(char_length(creditCardNum) = 16),
PRIMARY KEY (movName, movReleaseDate, movPlayDate, thName, comName, creditCardNum),
FOREIGN KEY (creditCardNum) REFERENCES CustomerCreditCard(creditCardNum),
FOREIGN KEY (movName,movReleaseDate, movPlayDate, thName, comName) REFERENCES MoviePlay(movName,movReleaseDate, movPlayDate, thName, comName)
);


LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES ('calcultron','Dwight','Schrute','333333333','Approved'),('calcultron2','Jim','Halpert','444444444','Approved'),('calcwizard','Issac','Newton','222222222','Approved'),('clarinetbeast','Squidward','Tentacles','999999999','Declined'),('cool_class4400','A. TA','Washere','333333333','Approved'),('DNAhelix','Rosalind','Franklin','777777777','Approved'),('does2Much','Carl','Gauss','1212121212','Approved'),('eeqmcsquare','Albert','Einstein','111111110','Approved'),('entropyRox','Claude','Shannon','999999999','Approved'),('fatherAI','Alan','Turing','222222222','Approved'),('fullMetal','Edward','Elric','111111100','Approved'),('gdanger','Gary','Danger','555555555','Declined'),('georgep','George P.','Burdell','111111111','Approved'),('ghcghc','Grace','Hopper','666666666','Approved'),('ilikemoney$$','Eugene','Krabs','111111110','Approved'),('imbatman','Bruce','Wayne','666666666','Approved'),('imready','Spongebob','Squarepants','777777777','Approved'),('isthisthekrustykrab','Patrick','Star','888888888','Approved'),('manager1','manager','One','1122112211','Approved'),('manager2','manager','Two','3131313131','Approved'),('manager3','Three','Three','8787878787','Approved'),('manager4','Four','Four','5755555555','Approved'),('notFullMetal','Alphonse','Elric','111111100','Approved'),('programerAAL','Ada','Lovelace','3131313131','Approved'),('radioactivePoRa','Marie','Curie','1313131313','Approved'),('RitzLover28','Abby','Normal','444444444','Approved'),('smith_j','John','Smith','333333333','Pending'),('texasStarKarate','Sandy','Cheeks','111111110','Declined'),('thePiGuy3.14','Archimedes','Syracuse','1111111111','Approved'),('theScienceGuy','Bill','Nye','999999999','Approved');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

LOCK TABLES `Employee` WRITE;
/*!40000 ALTER TABLE `Employee` DISABLE KEYS */;
INSERT INTO `Employee` VALUES ('calcultron'),('cool_class4400'),('entropyRox'),('fatherAI'),('georgep'),('ghcghc'),('imbatman'),('manager1'),('manager2'),('manager3'),('manager4'),('radioactivePoRa');
/*!40000 ALTER TABLE `Employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `admin`
--

LOCK TABLES `Admin` WRITE;
/*!40000 ALTER TABLE `Admin` DISABLE KEYS */;
INSERT INTO `Admin` VALUES ('cool_class4400');
/*!40000 ALTER TABLE `Admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `company`
--

LOCK TABLES `Company` WRITE;
/*!40000 ALTER TABLE `Company` DISABLE KEYS */;
INSERT INTO `Company` VALUES ('4400 Theater Company'),('AI theater company'),('Awesome theater company'),('EZ theater company');
/*!40000 ALTER TABLE `Company` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `customer`
--

LOCK TABLES `Customer` WRITE;
/*!40000 ALTER TABLE `Customer` DISABLE KEYS */;
INSERT INTO `Customer` VALUES ('georgep'),('calcultron'),('entropyRox'),('cool_class4400'),('calcultron2'),('calcwizard'),('clarinetbeast'),('DNAhelix'),('does2Much'),('eeqmcsquare'),('fullMetal'),('ilikemoney$$'),('imready'),('isthisthekrustykrab'),('notFullMetal'),('programerAAL'),('RitzLover28'),('thePiGuy3.14'),('theScienceGuy');
/*!40000 ALTER TABLE `Customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `customercreditcard`
--

LOCK TABLES `CustomerCreditCard` WRITE;
/*!40000 ALTER TABLE `CustomerCreditCard` DISABLE KEYS */;
INSERT INTO `CustomerCreditCard` VALUES ('calcultron','1111111111000000'),('calcultron2','1111111100000000'),('calcultron2','1111111110000000'),('calcwizard','1111111111100000'),('cool_class4400','2222222222000000'),('DNAhelix','2220000000000000'),('does2Much','2222222200000000'),('eeqmcsquare','2222222222222200'),('entropyRox','2222222222200000'),('entropyRox','2222222222220000'),('fullMetal','1100000000000000'),('georgep','1111111111110000'),('georgep','1111111111111000'),('georgep','1111111111111100'),('georgep','1111111111111110'),('georgep','1111111111111111'),('ilikemoney$$', '2222222222222222'), ('ilikemoney$$','2222222222222220'),('ilikemoney$$','9000000000000000'),('imready','1111110000000000'),('isthisthekrustykrab','1110000000000000'),('isthisthekrustykrab','1111000000000000'),('isthisthekrustykrab','1111100000000000'),('notFullMetal','1000000000000000'),('programerAAL','2222222000000000'),('RitzLover28','3333333333333300'),('thePiGuy3.14','2222222220000000'),('theScienceGuy','2222222222222000');
/*!40000 ALTER TABLE `CustomerCreditCard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `manager`
--

LOCK TABLES `Manager` WRITE;
/*!40000 ALTER TABLE `Manager` DISABLE KEYS */;
INSERT INTO `Manager` VALUES ('calcultron','123 Peachtree St','Atlanta','GA','30308','EZ theater company'),('entropyRox','200 Cool Place','San Francisco','CA','94016','4400 Theater Company'),('fatherAI','456 Main St','New York','NY','10001','EZ theater company'),('georgep','10 Pearl Dr','Seattle','WA','98105','4400 Theater Company'),('ghcghc','100 Pi St','Pallet Town','KS','31415','AI theater company'),('imbatman','800 Color Dr','Austin','TX','78653','Awesome theater company'),('manager1','123 Ferst Drive','Atlanta','GA','30332','4400 Theater Company'),('manager2','456 Ferst Drive','Atlanta','GA','30332','AI theater company'),('manager3','789 Ferst Drive','Atlanta','GA','30332','4400 Theater Company'),('manager4','000 Ferst Drive','Atlanta','GA','30332','4400 Theater Company'),('radioactivePoRa','100 Blu St','Sunnyvale','CA','94088','4400 Theater Company');
/*!40000 ALTER TABLE `Manager` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `movie`
--

LOCK TABLES `Movie` WRITE;
/*!40000 ALTER TABLE `Movie` DISABLE KEYS */;
INSERT INTO `Movie` VALUES ('4400 The movie','2019-08-12',130),('Avengers: Endgame','2019-04-26',181),('Calculus Returns: A ML Story','2019-09-19',314),('George P Burdell\'s Life Story','1927-08-12',100),('Georgia Tech The movie','1985-08-13',100),('How to Train Your Dragon','2010-03-21',98),('Spaceballs','1987-06-24',96),('Spider-Man: Into the Spider-Verse','2018-12-01',117),('The First Pokemon movie','1998-07-19',75),('The King\'s Speech','2010-11-26',119);
/*!40000 ALTER TABLE `Movie` ENABLE KEYS */;
UNLOCK TABLES;


--
-- Dumping data for table `theater`
--

LOCK TABLES `Theater` WRITE;
/*!40000 ALTER TABLE `Theater` DISABLE KEYS */;
INSERT INTO `Theater` VALUES ('ABC theater','Awesome theater company',5,'880 Color Dr','Austin','TX','73301','imbatman'),('Cinema Star','4400 Theater Company',4,'100 Cool Place','San Francisco','CA','94016','entropyRox'),('Jonathan\'s movies','4400 Theater Company',2,'67 Pearl Dr','Seattle','WA','98101','georgep'),('Main movies','EZ theater company',3,'123 Main St','New York','NY','10001','fatherAI'),('ML movies','AI theater company',3,'314 Pi St','Pallet Town','KS','31415','ghcghc'),('Star movies','4400 Theater Company',5,'4400 Rocks Ave','Boulder','CA','80301','radioactivePoRa'),('Star movies','EZ theater company',2,'745 GT St','Atlanta','GA','30332','calcultron');
/*!40000 ALTER TABLE `Theater` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `movieplay`
--

LOCK TABLES `MoviePlay` WRITE;
/*!40000 ALTER TABLE `MoviePlay` DISABLE KEYS */;
INSERT INTO `MoviePlay` VALUES ('4400 The movie','2019-08-12','2019-10-12','ABC theater','Awesome theater company'),('Georgia Tech The movie','1985-08-13','1985-08-13','ABC theater','Awesome theater company'),('The First Pokemon movie','1998-07-19','2018-07-19','ABC theater','Awesome theater company'),('4400 The movie','2019-08-12','2019-09-12','Cinema Star','4400 Theater Company'),('George P Burdell\'s Life Story','1927-08-12','2010-05-20','Cinema Star','4400 Theater Company'),('Georgia Tech The movie','1985-08-13','2019-09-30','Cinema Star','4400 Theater Company'),('How to Train Your Dragon','2010-03-21','2010-04-02','Cinema Star','4400 Theater Company'),('Spaceballs','1987-06-24','2000-02-02','Cinema Star','4400 Theater Company'),('The King\'s Speech','2010-11-26','2019-12-20','Cinema Star','4400 Theater Company'),('George P Burdell\'s Life Story','1927-08-12','2019-07-14','Main movies','EZ theater company'),('George P Burdell\'s Life Story','1927-08-12','2019-10-22','Main movies','EZ theater company'),('How to Train Your Dragon','2010-03-21','2010-03-22','Main movies','EZ theater company'),('How to Train Your Dragon','2010-03-21','2010-03-23','Main movies','EZ theater company'),('Spaceballs','1987-06-24','1999-06-24','Main movies','EZ theater company'),('The King\'s Speech','2010-11-26','2019-12-20','Main movies','EZ theater company'),('Calculus Returns: A ML Story','2019-09-19','2019-10-10','ML movies','AI theater company'),('Calculus Returns: A ML Story','2019-09-19','2019-12-30','ML movies','AI theater company'),('Spaceballs','1987-06-24','2010-04-02','ML movies','AI theater company'),('Spaceballs','1987-06-24','2023-01-23','ML movies','AI theater company'),('Spider-Man: Into the Spider-Verse','2018-12-01','2019-09-30','ML movies','AI theater company'),('4400 The movie','2019-08-12','2019-08-12','Star movies','EZ theater company'),('How to Train Your Dragon','2010-03-21','2010-03-25','Star movies','EZ theater company');
/*!40000 ALTER TABLE `MoviePlay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `customerviewmovie`
--

LOCK TABLES `CustomerViewMovie` WRITE;
/*!40000 ALTER TABLE `CustomerViewMovie` DISABLE KEYS */;
INSERT INTO `CustomerViewMovie` VALUES ('How to Train Your Dragon','2010-03-21','2010-03-25','Star movies','EZ theater company','1111111111111100'),('How to Train Your Dragon','2010-03-21','2010-03-22','Main movies','EZ theater company','1111111111111111'),('How to Train Your Dragon','2010-03-21','2010-03-23','Main movies','EZ theater company','1111111111111111'),('How to Train Your Dragon','2010-03-21','2010-04-02','Cinema Star','4400 Theater Company','1111111111111111');
/*!40000 ALTER TABLE `CustomerViewMovie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `uservisittheater`
--

LOCK TABLES `UserVisitTheater` WRITE;
/*!40000 ALTER TABLE `UserVisitTheater` DISABLE KEYS */;
INSERT INTO `UserVisitTheater` VALUES ('georgep','Main movies','EZ theater company','2010-03-22',1),('calcwizard','Main movies','EZ theater company','2010-03-22',2),('calcwizard','Star movies','EZ theater company','2010-03-25',3),('imready','Star movies','EZ theater company','2010-03-25',4),('calcwizard','ML movies','AI theater company','2010-03-20',5);
/*!40000 ALTER TABLE `UserVisitTheater` ENABLE KEYS */;
UNLOCK TABLES;

DROP PROCEDURE IF EXISTS user_login;
DELIMITER $$
CREATE PROCEDURE `user_login`(IN i_username VARCHAR(50), IN i_password VARCHAR(50))
BEGIN
	DROP TABLE IF EXISTS UserLogin;
    CREATE TABLE UserLogin
		SELECT username, status, CASE WHEN EXISTS(SELECT username from Customer where i_username = Customer.username) THEN 1 ELSE 0 END AS isCustomer,
			CASE WHEN EXISTS(SELECT username from Admin WHERE i_username = Admin.username) THEN 1 ELSE 0 END AS isAdmin,
            CASE WHEN EXISTS(SELECT username from Manager WHERE i_username = Manager.username) THEN 1 ELSE 0 END AS isManager
		FROM User
        WHERE username = i_username and password = i_password;
END
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS customer_only_register;
DELIMITER $$
CREATE PROCEDURE `customer_only_register`(IN i_username VARCHAR(50), IN i_password VARCHAR(50), IN i_firstname VARCHAR(50), IN i_lastname VARCHAR(50))
BEGIN
    INSERT INTO User (username, password, firstname, lastname, status) VALUES (i_username, MD5(i_password), i_firstname, i_lastname, "Pending");
    INSERT INTO Customer (username) VALUES (i_username);
END
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS customer_add_creditcard;
DELIMITER $$ 
CREATE PROCEDURE `customer_add_creditcard`(IN i_username VARCHAR(50), IN i_creditCardNum CHAR(16))
BEGIN 
    set @num = (select count(creditCardNum) from CustomerCreditCard left join User using(username) where username=i_username);
	IF @num < 5 and char_length(i_creditCardNum) = 16 THEN 
		INSERT INTO CustomerCreditCard (username, creditCardNum) VALUES (i_username, i_creditCardNum);
    END IF;
END 
$$
DELIMITER ; 

DROP PROCEDURE IF EXISTS manager_only_register;
DELIMITER $$
CREATE PROCEDURE `manager_only_register`(IN i_username VARCHAR(50), IN i_password VARCHAR(50), IN i_firstname VARCHAR(50), IN i_lastname VARCHAR(50), i_comName VARCHAR(50),
    i_empStreet VARCHAR(50), i_empCity VARCHAR(50), i_empState VARCHAR(50), i_empZipcode VARCHAR(50))
BEGIN    
    INSERT INTO User (username, password, firstname, lastname, status) VALUES (i_username, MD5(i_password), i_firstname, i_lastname, "Pending");
	  INSERT INTO Employee (username) VALUES (i_username);
    INSERT INTO Manager (username, manStreet, manCity, manState, manZipcode, comName) 
		VALUES (i_username, i_empStreet, i_empCity, i_empState, i_empZipcode, i_comName);
END
$$
DELIMITER ;


DROP PROCEDURE IF EXISTS manager_customer_register;
DELIMITER $$
CREATE PROCEDURE `manager_customer_register`(IN i_username VARCHAR(50), IN i_password VARCHAR(50), IN i_firstname VARCHAR(50), IN i_lastname VARCHAR(50), i_comName VARCHAR(50),
    i_empStreet VARCHAR(50), i_empCity VARCHAR(50), i_empState VARCHAR(50), i_empZipcode VARCHAR(50))
BEGIN    
    INSERT INTO User (username, password, firstname, lastname, status) VALUES (i_username, MD5(i_password), i_firstname, i_lastname, "Pending");
	INSERT INTO Employee (username) VALUES (i_username);
    INSERT INTO Manager (username, comName, manStreet, manCity, manState, manZipcode)
	VALUES (i_username, i_comName, i_empStreet, i_empCity, i_empState, i_empZipcode);
    INSERT INTO Customer (username) VALUES (i_username);
END
$$
DELIMITER ;


DROP PROCEDURE IF EXISTS manager_customer_add_creditcard;
DELIMITER $$ 
CREATE PROCEDURE `manager_customer_add_creditcard`(IN i_username VARCHAR(50), IN i_creditCardNum CHAR(16))
BEGIN 
	set @num = (select count(creditCardNum) from CustomerCreditCard left join User using(username) where username=i_username);
	IF @num < 5 and char_length(i_creditCardNum) = 16 THEN 
		INSERT INTO CustomerCreditCard (username, creditCardNum) VALUES (i_username, i_creditCardNum);
	END IF;
END 
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS user_register;
DELIMITER $$
CREATE PROCEDURE `user_register`(IN i_username VARCHAR(50), IN i_password VARCHAR(50), IN i_firstname VARCHAR(50), IN i_lastname VARCHAR(50))
BEGIN
		INSERT INTO User (username, password, firstname, lastname, status) VALUES (i_username, MD5(i_password), i_firstname, i_lastname, "Pending");
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS user_filter_th;
DELIMITER $$
CREATE PROCEDURE `user_filter_th`(IN i_thName VARCHAR(50), IN i_comName VARCHAR(50), IN i_city VARCHAR(50), IN i_state VARCHAR(3))
BEGIN
    DROP TABLE IF EXISTS UserFilterTh;
    CREATE TABLE UserFilterTh
	SELECT thName, thStreet, thCity, thState, thZipcode, comName 
    FROM Theater
    WHERE 
		(thName = i_thName OR i_thName = "ALL" OR i_thName = "") AND
        (comName = i_comName OR i_comName = "ALL" or i_comName = "") AND
        (thCity = i_city OR i_city = "" OR i_city = "") AND
        (thState = i_state OR i_state = "ALL" or i_state = "");
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS user_visit_th;
DELIMITER $$
CREATE PROCEDURE `user_visit_th`(IN i_thName VARCHAR(50), IN i_comName VARCHAR(50), IN i_visitDate DATE, IN i_username VARCHAR(50))
BEGIN
    INSERT INTO UserVisitTheater (thName, comName, visitDate, username)
    VALUES (i_thName, i_comName, i_visitDate, i_username);
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS user_filter_visitHistory;
DELIMITER $$
CREATE PROCEDURE `user_filter_visitHistory`(IN i_username VARCHAR(50), IN i_minVisitDate DATE, IN i_maxVisitDate DATE)
BEGIN
    DROP TABLE IF EXISTS UserVisitHistory;
    CREATE TABLE UserVisitHistory
	SELECT thName, thStreet, thCity, thState, thZipcode, comName, visitDate
    FROM UserVisitTheater
		NATURAL JOIN
        Theater
	WHERE
		(username = i_username) AND
        (i_minVisitDate IS NULL OR visitDate >= i_minVisitDate) AND
        (i_maxVisitDate IS NULL OR visitDate <= i_maxVisitDate);
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS admin_approve_user;
DELIMITER $$
CREATE PROCEDURE `admin_approve_user` (IN i_username VARCHAR(50))
BEGIN
	UPDATE User SET status = 'Approved' WHERE username = i_username;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS admin_decline_user;
DELIMITER $$
CREATE PROCEDURE `admin_decline_user` (IN i_username VARCHAR(50))
BEGIN
	UPDATE User SET status = 'Declined' WHERE username = i_username AND status <> "Approved";
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS admin_create_theater;
DELIMITER $$
CREATE PROCEDURE `admin_create_theater` (IN i_thName VARCHAR(50), IN i_comName VARCHAR(50), IN i_thStreet VARCHAR(50), IN i_thCity VARCHAR(50), IN i_thState CHAR(2), 
IN i_thZipcode CHAR(5), IN i_capacity INT, IN i_managerUsername VARCHAR(50))
BEGIN
	IF i_managerUsername in (SELECT username FROM Manager WHERE Manager.comName = i_comName) THEN
		INSERT INTO Theater (thName, comName, thCapacity, thStreet, thCity, thState, thZipcode, thManagerUsername)
		VALUES (i_thName, i_comName, i_capacity, i_thStreet, i_thCity, i_thState, i_thZipcode, i_managerUsername);
	END IF;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS admin_view_comDetail_th;
DELIMITER $$
CREATE PROCEDURE `admin_view_comDetail_th`(IN i_comName VARCHAR(50))
BEGIN
    DROP TABLE IF EXISTS AdComDetailTh;
    CREATE TABLE AdComDetailTh
	SELECT thName, thManagerUsername, thCity, thState, thCapacity 
    FROM Theater
		NATURAL JOIN
        Company
    WHERE 
		(comName = i_comName OR i_comName = "ALL");
END
$$
DELIMITER 

DROP PROCEDURE IF EXISTS admin_view_comDetail_emp;
DELIMITER $$
CREATE PROCEDURE `admin_view_comDetail_emp`(IN i_comName VARCHAR(50))
BEGIN
    DROP TABLE IF EXISTS AdComDetailEmp;
    CREATE TABLE AdComDetailEmp
	SELECT firstname as empFirstname, lastname as empLastname
    FROM User JOIN Manager USING(username)
    WHERE comName = i_comName OR i_comName = "" OR i_comName = "ALL";
END
$$
DELIMITER ;



DROP PROCEDURE IF EXISTS admin_create_mov;
DELIMITER $$
CREATE PROCEDURE `admin_create_mov`(IN i_movName VARCHAR(50), i_movDuration INT, i_movReleaseDate DATE)
BEGIN
		INSERT INTO Movie (movName, movDuration, movReleaseDate) VALUES (i_movName, i_movDuration, i_movReleaseDate);
END
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS admin_filter_company;
DELIMITER $$
CREATE PROCEDURE `admin_filter_company`(IN i_comName VARCHAR(50), IN i_minCity INT, IN i_maxCity INT, IN i_minTheater INT, IN i_maxTheater INT, IN i_minEmployee INT, IN i_maxEmployee INT, IN i_sortBy VARCHAR(20), IN i_sortDirection VARCHAR(4))
BEGIN
    DROP TABLE IF EXISTS AdFilterCom;
    CREATE TABLE AdFilterCom
	SELECT comName, COUNT(DISTINCT thCity, thState) as numCityCover,  COUNT(DISTINCT(thName)) as numTheater, COUNT(DISTINCT(username)) as numEmployee
	FROM Manager JOIN Company USING(comName)
	LEFT JOIN Theater USING(comName)
	WHERE i_comName = "" OR i_comName = "ALL" OR i_comName = comName
	GROUP BY comName
	HAVING (numCityCover >= i_minCity or i_minCity is null) 
    AND (numCityCover<=i_maxCity or i_maxCity is null) AND 
    (numTheater >= i_minTheater or i_minTheater is null) AND 
    (numTheater <= i_maxTheater or i_maxTheater is null) AND 
    (numEmployee >= i_minEmployee or i_minEmployee is null) AND 
    (numEmployee <= i_maxEmployee or i_maxEmployee is null)
	ORDER BY 
		(CASE
			WHEN i_sortBy = "comName" AND i_sortDirection = "ASC" THEN comName
			WHEN i_sortBy = "numCityCover" AND i_sortDirection = "ASC" THEN COUNT(DISTINCT thCity, thState)
			WHEN i_sortBy = "numTheater" AND i_sortDirection = "ASC" THEN COUNT(DISTINCT(thName))
			WHEN i_sortBy = "numEmployee" AND i_sortDirection = "ASC" THEN COUNT(DISTINCT(username))
		END) ASC,
		(CASE 
			WHEN i_sortBy = "comName" THEN comName
			WHEN i_sortBy = "numCityCover" THEN COUNT(DISTINCT thCity, thState)
			WHEN i_sortBy = "numTheater" THEN COUNT(DISTINCT(thName))
			WHEN i_sortBy = "numEmployee" THEN COUNT(DISTINCT(username))
			ELSE comName
		END) DESC;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS admin_filter_user;
DELIMITER $$
CREATE PROCEDURE `admin_filter_user`(IN i_username VARCHAR(50), IN i_status VARCHAR(50), IN i_sortBy VARCHAR(20), IN i_sortDirection VARCHAR(4))
BEGIN
    DROP TABLE IF EXISTS AdFilterUser;
    CREATE TABLE AdFilterUser
	SELECT username, COUNT(creditcardNum) AS creditCardCount,
	CASE 
		WHEN EXISTS(SELECT username from Manager where User.username = Manager.username) AND EXISTS(SELECT username from Customer where User.username = Customer.username) then "CustomerManager"
        WHEN EXISTS(SELECT username from Admin where User.username = Admin.username) AND EXISTS(SELECT username from Customer where User.username = Customer.username) then "CustomerAdmin"
        WHEN EXISTS(SELECT username from Customer where User.username = Customer.username) then "Customer"
        WHEN EXISTS(SELECT username from Manager where User.username = Manager.username) then "Manager"
        WHEN EXISTS(SELECT username from Admin where User.username = Admin.username) then "Admin"
        ELSE "User"
	END AS userType, status
	FROM User LEFT JOIN CustomerCreditCard USING(username)
	WHERE (i_username = "" OR i_username = username) AND (i_status = "ALL" or i_status = status)
	GROUP BY username
	ORDER BY 
		(CASE
			WHEN i_sortBy = "username" AND i_sortDirection = "ASC" THEN username
			WHEN i_sortBy = "creditCardCount" AND i_sortDirection = "ASC" THEN COUNT(creditCardNum)
			WHEN i_sortBy = "userType" AND i_sortDirection = "ASC" THEN  userType
			WHEN i_sortBy = "status" AND i_sortDirection = "ASC" THEN status
			ELSE username
		END) ASC,
		(CASE 
			WHEN i_sortBy = "username" THEN username
			WHEN i_sortBy = "creditCardCount" THEN COUNT(creditCardNum)
			WHEN i_sortBy = "userType" THEN  userType
			WHEN i_sortBy = "status" THEN status
			ELSE username
		END) DESC;
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS manager_filter_th;
DELIMITER $$
CREATE PROCEDURE `manager_filter_th`(IN i_manUsername VARCHAR(50), IN i_movName VARCHAR(50), IN i_minMovDuration INT, IN i_maxMovDuration INT, IN i_minMovReleaseDate DATE, IN i_maxMovReleaseDate DATE, IN i_minMovPlayDate DATE, IN i_maxMovPlayDate DATE, i_includeNotPlayed BOOLEAN)
BEGIN
    DROP TABLE IF EXISTS ManFilterTh;
    CREATE TABLE ManFilterTh
	SELECT Movie.movName, Movie.movDuration, Movie.movReleaseDate, MoviePlay.movPlayDate
	FROM Manager JOIN Theater ON Manager.username = Theater.thManagerUsername 
    JOIN Movie 
    LEFT JOIN MoviePlay ON MoviePlay.thName = Theater.thName AND MoviePlay.comName = Theater.comName AND Movie.movName = MoviePlay.movName AND Movie.movReleaseDate = MoviePlay.movReleaseDate
	WHERE Manager.username = i_manUsername or i_manUserName = 'ALL'
    AND Movie.movName = i_movName or i_movName = '' or i_movName = 'ALL'
    AND (movDuration >= i_minMovDuration or i_minMovDuration is null AND movDuration <= i_maxMovDuration or i_maxMovDuration is null) 
    AND (Movie.movReleaseDate >= i_minMovReleaseDate or i_minMovReleaseDate is null AND Movie.movReleaseDate <= i_maxMovReleaseDate or i_maxMovReleaseDate is null) 
    AND (movPlayDate IS NULL OR (movPlayDate >= i_minMovPlayDate or i_minMovPlayDate is null AND movPlayDate <= i_maxMovPlayDate or i_maxMovPlayDate is null)) 
    AND (CASE
			WHEN i_includeNotPlayed THEN TRUE 
            ELSE (movPlayDate IS NOT NULL)
		END);
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS manager_schedule_mov;
DELIMITER $$
CREATE PROCEDURE `manager_schedule_mov`(IN i_manUsername VARCHAR(50), IN i_movName VARCHAR(50), IN i_movReleaseDate DATE, IN i_movPlayDate DATE)
BEGIN
	INSERT INTO MoviePlay (thName, comName, movName, movReleaseDate, movPlayDate)
		SELECT thName, Theater.comName, i_movName, i_movReleaseDate, i_movPlayDate
		FROM Manager JOIN Theater ON Manager.username = Theater.thManagerUsername
		WHERE username = i_manUsername AND i_movPlayDate >= i_movReleaseDate;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS customer_filter_mov;
DELIMITER $$
CREATE PROCEDURE `customer_filter_mov`(IN i_movName VARCHAR(50), IN i_comName VARCHAR(50), IN i_city VARCHAR(50), IN i_state VARCHAR(50), IN i_minMovPlayDate DATE, IN i_maxMovPlayDate DATE)
BEGIN
    DROP TABLE IF EXISTS CosFilterMovie;
    CREATE TABLE CosFilterMovie
	SELECT movName, MoviePlay.thName, thStreet, thCity, thState, thZipcode, Theater.comName, movPlayDate, movReleaseDate
	FROM MoviePlay join Theater on MoviePlay.thName = Theater.thName AND MoviePlay.comName = Theater.comName
	WHERE (i_movName = movName or i_movName = "" or i_movName = "ALL") AND (i_comName = Theater.comName or i_comName = "ALL" or i_comName = "") AND (i_city = thCity OR i_city = "") AND (i_state = thState or i_state = "") AND (i_minMovPlayDate is null or movPlayDate >= i_minMovPlayDate ) AND (i_maxMovPlayDate is null or movPlayDate <= i_maxMovPlayDate);
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS customer_view_mov;
DELIMITER $$
CREATE PROCEDURE `customer_view_mov`(IN i_creditCardNum CHAR(16), i_movName VARCHAR(50), i_movReleaseDate DATE, i_thName VARCHAR(50), i_comName VARCHAR(50), i_movPlayDate VARCHAR(50))
BEGIN
		INSERT INTO CustomerViewMovie (movName, movReleaseDate, movPlayDate, thName, comName, creditCardNum) 
		select i_movName,i_movReleaseDate,i_movPlayDate, i_thName, i_comName, i_creditCardNum
		where (select COUNT(*) from CustomerViewMovie where creditCardNum in
        (select creditCardNum from CustomerCreditCard where username = 
        (select username from CustomerCreditCard where creditCardNum = i_creditCardNum))
        AND movPlayDate = i_movPlayDate) < 3 AND char_length(i_creditCardNum) = 16;
END
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS customer_view_history;
DELIMITER $$
CREATE PROCEDURE `customer_view_history`(IN i_cusUsername VARCHAR(50))
BEGIN
    DROP TABLE IF EXISTS CosViewHistory;
    CREATE TABLE CosViewHistory
	SELECT movName, thName, comName, creditCardNum, movPlayDate 
    FROM 
        CustomerViewMovie
    WHERE 
		creditCardNum in 
        (select creditCardNum from CustomerCreditCard where username = i_cusUsername);
END
$$
DELIMITER ;
