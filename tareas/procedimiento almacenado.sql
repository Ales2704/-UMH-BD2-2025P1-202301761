
CREATE DATABASE mi_base_de_datos;


USE mi_base_de_datos;

DROP TABLE currencies; 

CREATE TABLE currencies (
    currency_id INT AUTO_INCREMENT PRIMARY KEY,
    currency_name VARCHAR(100) NOT NULL,
    currency_symbol VARCHAR(10),
    iso_code VARCHAR(5)  NOT NULL,
    exchange_rate DECIMAL(15, 6),  -- Exchange rate with precision for currency conversion
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    country varchar(45)
);

INSERT INTO currencies (currency_name, currency_symbol, iso_code, exchange_rate, country)
VALUES
    ('Canadian Dollar', 'CAD$', 'CAD', NULL, 'CANADA'),      -- Canada
    ('Euro', '€', 'EUR', NULL, 'FRANCE'),                     -- France
    ('Euro', '€', 'EUR', NULL, 'GERMANY'),                     -- Germany
    ('US Dollar', '$', 'USD', NULL, 'UNITED STATES OF AMERICA'),                -- United States of America
    ('Mexican Peso', '$', 'MXN', NULL, 'MEXICO');             -- Mexico
    

DELIMITER //
create procedure sp_udp_currency(
in p_tasa decimal(15,6),
in p_currency_id int
)
begin
	if p_tasa > 0 and p_tasa is not null THEN
    UPDATE mi_base_de_datos.currencies set exchange_rate = p_tasa
    where currency_id = p_currency_id 
    and currency_id > 0;
    commit;
    
    select "No se logro hacer ningun cambio.";
    end if;
    end;
    
    SELECT * 
FROM mi_base_datos.financialsample;
/*
	Sentencia para agregar un campo.
*/
ALTER TABLE mi_base_datos.financialsample 
ADD transactionID int primary key auto_increment;

/*
	Consultas

    STR_TO_DATE()  / DATE_FORMAT()
*/
 


SELECT date , str_to_date(date, '%d/%m/%Y') fecha , 
DATE_FORMAT(str_to_date(date, '%d/%m/%Y'), '%m') mes
FROM mi_base-datos.financialsample
where 
	UPPER(Country) = 'CANADA'
    AND Discounts > 0
    AND TRIM(DiscountBand) = 'High'; 


delete from mi_base_datos.currencies where currency_id = 2;

INSERT INTO currencies (currency_name, currency_symbol, iso_code, exchange_rate, country)
VALUES
    ('Lempira', 'L', 'HNL', 24.9, 'HONDURAS');
    
/*
select * from db_demo.currencies;
update db_demo.currencies set exchange_rate = 20.48 where currency_id = 5;
commit;
*/
    
    
    
  DELIMITER //

DROP PROCEDURE IF EXISTS sp_new_currency //

DELIMITER //

DROP PROCEDURE IF EXISTS sp_new_currency //

CREATE PROCEDURE sp_new_currency(
    IN p_currency_name VARCHAR(45),
    IN p_currency_symbol VARCHAR(45), 
    IN p_exchange_rate DECIMAL(10,2), 
    IN p_country VARCHAR(45),
    IN p_iso_code VARCHAR(45)
)
BEGIN  
    INSERT INTO currencies (
        currency_name, currency_symbol, exchange_rate, country, ISO_CODE
    )
    VALUES (p_currency_name, p_currency_symbol, p_exchange_rate, p_country, p_iso_code);
    
    -- COMMIT solo si se requieren transacciones explícitas
    COMMIT;  
END //

DELIMITER ;

-- Llamar al procedimiento
CALL sp_new_currency(
    "YEN",
    "¥", 
    0, 
    "JAPON",
    "JPY"
);

