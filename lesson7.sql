---https://github.com/bzfrmt/mysql


/*
—оставьте список пользователей users, которые осуществили хот€ бы один заказ orders в интернет магазине.
*/

SELECT * FROM users WHERE EXISTS (SELECT 1 FROM orders WHERE user_id = users.id);

/*
¬ыведите список товаров products и разделов catalogs, который соответствует товару.
*/

SELECT p.*, c.name
FROM products AS p LEFT JOIN catalogs AS c
ON c.id = p.catalog_id;

/*
(по желанию) ѕусть имеетс€ таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
ѕол€ from, to и label содержат английские названи€ городов, поле name Ч русское.
¬ыведите список рейсов flights с русскими названи€ми городов.
*/


SELECT id,
(SELECT name FROM cities WHERE label=flights.from) AS `from`,
(SELECT name FROM cities WHERE label=flights.to) AS `to`
FROM flights;

---не уверен что правильно экранирую названи€ столбцов


---ѕредыдущий урок. Ќе успел отправить. ѕрикладываю.
/*
ѕусть задан некоторый пользователь.
»з всех друзей этого пользовател€ найдите человека, который больше всех общалс€ с нашим пользователем.
*/
---больше всех общалс€ это у кого больше сообщений? у кого продолжительней беседа по времени? или что-то ещЄ?
---какой критерий?
---достаточно ли вывести id user искомого пользовател€?
---users.id=1

SELECT count(id) as cm, userid
FROM
(
	SELECT id, from_user_id AS userid FROM messages WHERE to_user_id=1
	UNION ALL
	SELECT id, to_user_id AS userid FROM messages WHERE from_user_id=1
)
WHERE userid IN
(
	SELECT  initiator_user_id AS frendid FROM friend_requests WHERE target_user_id=1 and status='approved'
	UNION
	SELECT  target_user_id AS frendid FROM friend_requests WHERE initiator_user_id=1 and status='approved'
)
GROUP BY userid ORDER BY cm desc LIMIT 1;


/*
ѕодсчитать общее количество лайков, которые получили пользователи младше 10 лет..
*/

SELECT count(l.*)
FROM likes as l, media as m, profiles as p
WHERE
l.media_id=m.id
and m.user_id=p.user_id
and TIMESTAMPDIFF(YEAR, p.birthday, CURDATE())<10;


/*
ќпределить кто больше поставил лайков (всего) - мужчины или женщины?
*/
---что значит определить? что именно вывести? максимальное значение или можно дл€ каждого пола отдельно вывести?

SELECT count(l.*) as cl ,p.gender
FROM likes as l, media as m, profiles as p
WHERE
l.media_id=m.id
and m.user_id=p.user_id
GROUP BY p.gender ORDER BY cl desc;

