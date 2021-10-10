CREATE OR REPLACE TYPE O_EMPLEADO AS OBJECT(   
    cedula NUMBER(4),
    nombre VARCHAR2(30),
    apellido VARCHAR2(30),
    correo VARCHAR2(30),
    genero VARCHAR2(30),
    contratos C_CONTRATOS,
    facturas C_FACTURAS,
    
    CONSTRUCTOR FUNCTION O_EMPLEADO(SELF IN OUT NOCOPY O_EMPLEADO,
    cedula NUMBER, nombre VARCHAR2,apellido VARCHAR2,correo VARCHAR2,
    genero VARCHAR2, contratos C_CONTRATOS,facturas C_FACTURAS) RETURN SELF as RESULT,
    --total de ventas de un empleado en un año determinado
    member procedure sale_for_year(year NUMBER),
    -- busca el ultimo contrato y lo extiende
    member PROCEDURE expand(salary NUMBER),
    member PROCEDURE display,
    member PROCEDURE display_contracts,
    MEMBER PROCEDURE display_bills
); 

/

CREATE OR REPLACE TYPE BODY O_EMPLEADO AS

     CONSTRUCTOR FUNCTION O_EMPLEADO(SELF IN OUT NOCOPY O_EMPLEADO,
        cedula NUMBER, nombre VARCHAR2,apellido VARCHAR2,correo VARCHAR2,
        genero VARCHAR2, contratos C_CONTRATOS,facturas C_FACTURAS) RETURN SELF as RESULT IS
         BEGIN
         SELF.nombre := nombre;
         SELF.apellido := apellido;
         SELF.correo := correo;
         SELF.genero := genero;
         SELF.contratos := contratos;
         SELF.facturas := facturas;
         RETURN ;
     END;

    
    MEMBER PROCEDURE expand(salary NUMBER) IS
        last_contract O_CONTRATO:= NULL;
        pos_i NUMBER:=-1;
    BEGIN
        FOR i IN contratos.FIRST .. contratos.LAST LOOP
            IF last_contract IS NULL OR last_contract.fecha_inicio < contratos(i).fecha_inicio THEN   
                last_contract := contratos(i);
                pos_i := i;
            END IF;
        END LOOP;

        IF last_contract IS NOT NULL THEN   
            contratos(pos_i).expand(salary);
        END IF;
              
    END expand;
    
    MEMBER PROCEDURE display IS
    BEGIN
        dbms_output.put_line('cedula: '|| cedula || 'nombres: '|| nombre || ' ' || apellido);
    END display; 

    MEMBER PROCEDURE display_contracts IS
        last_contract O_CONTRATO:= NULL;
    BEGIN
        dbms_output.put_line('contratos: ');
        FOR c IN 1 .. contratos.COUNT LOOP
            contratos(c).display;
        END LOOP;    
    END display_contracts;

    MEMBER PROCEDURE display_bills IS
        last_contract O_CONTRATO:= NULL;
    BEGIN
        dbms_output.put_line('facturas: ');
        FOR f IN 1 .. facturas.COUNT LOOP
            facturas(f).display;
        END LOOP;  
    END display_bills;
    
    MEMBER PROCEDURE sale_for_year(year NUMBER) IS
        totalSale NUMBER := 0;
        total NUMBER := 0;
        fecha DATE;
    BEGIN
        FOR i IN facturas.FIRST .. facturas.LAST LOOP
             fecha := TO_CHAR (facturas(i).fecha_venta, 'DD-MM-YYYY');
             IF EXTRACT (YEAR FROM fecha) = year THEN
               FOR j IN facturas(i).ventas.FIRST .. facturas(i).ventas.LAST LOOP
               totalSale := facturas(i).ventas(j).cantidad * facturas(i).ventas(j).valor; 
               total := (total+totalSale);
               END LOOP;
              END IF;
        END LOOP;
       DBMS_OUTPUT.PUT_LINE( 'empleado: '|| nombre || ' '|| apellido || ' total de ventas:'  ||  (TO_CHAR (total, '9G999G999')) || ' del año ' || year);
    END sale_for_year;
    
END; 
/
show errors;

CREATE TYPE C_EMPLEADOS IS TABLE OF O_EMPLEADO;

