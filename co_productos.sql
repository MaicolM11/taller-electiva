CREATE OR REPLACE TYPE O_PRODUCTO AS OBJECT(   
    id_producto NUMBER(6),
    nombre VARCHAR2(30),
    stock NUMBER(3),
    valor_unitario NUMBER(6),
    fecha_venc DATE,
    iva NUMBER(2),

    member procedure display
); 

/
CREATE OR REPLACE TYPE BODY O_PRODUCTO AS
    MEMBER PROCEDURE display IS
    BEGIN
        dbms_output.put_line('nombre: '|| nombre || ', stock: ' || stock || ', precio: '||valor_unitario);
    END display; 
END; 
