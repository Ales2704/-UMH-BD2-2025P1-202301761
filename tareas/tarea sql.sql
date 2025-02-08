CREATE DATABASE mi_base_datos;
USE mi_base_datos;

show tables;


SELECT 
    t.`Country`, 
    t.`Product`, 
    t.`SalePrice`, 
    t.`ManufacturingPrice`, 
    c.`exchange_rate` 
FROM transacciones t
JOIN currencies c ON t.`Country` = c.`country`
WHERE t.`Country` = 'Mexico' 
AND t.`Year` = 2014 
AND t.`MonthName` IN ('January', 'February')
ORDER BY t.`Date`, t.`Product`;

Select Distinct MonthName from transacciones;

select * from currencies Limit 10;

SELECT t1.country, t1.product,t1.saleprice,
    t1.manufacturingprice,t2.exchange_rate,
    STR_TO_DATE(t1.date, '%d/%m/%Y') AS fecha,
    DATE_FORMAT(STR_TO_DATE(t1.date, '%d/%m/%Y'), '%m') AS mes,
    DATE_FORMAT(STR_TO_DATE(t1.date, '%d/%m/%Y'), '%Y') AS año
FROM 
    mi_base_datos.transacciones AS t1
INNER JOIN 
    mi_base_datos.currencies AS t2
ON 
    t1.country = t2.country
WHERE 
    t1.country = 'Mexico'
    AND DATE_FORMAT(STR_TO_DATE(t1.date, '%d/%m/%Y'), '%m') IN ('01', '02')
ORDER BY 
    mes;

    


