/*
i. ��������� ��� ������� �� vk ������� (�� 10-100 ������� � ������ �������)
ii. �������� ������, ������������ ������ ���� (������ firstname) ������������� ��� ���������� � ���������� �������
iii. �������� ������, ���������� ������������������ ������������� ��� ���������� (���� is_active = false). �������������� �������� ����� ���� � ������� profiles �� ��������� �� ��������� = true (��� 1)
iv. �������� ������, ��������� ��������� ��� �������� (���� ����� �����������)
v. �������� �������� ���� ��������� ������� (� �����������)

https://github.com/bzfrmt/mysql
*/

--- ��������� ��� ������� �� vk ������� (�� 10-100 ������� � ������ �������)
--- �������� � �������� :)

---�������� ������, ������������ ������ ���� (������ firstname) ������������� ��� ���������� � ���������� �������
SELECT DISTINCT firstname FROM users ORDER BY firstname ASC;

---  �������� ������, ���������� ������������������ ������������� ��� ���������� (���� is_active = false). �������������� �������� ����� ���� � ������� profiles �� ��������� �� ��������� = true (��� 1)
ALTER TABLE profiles ADD is_active BOOL DEFAULT 1;
UPDATE profiles SET is_active=0 WHERE TIMESTAMPDIFF(YEAR, birthday, CURDATE())<18

--- �������� ������, ��������� ��������� ��� �������� (���� ����� �����������)
DELETE FROM messages WHERE created_at > NOW()


