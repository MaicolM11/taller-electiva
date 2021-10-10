

-- creacion de clases 
start co_productos.sql
start co_contratos.sql
start co_ventas.sql
start co_facturas.sql
start co_empleados.sql

show errors;

-- migracion bd MULTISET
DECLARE
 empleados C_EMPLEADOS;
 prod O_PRODUCTO;
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
         SELECT CAST(MULTISET(SELECT cantidad, valor, NULL
         FROM VENTAS v WHERE empleados(i).facturas(j).numero = v.numero) AS C_VENTAS) INTO empleados(i).facturas(j).ventas
         FROM DUAL;
        DBMS_OUTPUT.PUT_LINE( ' facturas en el objeto '  || empleados(i).facturas(j).numero);
          
     END LOOP;
     
        DBMS_OUTPUT.PUT_LINE( ' facturas en el objeto '  || empleados(2).sale_for_year(13));
          
     
 END LOOP;
 
END;




