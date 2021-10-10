CREATE OR REPLACE TYPE O_CONTRATO AS OBJECT(   
    id_contrato NUMBER(4),
    salario NUMBER(8),
    fecha_inicio DATE,
    fecha_fin DATE,
    comision NUMBER(4),

    CONSTRUCTOR FUNCTION O_CONTRATO(SELF IN OUT NOCOPY O_CONTRATO,
    id_contrato NUMBER, salario NUMBER, fecha_inicio DATE,fecha_fin DATE,
    comision NUMBER) RETURN SELF as RESULT,
    -- extiende el contrato hasta 31-12-2021, si es indefinido actualiza salario
    member PROCEDURE expand(salary NUMBER),
    member procedure display
); 

/
CREATE OR REPLACE TYPE BODY O_CONTRATO AS

     CONSTRUCTOR FUNCTION O_CONTRATO(SELF IN OUT NOCOPY O_CONTRATO,
     id_contrato NUMBER, salario NUMBER, fecha_inicio DATE,fecha_fin DATE,
     comision NUMBER) RETURN SELF as RESULT IS
     BEGIN
     SELF.id_contrato := id_contrato;
     SELF.salario := salario;
     SELF.fecha_inicio := fecha_inicio;
     SELF.fecha_fin := fecha_fin;
     SELF.comision := comision;
     RETURN ;
     END;

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
        dbms_output.put_line(chr(9) || '- salary: '|| salario || ', fecha inicio: ' || fecha_inicio|| ', fecha fin: ' || fecha_fin);
    END display; 
END; 
/

CREATE TYPE C_CONTRATOS IS TABLE OF O_CONTRATO;