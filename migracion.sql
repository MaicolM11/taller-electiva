CREATE OR REPLACE PACKAGE migracion AS 
    empleados C_EMPLEADOS;
    PROCEDURE migrar;
    PROCEDURE expand(id NUMBER, salary NUMBER);
    PROCEDURE sale_for_year(id NUMBER, year NUMBER);
    PROCEDURE display;
    FUNCTION parseProduct(p_id productos.ID_PRODUCTO%TYPE) RETURN O_PRODUCTO;
END migracion;

/
CREATE OR REPLACE PACKAGE BODY migracion AS 

    PROCEDURE migrar IS
    BEGIN
        SELECT CAST(MULTISET(SELECT cedula, nombre, apellido, correo, genero, C_CONTRATOS(),C_FACTURAS()
        FROM EMPLEADOS) AS C_EMPLEADOS) INTO  empleados
        FROM DUAL;

        FOR i IN 1.. empleados.COUNT LOOP
            SELECT CAST(MULTISET(SELECT  id_contrato, salario, fecha_inicio, fecha_fin, comision
            FROM CONTRATOS c WHERE empleados(i).cedula = c.CEDULA) AS C_CONTRATOS) INTO  empleados(i).contratos
            FROM DUAL;

            SELECT CAST(MULTISET(SELECT  numero, forma_pago, fecha_venta, numero_cuotas, C_VENTAS()
            FROM FACTURAS f  WHERE empleados(i).cedula = f.CEDULA) AS C_FACTURAS) INTO  empleados(i).facturas
            FROM DUAL;
            
            FOR j IN 1.. empleados(i).facturas.COUNT LOOP
                SELECT CAST(MULTISET(SELECT cantidad, valor, ParseProduct(id)
                FROM VENTAS v WHERE empleados(i).facturas(j).numero = v.numero) AS C_VENTAS) INTO empleados(i).facturas(j).ventas
                FROM DUAL;
            END LOOP;               
            
        END LOOP;
    END migrar;

    PROCEDURE expand(id NUMBER, salary NUMBER) IS
    BEGIN
        FOR i IN 1.. empleados.COUNT LOOP
            IF empleados(i).cedula = id THEN
                empleados(i).expand(salary);
            END IF;
        END LOOP;
    END expand;

     PROCEDURE sale_for_year(id NUMBER, year NUMBER) IS
        BEGIN
            FOR i IN 1.. empleados.COUNT LOOP
                IF empleados(i).cedula = id THEN
                    empleados(i).sale_for_year(year);
                END IF;
            END LOOP;
        END sale_for_year;
        
        
        PROCEDURE display  IS
        BEGIN
        FOR i IN 1.. empleados.COUNT LOOP
            empleados(i).display;
            empleados(i).display_contracts;
            empleados(i).display_bills;
            DBMS_OUTPUT.PUT_LINE('.................................');
        END LOOP;
    END display;

    FUNCTION parseProduct(p_id productos.ID_PRODUCTO%TYPE) RETURN O_PRODUCTO IS
        prod O_PRODUCTO;
        prod_found productos%ROWTYPE;
    BEGIN
        SELECT * INTO prod_found
        FROM productos p
        WHERE p.id_producto = p_id;
        prod := O_PRODUCTO(prod_found.id_producto, prod_found.nombre, prod_found.stock, prod_found.valor_unitario, prod_found.fecha_venc, prod_found.iva );
        RETURN prod;    
    END;

END migracion;
/
