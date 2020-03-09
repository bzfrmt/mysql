---https://github.com/bzfrmt/mysql

/*������������ ������� �� ���� ������������ ��������*/

/*
�������� ������� logs ���� Archive.
����� ��� ������ �������� ������ � �������� users, catalogs � products � ������� logs ���������� ����� � ���� �������� ������,
�������� �������, ������������� ���������� ����� � ���������� ���� name.
*/

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  id SERIAL PRIMARY KEY,
  created_at DATETIME DEFAULT NOW(),
  logtable VARCHAR(255),
  logid BIGINT,
  logname VARCHAR(255)
) COMMENT = '���' ENGINE=Archive;

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
(�� �������) �������� SQL-������, ������� �������� � ������� users ������� �������.
*/
--- ����� �������� �������. ����� ������ ����� ��������?

/*
������������ ������� �� ���� �NoSQL�

1.� ���� ������ Redis ��������� ��������� ��� �������� ��������� � ������������ IP-�������.
*/
---���
HSET logs "192.168.1.1" 1
HSET logs "192.168.1.1" 2
HSET logs "192.168.1.2" 1
--������� ����� ����������� ��������?

/*
2.��� ������ ���� ������ Redis ������ ������ ������ ����� ������������ �� ������������ ������ � ��������, ����� ������������ ������ ������������ �� ��� �����.
*/
---��� ������? ������ ���������?

/*
3.����������� �������� ��������� � �������� ������� ������� ���� ������ shop � ���� MongoDB.
*/

db.createCollection('catalogs');
db.catalogs.insert({id:1,name:'����������'});

db.createCollection('products');
db.products.insert({id:1,name:'intel pentium',price:100,catalog_id:1});
