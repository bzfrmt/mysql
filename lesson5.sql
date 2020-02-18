---https://github.com/bzfrmt/mysql


/*
����� � ������� users ���� created_at � updated_at ��������� ��������������.
��������� �� �������� ����� � ��������.
*/

UPDATE users SET creates_at=NOW() WHERE creates_at IS NULL;
UPDATE users SET updated_at=NOW() WHERE updated_at IS NULL;

/*
������� users ���� �������� ��������������.
������ created_at � updated_at ���� ������ ����� VARCHAR � � ��� ������ ����� ���������� �������� � ������� "20.10.2017 8:10".
���������� ������������� ���� � ���� DATETIME, �������� �������� ����� ��������.
*/

UPDATE users SET creates_at=STR_TO_DATE(creates_at,'%d.%m.%Y %k:%i'),updated_at=STR_TO_DATE(updated_at,'%d.%m.%Y %k:%i');
ALTER TABLE users CHANGE creates_at creates_at DATETIME;
ALTER TABLE users CHANGE updated_at updated_at DATETIME;


/*
� ������� ��������� ������� storehouses_products � ���� value ����� ����������� ����� ������ �����: 0, ���� ����� ���������� � ���� ����, ���� �� ������ ������� ������.
���������� ������������� ������ ����� �������, ����� ��� ���������� � ������� ���������� �������� value.
������, ������� ������ ������ ���������� � �����, ����� ���� �������.
*/

SELECT * FROM storehouses_products ORDER BY IF(value>0,0,1) ASC, value ASC;


/*
(�� �������) �� ������� users ���������� ������� �������������, ���������� � ������� � ���.
������ ������ � ���� ������ ���������� �������� ('may', 'august')
*/

SELECT * FROM users WHERE LOWER(DATE_FORMAT(birthday_at, '%M')) IN ('may', 'august');

/*
(�� �������) �� ������� catalogs ����������� ������ ��� ������ �������.
SELECT * FROM catalogs WHERE id IN (5, 1, 2);
������������ ������ � �������, �������� � ������ IN.
*/

SELECT * FROM catalogs WHERE id IN (5, 1, 2) order by FIELD(id,5,1,2);

/*
����������� ������� ������� ������������� � ������� users
*/

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, CURDATE())) FORM users;
--- SELECT AVG(TIMESTAMPDIFF(DAY, birthday_at, CURDATE())/365.25) FORM users;

/*
����������� ���������� ���� ��������, ������� ���������� �� ������ �� ���� ������.
������� ������, ��� ���������� ��� ������ �������� ����, � �� ���� ��������.
*/

SELECT DATE_FORMAT(STR_TO_DATE(CONCAT(DATE_FORMAT(NOW(), '%Y'),DATE_FORMAT(birthday_at, '-%m-%d')),"%Y-%m-%d"), '%W') as dday, count(*) as dcount FROM users GROUP BY dday ORDER BY dcount;

/*
(�� �������) ����������� ������������ ����� � ������� �������
*/
--- �� ��� ������� ���������?