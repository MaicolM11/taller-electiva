CREATE OR REPLACE TYPE O_FACTURA AS OBJECT(   
    numero NUMBER(6),
    forma_pago VARCHAR2(1),
    fecha_venta DATE,
    numero_cuotas NUMBER(3),
    ventas C_VENTAS,

    member procedure display
); 

/
CREATE OR REPLACE TYPE BODY O_FACTURA AS

    MEMBER PROCEDURE display IS
    BEGIN
        dbms_output.put_line(chr(9) ||'- Factura '|| numero || ', fecha venta: ' || fecha_venta);
        FOR v IN 1 .. ventas.COUNT LOOP
            ventas(v).display;
        END LOOP;
    END display; 
END; 
/

CREATE TYPE C_FACTURAS IS TABLE OF O_FACTURA;