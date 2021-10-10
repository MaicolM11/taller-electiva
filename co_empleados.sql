CREATE OR REPLACE TYPE O_EMPLEADO AS OBJECT(   
    cedula NUMBER(4),
    nombre VARCHAR2(30),
    apellido VARCHAR2(30),
    correo VARCHAR2(30),
    genero VARCHAR2(30),
    contratos C_CONTRATOS,
    facturas C_FACTURAS,

    -- busca el ultimo contrato y lo extiende
    member procedure sale_for_year,
    member PROCEDURE expand(salary NUMBER),
    member procedure display
); 

/

CREATE OR REPLACE TYPE BODY O_EMPLEADO AS
    MEMBER PROCEDURE display IS
    BEGIN
        dbms_output.put_line('nombres: '|| self.nombre || ' ' || self.apellido || 'contratos: ' || contratos.count);
    END display; 

    MEMBER PROCEDURE expand(salary NUMBER) IS
        last_contract O_CONTRATO:= NULL;
    BEGIN
        FOR i IN facturas.FIRST .. facturas.LAST LOOP
            IF last_contract IS NULL OR last_contract.fecha_inicio < contratos(i).fecha_inicio THEN   
                last_contract := contratos(i);
            END IF;
        END LOOP;
        last_contract.display;
        last_contract.expand(salary);
        last_contract.display;
    END expand;
    
     MEMBER PROCEDURE sale_for_year(year NUMBER) IS
        facturas_Empl O_FACTUR:= NULL;
    BEGIN
        FOR i IN contratos.FIRST .. contratos.LAST LOOP
            IF last_contract IS NULL OR last_contract.fecha_inicio < contratos(i).fecha_inicio THEN   
                last_contract := contratos(i);
            END IF;
        END LOOP;
        last_contract.display;
        last_contract.expand(salary);
        last_contract.display;
    END expand;

END; 
/

CREATE TYPE C_EMPLEADOS IS TABLE OF O_EMPLEADO;