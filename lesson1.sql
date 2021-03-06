/*
Что-то я не догнал куда отправлять ссылку на репозиторий?!
Под уроком можно оправить только файл!
https://github.com/bzfrmt/mysql

*/



/*
Напишите ответы на вопросы в комментарий при сдаче практического задания:
1) Какие у вас ожидания от курса? Есть ли конкретные вопросы по теме Базы данных?
2) В какой сфере работаете сейчас?
3) Если в IT, то какой у вас опыт (инструменты, технологии, языки программирования)?
*/

-- Освежу знания, может что-то новое мелькнет. Мало опыта с NoSQL. С удовольствием послушаю про elasticsearch
-- Веб-разработчик
-- 2009-2010 Oracle
-- 2004-2014 MySQL
-- 2014-.... PostgreSQL
-- Опыт администрирования маленький, большая часть - разработка.



/* Задача 1
Установите СУБД MySQL. Создайте в домашней директории файл .my.cnf, задав в нем логин и пароль, который указывался при установке.
*/
-- допустим я поставил :)


/* Задача 2
Создайте базу данных example, разместите в ней таблицу users, состоящую из двух столбцов, числового id и строкового name.
*/

DROP DATABASE IF EXISTS example;
CREATE DATABASE example;
USE example;

-- создание таблиц

DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) COMMENT 'Имя'
) COMMENT = 'Пользователи';



/* Задача 3
Создайте дамп базы данных example из предыдущего задания, разверните содержимое дампа в новую базу данных sample.
*/

/*
Создание дампа, выполнять в консоли с правами суперпользователя
mysqldump example > example.sql

Создание бд
mysql sample < example.sql

*/

/*
Задача 4
(по желанию) Ознакомьтесь более подробно с документацией утилиты mysqldump.
Создайте дамп единственной таблицы help_keyword базы данных mysql.
Причем добейтесь того, чтобы дамп содержал только первые 100 строк таблицы.

mysqldump  --where="1 limit 100" mysql help_keyword > help_keyword.sql

*/
