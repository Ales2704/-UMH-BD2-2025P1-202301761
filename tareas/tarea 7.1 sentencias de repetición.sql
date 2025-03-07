
/* actividad 7.1 */

/*
	Calculador de ahorro mensual. 
*/
drop table  mi_base_datos.registro; 

/* Crear una tabla para registrar transacciones */
CREATE TABLE mi_base_datos.registro (
    numTransacción INT AUTO_INCREMENT PRIMARY KEY,
    mes INT,
    Monto DECIMAL(10, 2),
    Saldo DECIMAL(10, 2)
);

select * from mi_base_datos.registro;



delimiter //
drop procedure mi_base_datos.sp_ahorro;


delimiter //
/* Crear el procedimiento almacenado */


create procedure mi_base_datos.sp_ahorro(
	in p_monto decimal(10,2), 
    in p_mes int              
)
begin 
	# Declaración de variables 
    declare v_meses int default 0;  
    declare v_contr int default 0; 
    declare v_monto decimal(10,2) default 0;
    declare v_saldo decimal(10,2) default 0;


    set v_meses = p_mes; 
    set v_monto = p_monto;
    
    # Ciclo de repetición 
    WHILE v_contr < v_meses DO  
        set v_saldo = v_saldo + v_monto;       
       
        # Crear registro 
        insert into mi_base_datos.registro (Monto, mes, Saldo)
        values(v_monto, v_contr + 1, v_saldo);
        
        # variable de control
        set v_contr = v_contr + 1; 
    END WHILE; 
end;


call mi_base_datos.sp_ahorro(80, 6); 
 
select * from mi_base_datos.registro;


