CREATE OR REPLACE TYPE O_FACTURA AS OBJECT(   
    numero NUMBER(6),
    forma_pago VARCHAR2(1),
    fecha_venta DATE,
    numero_cuotas NUMBER(3),
    ventas C_VENTAS,
    
    CONSTRUCTOR FUNCTION O_FACTURA(SELF IN OUT NOCOPY O_FACTURA,
    numero NUMBER, forma_pago VARCHAR2, fecha_venta DATE,
    numero_cuotas NUMBER,ventas C_VENTAS) RETURN SELF as RESULT,
    member procedure display
); 

/
CREATE OR REPLACE TYPE BODY O_FACTURA AS

    CONSTRUCTOR FUNCTION O_FACTURA(SELF IN OUT NOCOPY O_FACTURA,
    numero NUMBER, forma_pago VARCHAR2, fecha_venta DATE,
    numero_cuotas NUMBER,ventas C_VENTAS) RETURN SELF as RESULT IS
         BEGIN
         SELF.numero := numero;
         SELF.forma_pago := forma_pago;
         SELF.fecha_venta := fecha_venta;
         SELF.numero_cuotas := numero_cuotas;
         SELF.ventas := ventas;
         RETURN ;
     END;

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