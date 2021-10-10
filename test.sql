ALTER SESSION SET NLS_DATE_FORMAT = 'DD/MM/YYYY';

-- TEST alargar contrato
DECLARE
    con1 O_CONTRATO;
    con2 O_CONTRATO;
BEGIN
    con1 := O_CONTRATO(16, 2000, '12/10/2020', NULL, 3);
    con2 := O_CONTRATO(12, 2000, '12/10/2020', '12/12/2020', 3);
    con1.expand(900);
    con2.expand(900);
    con1.display;
    con2.display;
END; 


DECLARE
    emp1 O_EMPLEADO;
    emp2 O_EMPLEADO;

    con1 O_CONTRATO;
    con2 O_CONTRATO;
    con3 O_CONTRATO;
BEGIN
    con1 := O_CONTRATO(16, 2000, '01/1/2020','01/6/2020', 3);
    con2 := O_CONTRATO(12, 2000, '01/1/2021', '1/6/2021', 3);   -- ultimo contrato
    con3 := O_CONTRATO(16, 2000, '01/6/2020', '01/12/2020', 3);
    
    emp1 := O_EMPLEADO(16, 'carlos','torres', 'CORREO', 'M', C_CONTRATOS(con1, con2, con3), C_FACTURAS()); 
    emp1.display;
    emp1.expand(9000);
    emp1.display;

    -- contrato nulo
    con2 := O_CONTRATO(12, 2000, '01/1/2021', NULL, 3);  

    emp2 := O_EMPLEADO(20, 'Julia','Ramirez', 'CORREO', 'F', C_CONTRATOS(con1, con2, con3), C_FACTURAS()); 
    emp2.display;
    emp2.expand(9000);
    emp2.display;

END; 

execute migracion.migrar();

execute migracion.display();

execute migracion.expand(10, 9000);


