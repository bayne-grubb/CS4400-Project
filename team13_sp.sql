
DROP PROCEDURE IF EXISTS user_login;
DELIMITER $$
CREATE PROCEDURE `user_login`(IN i_username VARCHAR(50), IN i_password VARCHAR(50))
BEGIN
	DROP TABLE IF EXISTS UserLogin;
    CREATE TABLE UserLogin(username VARCHAR(50), status VARCHAR(50), isCustomer INT, isAdmin INT, isManager INT);
		SELECT username, status FROM user WHERE username = i_username AND password = MD5(i_password);
		SELECT COUNT(*) FROM customer WHERE username in(
		SELECT username FROM user WHERE username = i_username AND password = MD5(i_password)
		);
		SELECT COUNT(*) FROM admin WHERE username in(
		SELECT username FROM user WHERE username = i_username AND password = MD5(i_password)
		);
		SELECT COUNT(*) FROM manager WHERE username in(
		SELECT username FROM user WHERE username = i_username AND password = MD5(i_password)
		);

END
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS customer_only_register;
DELIMITER $$
CREATE PROCEDURE `customer_only_register`(IN i_username VARCHAR(50), IN i_password VARCHAR(50), IN i_firstname VARCHAR(50), IN i_lastname VARCHAR(50))
BEGIN
    INSERT INTO user (username, password, firstname, lastname) VALUES (i_username, MD5(i_password), i_firstname, i_lastname);
    INSERT INTO customer (username) VALUES (i_username);
END
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS customer_add_creditcard;
DELIMITER $$ 
CREATE PROCEDURE `customer_add_creditcard`(IN i_username VARCHAR(50), IN i_creditCardNum CHAR(16))
BEGIN 
    INSERT INTO customercreditcard (username, creditCardNum) VALUES (i_username, i_creditCardNum);
END 
$$
DELIMITER ; 

DROP PROCEDURE IF EXISTS manager_only_register;
DELIMITER $$
CREATE PROCEDURE `manager_only_register`(IN i_username VARCHAR(50), IN i_password VARCHAR(50), IN i_firstname VARCHAR(50), IN i_lastname VARCHAR(50), i_comName VARCHAR(50),
    i_empStreet VARCHAR(50), i_empCity VARCHAR(50), i_empState VARCHAR(50), i_empZipcode VARCHAR(50))
BEGIN    
    INSERT INTO user (username, password, firstname, lastname) VALUES (i_username, MD5(i_password), i_firstname, i_lastname);
    INSERT INTO manager (username, comName, empStreet, empCity, empState, empZipcode) 
		VALUES (i_username, i_comName, i_empStreet, i_empCity, i_empState, i_empZipcode);
    INSERT INTO employee (username) VALUES (i_username);
END
$$
DELIMITER ;


DROP PROCEDURE IF EXISTS manager_customer_register;
DELIMITER $$
CREATE PROCEDURE `manager_customer_register`(IN i_username VARCHAR(50), IN i_password VARCHAR(50), IN i_firstname VARCHAR(50), IN i_lastname VARCHAR(50), i_comName VARCHAR(50),
    i_empStreet VARCHAR(50), i_empCity VARCHAR(50), i_empState VARCHAR(50), i_empZipcode VARCHAR(50))
BEGIN    
    INSERT INTO user (username, password, firstname, lastname) VALUES (i_username, MD5(i_password), i_firstname, i_lastname);
    INSERT INTO manager (username, comName, empStreet, empCity, empState, empZipcode)
		VALUES (i_username, i_comName, i_empStreet, i_empCity, i_empState, i_empZipcode);
    INSERT INTO customer (username) VALUES (i_username);
    INSERT INTO employee (username) VALUES (i_username);
END
$$
DELIMITER ;


DROP PROCEDURE IF EXISTS manager_customer_add_creditcard;
DELIMITER $$ 
CREATE PROCEDURE `manager_customer_add_creditcard`(IN i_username VARCHAR(50), IN i_creditCardNum CHAR(16))
BEGIN 
    INSERT INTO customercreditcard (username, creditCardNum) VALUES (i_username, i_creditCardNum);
END 
$$
DELIMITER ;

DROP PROCEDURE IF EXISTS user_register;
DELIMITER $$
CREATE PROCEDURE `user_register`(IN i_username VARCHAR(50), IN i_password VARCHAR(50), IN i_firstname VARCHAR(50), IN i_lastname VARCHAR(50))
BEGIN
		INSERT INTO user (username, password, firstname, lastname) VALUES (i_username, MD5(i_password), i_firstname, i_lastname);
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
		(thName = i_thName OR i_thName = "ALL") AND
        (comName = i_comName OR i_comName = "ALL") AND
        (thCity = i_city OR i_city = "") AND
        (thState = i_state OR i_state = "ALL");
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
	UPDATE user SET status = 'Approved' WHERE username = i_username;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS admin_decline_user;
DELIMITER $$
CREATE PROCEDURE `admin_decline_user` (IN i_username VARCHAR(50))
BEGIN
	UPDATE user SET status = 'Declined' WHERE username = i_username;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS admin_create_theater;
DELIMITER $$
CREATE PROCEDURE `admin_create_theater` (IN i_thName VARCHAR(50), IN i_comName VARCHAR(50), IN i_thCity VARCHAR(50), IN i_thStreet VARCHAR(50), IN i_thState CHAR(2), 
IN i_thZipcode CHAR(5), IN i_capacity INT, IN i_managerUsername VARCHAR(50))
BEGIN
	INSERT INTO theater (thName, comName, capacity, thStreet, thCity, thState, thZipcode, manUsername)
    VALUES (i_thName, i_comName, i_capacity, i_thStreet, i_thCity, i_thState, i_thZipcode, i_managerUsername);
END$$
DELIMITER ;


DROP PROCEDURE IF EXISTS admin_view_comDetail_th;
DELIMITER $$
CREATE PROCEDURE `admin_view_comDetail_th`(IN i_comName VARCHAR(50))
BEGIN
    DROP TABLE IF EXISTS AdComDetailTh;
    CREATE TABLE AdComDetailTh
	SELECT thName, manusername, thCity, thState, capacity 
    FROM theater
		NATURAL JOIN
        company
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
	SELECT firstname, lastname
    FROM user
		NATURAL JOIN
        company
    WHERE 
		user.username in (select username from employee) and (company.comName = i_comName OR i_comName = "ALL");
END
$$
DELIMITER ;



DROP PROCEDURE IF EXISTS admin_create_mov;
DELIMITER $$
CREATE PROCEDURE `admin_create_mov`(IN i_movName VARCHAR(50), i_movDuration INT, i_movReleas DATE)
BEGIN
		INSERT INTO movie (name, duration, release_date) VALUES (i_movName, i_movDuration, i_movReleas);
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
	FROM manager JOIN company USING(comName)
	LEFT JOIN theater USING(comName)
	WHERE i_comName = "ALL" OR i_comName = comName
	GROUP BY comName
	HAVING (numCityCover >= i_minCity AND numCityCover<=i_maxCity) AND (numTheater >= i_minTheater AND numTheater <= i_maxTheater) AND (numEmployee >= i_minEmployee AND numEmployee <= i_maxEmployee)
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
		WHEN EXISTS(SELECT username from manager where user.username = manager.username) AND EXISTS(SELECT username from customer where user.username = customer.username) then "CustomerManager"
        WHEN EXISTS(SELECT username from admin where user.username = admin.username) AND EXISTS(SELECT username from customer where user.username = customer.username) then "AdminManager"
        WHEN EXISTS(SELECT username from customer where user.username = customer.username) then "Customer"
        WHEN EXISTS(SELECT username from manager where user.username = manager.username) then "Manager"
        WHEN EXISTS(SELECT username from admin where user.username = admin.username) then "Admin"
        ELSE "User"
	END AS userType, status
	FROM user LEFT JOIN customercreditcard USING(username)
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
	SELECT movie.movName, duration, movie.movReleaseDate, movieplay.movPlayDate
	FROM manager JOIN theater ON manager.username = theater.manusername JOIN movie LEFT JOIN movieplay ON movieplay.thName = theater.thName AND movieplay.comName = theater.comName AND movie.movName = movieplay.movName AND movie.movReleaseDate = movieplay.movReleaseDate
	WHERE i_manUsername = username AND movie.movName LIKE ("%" + i_movName + "%") AND (duration >= i_minMovDuration AND duration <= i_maxMovDuration) AND (movie.movReleaseDate >= i_minMovReleaseDate AND movie.movReleaseDate <= i_maxMovReleaseDate) AND (movPlayDate IS NULL OR (movPlayDate >= i_minMovPlayDate AND movPlayDate <= i_maxMovPlayDate)) AND (NOT i_includeNotPlayed OR movPlayDate IS NOT NULL);
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS manager_schedule_mov;
DELIMITER $$
CREATE PROCEDURE `manager_schedule_mov`(IN i_manUsername VARCHAR(50), IN i_movName VARCHAR(50), IN i_movReleaseDate DATE, IN i_movPlayDate DATE)
BEGIN
	INSERT INTO MoviePlay (thName, comName, movName, movReleaseDate, movPlayDate)
		SELECT thName, comName, i_movName, i_movReleaseDate, i_movPlayDate
		FROM manager JOIN theater ON username = manusername
		WHERE username = i_manUsername;
END$$
DELIMITER ;

DROP PROCEDURE IF EXISTS customer_filter_mov;
DELIMITER $$
CREATE PROCEDURE `customer_filter_mov`(IN i_movName VARCHAR(50), IN i_comName VARCHAR(50), IN i_city VARCHAR(50), IN i_state VARCHAR(50), IN i_minMovPlayDate DATE, IN i_maxMovPlayDate DATE)
BEGIN
    DROP TABLE IF EXISTS CosFilterMovie;
    CREATE TABLE CosFilterMovie
	SELECT movName, thName, thStreet, thCity, thState, thZipcode, theater.comName, movPlayDate, movReleaseDate
	FROM movieplay join theater using(thName)
	WHERE (i_movName = movName) AND (i_comName = comname) AND (i_city = thCity OR i_city = "") AND (i_state = thState) AND (movPlayDate >= i_minMovPlayDate) AND (movPlayDate <= i_maxMovPlayDate);
END$$
DELIMITER ;
