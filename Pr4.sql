-- Відобразіть всі можливі комбінації товарів та виробників.
SELECT goods.*, manufacturers.*
FROM goods CROSS JOIN manufacturers;


-- Відобразіть пари колег – працівників, що мають одного й того ж начальника.
SELECT *
FROM workers, workers AS collegues
WHERE (workers.chief = collegues.chief)
  AND (workers.passport_no < collegues.passport_no);


-- Відобразіть дані про виробника кожного з товарів.
SELECT goods.*, manufacturers.*
FROM goods CROSS JOIN manufacturers
WHERE goods.manufacturer_code = manufacturers.code;

SELECT goods.*, manufacturers.*
FROM goods INNER JOIN manufacturers
    ON goods.manufacturer_code = manufacturers.code;


-- Відобразіть інформацію про подружні пари серед працівників.
SELECT
    husbands.last_name || ' ' || husbands.first_name || ' ' || husbands.middle_name AS husbands_name,
    husbands.qualification,
    wifes.last_name || ' ' || wifes.first_name || ' ' || wifes.middle_name AS wifes_name,
    wifes.qualification
FROM (marriage INNER JOIN workers AS husbands
    ON husbands.passport_no = marriage.husband_passport_no)
    INNER JOIN workers AS wifes ON wifes.passport_no = marriage.wife_passport_no;


-- Відобразіть дані про те, які товари на яких складах зберігаються.
SELECT goods.name, goods.price, holds.amount, warehouses.name, round (goods.price * holds.amount, 2) AS sum
FROM (goods INNER JOIN main.holds
    ON goods.code = holds.goods_code)
    INNER JOIN warehouses
        ON holds.warehouse_code = warehouses.code
ORDER BY goods.name, warehouses.name;


-- Для кожного складу відобразіть ПІБ його керівника
SELECT
    warehouses.name AS warehouse_name,
    workers.last_name || ' ' || workers.first_name || ' ' || workers.middle_name AS chief_name
FROM warehouses INNER JOIN workers
    ON workers.passport_no = warehouses.chief_passport_no
ORDER BY  warehouse_name, chief_name;


-- Відобразіть дані про товари, що наявні в кількості принаймні 15 одиниць хоча б на одному зі складів.
SELECT goods.name, holds.warehouse_code, holds.amount
FROM goods INNER JOIN holds
    ON goods.code = holds.goods_code
WHERE holds.amount >= 15;


-- Відобразіть дані про те, які товари на яких складах зберігаються.
SELECT goods.name, holds.amount, holds.warehouse_code
FROM goods LEFT JOIN holds
    ON goods.code = holds.goods_code;

SELECT goods.name, holds.amount, warehouses.name
FROM (goods LEFT JOIN holds
    ON goods.code = holds.goods_code)
    LEFT JOIN warehouses
    ON holds.warehouse_code = warehouses.code;

SELECT goods.name, holds.amount, warehouses.name
FROM goods LEFT JOIN (holds INNER JOIN warehouses
    ON holds.warehouse_code = warehouses.code)
    ON goods.code = holds.goods_code;


-- Відобразіть всю інформацію про товари, які зберігаються на складах мережі супермаркетів.
SELECT goods.name, goods.price, goods.code, goods.manufacturer_code
FROM goods INNER JOIN holds ON goods.code = holds.goods_code;


-- Відобразіть всю інформацію про товари, які НЕ зберігаються на складах мережі супермаркетів.
SELECT goods.name, goods.price, goods.code, goods.manufacturer_code
FROM goods LEFT JOIN holds ON goods.code = holds.goods_code
WHERE holds.goods_code IS NULL;


-- Відобразіть всю інформацію про неодружених працівників.
SELECT workers.*
FROM workers LEFT JOIN marriage
    ON (workers.passport_no = marriage.wife_passport_no) OR (workers.passport_no = marriage.husband_passport_no)
WHERE marriage.husband_passport_no IS NULL;


-- Відобразіть всю інформацію про працівників, які НЕ керують складами.
SELECT workers.*
FROM workers LEFT JOIN warehouses
    ON workers.passport_no = warehouses.chief_passport_no
WHERE warehouses.code IS NULL;
