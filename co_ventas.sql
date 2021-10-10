CREATE OR REPLACE TYPE O_VENTA AS OBJECT(   
    cantidad NUMBER(3),
    valor NUMBER(6),
    producto O_PRODUCTO,

    member procedure display
); 

/
CREATE OR REPLACE TYPE BODY O_VENTA AS

    MEMBER PROCEDURE display IS
    BEGIN
        dbms_output.put_line('cantidad: '|| cantidad || ', valor: ' || valor);
    END display; 
END; 
/

CREATE TYPE C_VENTAS IS TABLE OF O_VENTA;