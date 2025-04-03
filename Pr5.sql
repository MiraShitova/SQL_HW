-- Знайдіть список назв товарів через кому для кожного виробника.
SELECT manufacturers.name, GROUP_CONCAT(goods.name, ', ') AS goods_list
FROM manufacturers INNER JOIN goods ON manufacturers.code = goods.manufacturer_code
GROUP BY manufacturers.code;


-- Знайдіть для кожного виробника кількість виготовлених ним товарів ціною менш як 20 гривень.
SELECT manufacturers.name, COUNT(goods.code) AS goods_amount
FROM goods INNER JOIN manufacturers
    ON goods.manufacturer_code = manufacturers.code
WHERE goods.price < 20
GROUP BY manufacturers.code;


-- Знайдіть середню ціну всіх товарів.
SELECT ROUND(AVG(goods.price), 2) AS avg_price
FROM goods;


-- Відобразіть виробників, що виготовляють більше одного товару ціною менш як 20 гривень.
SELECT manufacturers.name, COUNT(goods.code) AS goods_amount
FROM goods INNER JOIN manufacturers
    ON goods.manufacturer_code = manufacturers.code
WHERE goods.price < 20
GROUP BY manufacturers.code
HAVING COUNT(goods.code) > 1;