
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
    
    select "No se logro hacer ningun cambio";
    end if;
    end;