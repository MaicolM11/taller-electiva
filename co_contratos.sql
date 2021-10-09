CREATE OR REPLACE TYPE O_CONTRATO AS OBJECT(   
    id_contrato NUMBER(4),
    salario NUMBER(8),
    fecha_inicio DATE,
    fecha_fin DATE,
    comision NUMBER(4),

    -- extiende el contrato hasta 31-12-2021, si es indefinido actualiza salario
    member PROCEDURE expand(salary NUMBER),
    member procedure display
); 

/
CREATE OR REPLACE TYPE BODY O_CONTRATO AS
    MEMBER PROCEDURE expand(salary NUMBER) IS
    BEGIN
            IF fecha_fin IS NULL THEN
                self.salario := salary;
            ELSE
                self.fecha_fin := TO_DATE('2021/12/31', 'yyyy/mm/dd');
            END IF;
    END expand;

    MEMBER PROCEDURE display IS
    BEGIN
        dbms_output.put_line('salary: '|| salario || ', fecha fin: ' || fecha_fin);
    END display; 
END; 
/

CREATE TYPE C_CONTRATOS IS TABLE OF O_CONTRATO;