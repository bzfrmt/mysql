---https://github.com/bzfrmt/mysql


/*
� ���� ������ shop � sample ������������ ���� � �� �� �������, ������� ���� ������.
����������� ������ id = 1 �� ������� shop.users � ������� sample.users.
����������� ����������.
*/

START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE shop.users.id=1;
DELETE FROM shop.users WHERE shop.users.id=1;
COMMIT;

/*
�������� �������������, ������� ������� �������� name �������� ������� �� ������� products � ��������������� �������� �������� name �� ������� catalogs.
*/

CREATE OR REPLACE VIEW cat AS
SELECT p.name, c.name
FROM products AS p LEFT JOIN catalogs AS c
ON c.id = p.catalog_id;

/*
�� �������) ����� ������� ������� � ����������� ����� created_at.
� ��� ��������� ���������� ����������� ������ �� ������ 2018 ���� '2018-08-01', '2016-08-04', '2018-08-16' � 2018-08-17.
��������� ������, ������� ������� ������ ������ ��� �� ������, ��������� � �������� ���� �������� 1,
���� ���� ������������ � �������� ������� � 0, ���� ��� �����������.
*/

---�� ���� ��� ����������� �� 1 �� 31, ����� � ��� ������� �� ��� �� ���������. ��� ������� ����� ����� ������ ������� �������� �������� ������ 31 ������.
---��������� ������� ������� ������� �������, ��� �� ������� :)

/*
(�� �������) ����� ������� ����� ������� � ����������� ����� created_at.
�������� ������, ������� ������� ���������� ������ �� �������, �������� ������ 5 ����� ������ �������.
*/

DELETE FROM likes WHERE created_at NOT IN (
 SELECT created_at FROM likes ORDER BY created_at DESC LIMIT 5);

--���

SELECT @mindata:= created_at FROM likes ORDER BY created_at DESC LIMIT 5,1;
DELETE FROM likes WHERE created_at <@mindata;

/*
�������� �������� ������� hello(), ������� ����� ���������� �����������, � ����������� �� �������� ������� �����.
� 6:00 �� 12:00 ������� ������ ���������� ����� "������ ����", � 12:00 �� 18:00 ������� ������ ���������� ����� "������ ����",
� 18:00 �� 00:00 � "������ �����",
� 00:00 �� 6:00 � "������ ����".
*/

DELIMITER //
DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION  hello ()
BEGIN
  DECLARE hours INT;
  DECLARE resulthello VARCHAR(255);

  SELECT CAST(DATE_FORMAT(NOW(), "%k") AS UNSIGNED) AS hours;

  CASE hours
	WHEN hours >=6 AND hours<12 THEN
  	SET resulthello='������ ����';
	WHEN hours >=12 AND hours<18 THEN
  	SET resulthello='������ ����';
  	WHEN hours >=18 AND hours<24 THEN
  	SET resulthello='������ �����';
	ELSE
  	SET resulthello='������ ����';
  END CASE;
  RETURN resulthello;
END//


/*
� ������� products ���� ��� ��������� ����: name � ��������� ������ � description � ��� ���������.
��������� ����������� ����� ����� ��� ���� �� ���. ��������, ����� ��� ���� ��������� �������������� �������� NULL �����������.
��������� ��������, ��������� ����, ����� ���� �� ���� ����� ��� ��� ���� ���� ���������.
��� ������� ��������� ����� NULL-�������� ���������� �������� ��������.
*/
DELIMITER //
CREATE TRIGGER check_catalog_id_insert BEFORE INSERT ON products
FOR EACH ROW
BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
  	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
  END IF;
END//

DELIMITER //
CREATE TRIGGER check_catalog_id_update BEFORE UPDATE ON products
FOR EACH ROW
BEGIN
  IF NEW.name IS NULL AND NEW.description IS NULL THEN
  	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled';
  END IF;
END//

/*
(�� �������) �������� �������� ������� ��� ���������� ������������� ����� ���������.
������� ��������� ���������� ������������������ � ������� ����� ����� ����� ���� ���������� �����.
����� ������� FIBONACCI(10) ������ ���������� ����� 55.
*/

DROP FUNCTION IF EXISTS FIBONACCI;
CREATE FUNCTION FIBONACCI (X INT)
BEGIN
  DECLARE A, B, C INT;
  DECLARE i INT DEFAULT 2;

  IF X<1 THEN SET C=0;
  ELSEIF X==1 THEN SET C=1;
  ELSE
  	SET A=0;
  	SET B=1;
  	WHILE i<X DO
        SET C=A+B;
        SET A=B;
        SET B=C;
  		SET i=i+1;
    END WHILE;
  END IF;


  RETURN C;
END//




