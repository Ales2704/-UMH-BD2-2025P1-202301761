
INSERT INTO currencies (currency_name, currency_symbol, iso_code, exchange_rate, country)
VALUES
    ('Canadian Dollar', 'CAD$', 'CAD', NULL, 'CANADA'),      -- Canada
    ('Euro', '€', 'EUR', NULL, 'FRANCE'),                     -- France
    ('Euro', '€', 'EUR', NULL, 'GERMANY'),                     -- Germany
    ('US Dollar', '$', 'USD', NULL, 'UNITED STATES OF AMERICA'),                -- United States of America
    ('Mexican Peso', '$', 'MXN', NULL, 'MEXICO');             -- Mexico
    



SELECT 
    t.`Country`, 
    t.`Product`, 
    t.`SalePrice`, 
    t.`ManufacturingPrice`, 
    c.`exchange_rate` 
FROM financialsample t
JOIN currencies c ON t.`Country` = c.`country`
WHERE t.`Country` = 'Mexico' 
AND t.`Year` = 2014 
AND t.`MonthName` IN ('January', 'February')
ORDER BY t.`Date`, t.`Product`;

Select Distinct MonthName from financialsample;

select * from currencies Limit 10;

SELECT t1.country, t1.product,t1.saleprice,
    t1.manufacturingprice,t2.exchange_rate,
    STR_TO_DATE(t1.date, '%d/%m/%Y') AS fecha,
    DATE_FORMAT(STR_TO_DATE(t1.date, '%d/%m/%Y'), '%m') AS mes,
    DATE_FORMAT(STR_TO_DATE(t1.date, '%d/%m/%Y'), '%Y') AS año
FROM 
    mi_base_datos.financialsample AS t1
INNER JOIN 
    mi_base_datos.currencies AS t2
ON 
    t1.country = t2.country
WHERE 
    t1.country = 'Mexico'
    AND DATE_FORMAT(STR_TO_DATE(t1.date, '%d/%m/%Y'), '%m') IN ('01', '02')
ORDER BY 
    mes;





/*procedimiento con casos*/

DELIMITER //

DROP PROCEDURE sp_new_currency_case;

DELIMITER //

CREATE PROCEDURE sp_new_currency_case(
    IN p_currency_name VARCHAR(45),
    IN p_currency_symbol VARCHAR(45),
    IN p_exchange_rate DECIMAL(15,2),
    IN p_country VARCHAR(45),
    IN p_iso_code VARCHAR(45)
)
BEGIN
    /* Declaración de variables */
    DECLARE v_currency_name VARCHAR(45) DEFAULT NULL;
    DECLARE v_currency_symbol VARCHAR(45);
    DECLARE v_exchange_rate DECIMAL(15,2);
    DECLARE v_country VARCHAR(45);
    DECLARE v_iso_code VARCHAR(45);

     SET v_currency_name = p_currency_name;
    SET v_currency_symbol = p_currency_symbol;
    SET v_exchange_rate = p_exchange_rate;
    SET v_country = p_country;
    SET v_iso_code = p_iso_code;

/* Case statement */
CASE
    WHEN p_currency_name LIKE '%dolar%' THEN
        SET v_currency_symbol = '$';
    WHEN p_currency_name LIKE '%peso%' THEN
        SET v_currency_symbol = 'P';
    WHEN p_currency_name LIKE '%yen%' THEN
        SET v_currency_symbol = '¥';
    WHEN p_currency_name LIKE '%euro%' THEN
        SET v_currency_symbol = '€';
    ELSE
        SET v_currency_symbol = p_currency_symbol;
END CASE;

INSERT INTO currencies (
    currency_name, currency_symbol, exchange_rate, country, ISO_CODE
)
VALUES (
    v_currency_name, v_currency_symbol, v_exchange_rate, v_country, v_iso_code
);
COMMIT;


end;

SELECT * 
FROM db_demo.financialsample;
/*
	Sentencia para agregar un campo.
*/
ALTER TABLE db_demo.financialsample 
ADD transactionID int primary key auto_increment;

/*
	Consultas

    STR_TO_DATE()  / DATE_FORMAT()
*/
 


SELECT date , str_to_date(date, '%d/%m/%Y') fecha , 
DATE_FORMAT(str_to_date(date, '%d/%m/%Y'), '%m') mes
FROM db_demo.financialsample
where 
	UPPER(Country) = 'CANADA'
    AND Discounts > 0
    AND TRIM(DiscountBand) = 'High'; 


delete from db_demo.currencies where currency_id = 2;

INSERT INTO currencies (currency_name, currency_symbol, iso_code, exchange_rate, country)
VALUES
    ('Lempira', 'L', 'HNL', 24.9, 'HONDURAS');
    
/*
select * from db_demo.currencies;
update db_demo.currencies set exchange_rate = 20.48 where currency_id = 5;
commit;
*/

