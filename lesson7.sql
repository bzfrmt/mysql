---https://github.com/bzfrmt/mysql


/*
��������� ������ ������������� users, ������� ����������� ���� �� ���� ����� orders � �������� ��������.
*/

SELECT * FROM users WHERE EXISTS (SELECT 1 FROM orders WHERE user_id = users.id);

/*
�������� ������ ������� products � �������� catalogs, ������� ������������� ������.
*/

SELECT p.*, c.name
FROM products AS p LEFT JOIN catalogs AS c
ON c.id = p.catalog_id;

/*
(�� �������) ����� ������� ������� ������ flights (id, from, to) � ������� ������� cities (label, name).
���� from, to � label �������� ���������� �������� �������, ���� name � �������.
�������� ������ ������ flights � �������� ���������� �������.
*/


SELECT id,
(SELECT name FROM cities WHERE label=flights.from) AS `from`,
(SELECT name FROM cities WHERE label=flights.to) AS `to`
FROM flights;

---�� ������ ��� ��������� ��������� �������� ��������


---���������� ����. �� ����� ���������. �����������.
/*
����� ����� ��������� ������������.
�� ���� ������ ����� ������������ ������� ��������, ������� ������ ���� ������� � ����� �������������.
*/
---������ ���� ������� ��� � ���� ������ ���������? � ���� ��������������� ������ �� �������? ��� ���-�� ���?
---����� ��������?
---���������� �� ������� id user �������� ������������?
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
���������� ����� ���������� ������, ������� �������� ������������ ������ 10 ���..
*/

SELECT count(l.*)
FROM likes as l, media as m, profiles as p
WHERE
l.media_id=m.id
and m.user_id=p.user_id
and TIMESTAMPDIFF(YEAR, p.birthday, CURDATE())<10;


/*
���������� ��� ������ �������� ������ (�����) - ������� ��� �������?
*/
---��� ������ ����������? ��� ������ �������? ������������ �������� ��� ����� ��� ������� ���� �������� �������?

SELECT count(l.*) as cl ,p.gender
FROM likes as l, media as m, profiles as p
WHERE
l.media_id=m.id
and m.user_id=p.user_id
GROUP BY p.gender ORDER BY cl desc;

