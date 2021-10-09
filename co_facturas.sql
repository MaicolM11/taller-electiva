CREATE OR REPLACE TYPE O_FACTURA AS OBJECT(   
    id_factura NUMBER(6),
    forma_pago VARCHAR2(1),
    fecha_venta DATE,
    numero_coutas NUMBER(3),
    ventas C_VENTAS,

    member procedure display
); 

/
CREATE OR REPLACE TYPE BODY O_FACTURA AS

    MEMBER PROCEDURE display IS
    BEGIN
        dbms_output.put_line('forma pago: '|| forma_pago || ', fecha venta: ' || fecha_venta);
    END display; 
END; 
/

CREATE TYPE C_FACTURAS IS TABLE OF O_FACTURA;