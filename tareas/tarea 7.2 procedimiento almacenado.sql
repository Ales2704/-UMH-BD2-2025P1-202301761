
CREATE TABLE mi_base_datos.Cuentas (
    Cuenta INT PRIMARY KEY,
    TotalCreditos DECIMAL(10,2) DEFAULT 0.00,
    TotalDebitos DECIMAL(10,2) DEFAULT 0.00,
    Saldo DECIMAL(10,2) DEFAULT 0.00
);
/*Parte 1 Creacion e inserción de datos*/

CREATE TABLE mi_base_datos.Transacciones (
    IdTransaccion INT AUTO_INCREMENT PRIMARY KEY,
    Cuenta INT,
    Fecha DATE,
    Credito DECIMAL(10,2) DEFAULT 0.00,
    Debito DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (Cuenta) REFERENCES Cuentas(Cuenta)
);


INSERT INTO mi_base_datos.Cuentas (Cuenta, TotalCreditos, TotalDebitos, Saldo) VALUES
(20010001, 800.00, 0.00, 800.00),
(20010002, 560.00, 0.00, 560.00),
(20010003, 1254.00, 0.00, 1254.00),
(20010004, 15000.00, 0.00, 15000.00),
(20010005, 256.00, 0.00, 256.00);







/*Parte 2 Sentencia de eliminación y creacion del procedimiento almacenado*/


drop procedure mi_base_datos.sp_202301761;

DELIMITER //
CREATE PROCEDURE mi_base_datos.sp_202301761(
    IN p_cuenta INT,
    IN p_fecha DATE,
    IN p_credito DECIMAL(10,2),
    IN p_debito DECIMAL(10,2)
)
BEGIN

    DECLARE v_cuenta INT;
    DECLARE v_saldo_actual DECIMAL(10,2);



/*validaciones de cuenta y evitar para evitar que retire mas dinero del permitido */
    SELECT Cuenta, Saldo INTO v_cuenta, v_saldo_actual FROM mi_base_datos.Cuentas
    WHERE Cuenta = p_cuenta;
    IF v_cuenta IS NOT NULL THEN
      
      
        IF v_saldo_actual + p_credito - p_debito >= 0 THEN
            
            
            /* insertar procedimiento*/
            INSERT INTO Transacciones (Cuenta, Fecha, Credito, Debito)
            VALUES (p_cuenta, p_fecha, p_credito, p_debito);

            /*Actualizar las tablas*/
            UPDATE Cuentas
            SET TotalCreditos = TotalCreditos + p_credito,
                TotalDebitos = TotalDebitos + p_debito,
                Saldo = Saldo + p_credito - p_debito
            WHERE Cuenta = p_cuenta;
        ELSE
  
  
  
  /*mensajes de validacion*/
            SELECT "Saldo insuficiente";
        END IF;
    ELSE

        SELECT "La cuenta no existe";
    END IF;
END;



/*Parte 3 Sentencia de ejecución*/


CALL sp_202301761(20010005, '2025-03-08', 500, 0);


SELECT * FROM mi_base_datos.Cuentas;
SELECT * FROM mi_base_datos.Transacciones;
