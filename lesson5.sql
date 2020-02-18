---https://github.com/bzfrmt/mysql


/*
ѕусть в таблице users пол€ created_at и updated_at оказались незаполненными.
«аполните их текущими датой и временем.
*/

UPDATE users SET creates_at=NOW() WHERE creates_at IS NULL;
UPDATE users SET updated_at=NOW() WHERE updated_at IS NULL;

/*
“аблица users была неудачно спроектирована.
«аписи created_at и updated_at были заданы типом VARCHAR и в них долгое врем€ помещались значени€ в формате "20.10.2017 8:10".
Ќеобходимо преобразовать пол€ к типу DATETIME, сохранив введеные ранее значени€.
*/

UPDATE users SET creates_at=STR_TO_DATE(creates_at,'%d.%m.%Y %k:%i'),updated_at=STR_TO_DATE(updated_at,'%d.%m.%Y %k:%i');
ALTER TABLE users CHANGE creates_at creates_at DATETIME;
ALTER TABLE users CHANGE updated_at updated_at DATETIME;


/*
¬ таблице складских запасов storehouses_products в поле value могут встречатьс€ самые разные цифры: 0, если товар закончилс€ и выше нул€, если на складе имеютс€ запасы.
Ќеобходимо отсортировать записи таким образом, чтобы они выводились в пор€дке увеличени€ значени€ value.
ќднако, нулевые запасы должны выводитьс€ в конце, после всех записей.
*/

SELECT * FROM storehouses_products ORDER BY IF(value>0,0,1) ASC, value ASC;


/*
(по желанию) »з таблицы users необходимо извлечь пользователей, родившихс€ в августе и мае.
ћес€цы заданы в виде списка английских названий ('may', 'august')
*/

SELECT * FROM users WHERE LOWER(DATE_FORMAT(birthday_at, '%M')) IN ('may', 'august');

/*
(по желанию) »з таблицы catalogs извлекаютс€ записи при помощи запроса.
SELECT * FROM catalogs WHERE id IN (5, 1, 2);
ќтсортируйте записи в пор€дке, заданном в списке IN.
*/

SELECT * FROM catalogs WHERE id IN (5, 1, 2) order by FIELD(id,5,1,2);

/*
ѕодсчитайте средний возраст пользователей в таблице users
*/

SELECT AVG(TIMESTAMPDIFF(YEAR, birthday_at, CURDATE())) FORM users;
--- SELECT AVG(TIMESTAMPDIFF(DAY, birthday_at, CURDATE())/365.25) FORM users;

/*
ѕодсчитайте количество дней рождени€, которые приход€тс€ на каждый из дней недели.
—ледует учесть, что необходимы дни недели текущего года, а не года рождени€.
*/

SELECT DATE_FORMAT(STR_TO_DATE(CONCAT(DATE_FORMAT(NOW(), '%Y'),DATE_FORMAT(birthday_at, '-%m-%d')),"%Y-%m-%d"), '%W') as dday, count(*) as dcount FROM users GROUP BY dday ORDER BY dcount;

/*
(по желанию) ѕодсчитайте произведение чисел в столбце таблицы
*/
--- хз как считать факториал?