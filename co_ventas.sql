CREATE OR REPLACE TYPE O_VENTA AS OBJECT(   
    cantidad NUMBER(3),
    valor NUMBER(6),
    producto O_PRODUCTO,
    
    CONSTRUCTOR FUNCTION O_VENTA(SELF IN OUT NOCOPY O_VENTA,
    cantidad NUMBER,valor NUMBER,producto O_PRODUCTO) RETURN SELF as RESULT,
    member procedure display
); 

/
CREATE OR REPLACE TYPE BODY O_VENTA AS

     CONSTRUCTOR FUNCTION O_VENTA(SELF IN OUT NOCOPY O_VENTA,
     cantidad NUMBER,valor NUMBER,producto O_PRODUCTO) RETURN SELF as RESULT IS
         BEGIN
         SELF.cantidad := cantidad;
         SELF.valor := valor;
         SELF.producto := producto;
         RETURN ;
     END;
     
    MEMBER PROCEDURE display IS
    BEGIN
        dbms_output.put_line( chr(9) || chr(9) || '* nombre: ' || producto.nombre || ', cantidad: '|| cantidad || ', valor: ' || valor);
    END display; 
END; 
/

CREATE TYPE C_VENTAS IS TABLE OF O_VENTA;