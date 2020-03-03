---https://github.com/bzfrmt/mysql


/*
В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных.
Переместите запись id = 1 из таблицы shop.users в таблицу sample.users.
Используйте транзакции.
*/

START TRANSACTION;
INSERT INTO sample.users SELECT * FROM shop.users WHERE shop.users.id=1;
DELETE FROM shop.users WHERE shop.users.id=1;
COMMIT;

/*
Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.
*/

CREATE OR REPLACE VIEW cat AS
SELECT p.name, c.name
FROM products AS p LEFT JOIN catalogs AS c
ON c.id = p.catalog_id;

/*
по желанию) Пусть имеется таблица с календарным полем created_at.
В ней размещены разряженые календарные записи за август 2018 года '2018-08-01', '2016-08-04', '2018-08-16' и 2018-08-17.
Составьте запрос, который выводит полный список дат за август, выставляя в соседнем поле значение 1,
если дата присутствует в исходном таблице и 0, если она отсутствует.
*/

---не знаю как перечислить от 1 до 31, циклы я так понимаю мы ещё не проходили. Как вариант взять любую другую таблицу вкоторой заведомо больше 31 строки.
---заполнять ручками таблицу сдатами августа, это не вариант :)

/*
(по желанию) Пусть имеется любая таблица с календарным полем created_at.
Создайте запрос, который удаляет устаревшие записи из таблицы, оставляя только 5 самых свежих записей.
*/

DELETE FROM likes WHERE created_at NOT IN (
 SELECT created_at FROM likes ORDER BY created_at DESC LIMIT 5);

--или

SELECT @mindata:= created_at FROM likes ORDER BY created_at DESC LIMIT 5,1;
DELETE FROM likes WHERE created_at <@mindata;

/*
Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток.
С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
с 18:00 до 00:00 — "Добрый вечер",
с 00:00 до 6:00 — "Доброй ночи".
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
  	SET resulthello='Доброе утро';
	WHEN hours >=12 AND hours<18 THEN
  	SET resulthello='Добрый день';
  	WHEN hours >=18 AND hours<24 THEN
  	SET resulthello='Добрый вечер';
	ELSE
  	SET resulthello='Доброй ночи';
  END CASE;
  RETURN resulthello;
END//


/*
В таблице products есть два текстовых поля: name с названием товара и description с его описанием.
Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема.
Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены.
При попытке присвоить полям NULL-значение необходимо отменить операцию.
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
(по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел.
Вызов функции FIBONACCI(10) должен возвращать число 55.
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




