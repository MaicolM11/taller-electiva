CREATE OR REPLACE TYPE O_PRODUCTO AS OBJECT(   
    id_producto NUMBER(6),
    nombre VARCHAR2(30),
    stock NUMBER(3),
    valor_unitario NUMBER(6),
    fecha_venc DATE,
    iva NUMBER(2),

    CONSTRUCTOR FUNCTION O_PRODUCTO(SELF IN OUT NOCOPY O_PRODUCTO,
    id_producto NUMBER, nombre VARCHAR2,stock NUMBER,valor_unitario NUMBER,
    fecha_venc DATE,iva NUMBER) RETURN SELF as RESULT,
    member procedure display
); 

/
CREATE OR REPLACE TYPE BODY O_PRODUCTO AS

    CONSTRUCTOR FUNCTION O_PRODUCTO(SELF IN OUT NOCOPY O_PRODUCTO,
    id_producto NUMBER, nombre VARCHAR2,stock NUMBER,valor_unitario NUMBER,
    fecha_venc DATE,iva NUMBER) RETURN SELF as RESULT IS
         BEGIN
         SELF.id_producto := id_producto;
         SELF.nombre := nombre;
         SELF.stock := stock;
         SELF.valor_unitario := valor_unitario;
         SELF.fecha_venc := fecha_venc;
         SELF.iva := iva;
         RETURN ;
     END;
     
    MEMBER PROCEDURE display IS
    BEGIN
        dbms_output.put_line('nombre: '|| nombre || ', stock: ' || stock || ', precio: '||valor_unitario);
    END display; 
END; 
