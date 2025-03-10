--Відобразити прізвища та імена всіх працівників.
SELECT workers.last_name, workers.first_name
FROM workers;

--Відобразити назви товарів та вартість 10 їх одиниць
--з урахуванням знижки 50% на одну одиницю (при купівлі 10 одиниць).
SELECT goods.name, round(goods.price * 9.5, 2) AS cost
FROM goods;

--Відобразити товари в алфавітному порядку їх назв.
SELECT goods.*
FROM goods
ORDER BY goods.name;

--Відобразити працівників в алфавітному порядку категорій
-- та у зворотному порядку номерів паспортів.
SELECT workers.*
FROM workers
ORDER BY workers.qualification, workers.passport_no DESC;