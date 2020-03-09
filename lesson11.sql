---https://github.com/bzfrmt/mysql

/*Практическое задание по теме “Оптимизация запросов”*/

/*
Создайте таблицу logs типа Archive.
Пусть при каждом создании записи в таблицах users, catalogs и products в таблицу logs помещается время и дата создания записи,
название таблицы, идентификатор первичного ключа и содержимое поля name.
*/

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  id SERIAL PRIMARY KEY,
  created_at DATETIME DEFAULT NOW(),
  logtable VARCHAR(255),
  logid BIGINT,
  logname VARCHAR(255)
) COMMENT = 'Лог' ENGINE=Archive;

DELIMITER //
CREATE TRIGGER log_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (logtable,logid,logname) VALUES ('users',NEW.id,NEW.name);
END//

DELIMITER //
CREATE TRIGGER log_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (logtable,logid,logname) VALUES ('catalogs',NEW.id,NEW.name);
END//

DELIMITER //
CREATE TRIGGER log_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (logtable,logid,logname) VALUES ('products',NEW.id,NEW.name);
END//


/*
(по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.
*/
--- очень размытое задание. Каких откуда каким способом?

/*
Практическое задание по теме “NoSQL”

1.В базе данных Redis подберите коллекцию для подсчета посещений с определенных IP-адресов.
*/
---хеш
HSET logs "192.168.1.1" 1
HSET logs "192.168.1.1" 2
HSET logs "192.168.1.2" 1
--кавычки нужно оборачивать значения?

/*
2.При помощи базы данных Redis решите задачу поиска имени пользователя по электронному адресу и наоборот, поиск электронного адреса пользователя по его имени.
*/
---где искать? пример коллекции?

/*
3.Организуйте хранение категорий и товарных позиций учебной базы данных shop в СУБД MongoDB.
*/

db.createCollection('catalogs');
db.catalogs.insert({id:1,name:'Процессоры'});

db.createCollection('products');
db.products.insert({id:1,name:'intel pentium',price:100,catalog_id:1});
