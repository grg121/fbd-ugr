-- Seleccionar todos los elementos de la tabla proveedor
SELECT * FROM PROVEEDOR
-- Seleccionar los códigos de proveedores y la ciudad de la tabla proveedor
SELECT ciudad,codpro FROM PROVEEDOR
-- Seleccionar los nombres de proveedores ordenador por el nombre del proveedor
SELECT nompro FROM proveedor ORDER BY NOMPRO
-- Seleccionar los nombres de proveedores ordenador descendentemente por el nombre del proveedor
SELECT nompro FROM proveedor ORDER BY nompro desc
-- Seleccionar las ciudades de los proveedores
SELECT DISTINCT ciudad FROM proveedor
-- Seleccionar las ciudades de los proveedores sin repetir, ordenadas ascendentemente
SELECT DISTINCT ciudad FROM proveedor ORDER BY ciudad asc
-- Seleccionar el nombre de los proveedores que sean de Londres.
SELECT nompro FROM proveedor WHERE ciudad='Londres'
-- Seleccionar el nombre de los proveedores que sean de Londres o de Roma. La sentencia deberá usar el operador lógico OR.
SELECT nompro FROM proveedor WHERE ciudad='Londres' OR ciudad='Roma'
-- Seleccionar el nombre de los proveedores que sean de Londres o de Roma. La sentencia deberá usar el operador IN, ordenados descendentemente.
SELECT nompro FROM proveedor WHERE ciudad IN ('Londres','Roma') ORDER BY nompro desc
-- Mostrar todos los proveedores (nombre y ciudad) cuyo nombre de ciudad contenga una a minúscula.
SELECT nompro,ciudad FROM proveedor WHERE ciudad LIKE '%a%'
-- Mostrar todos los proveedores (nombre y ciudad) cuyo nombre de ciudad contenga exactamente 4 letras (pista: usar LIKE con el símbolo del subrayado)
SELECT nompro,ciudad FROM proveedor WHERE ciudad LIKE '____'
-- Mostrar todas las parejas posibles de proveedores y proyectos.
SELECT DISTINCT * FROM proveedor, PROYECTO
-- Mostrar el código de proveedor y el código de proyecto de todas las parejas posibles de proveedores y proyectos.
SELECT DISTINCT codpro,codpj FROM PROVEEDOR,PROYECTO
-- Mostrar el nombre de proveedor y el nombre de proyecto que estén en la misma ciudad
SELECT nompro,nompj FROM proveedor,proyecto WHERE proveedor.ciudad = proyecto.ciudad
-- Mostrar el nombre de los proveedores que han hecho alguna venta
SELECT nompro FROM proveedor WHERE EXISTS (SELECT codpro FROM ventas WHERE codpro = proveedor.CODPRO)
-- Mostrar el nombre de proyectos a los que se ha hecho alguna venta
SELECT nompj FROM PROYECTO WHERE EXISTS (SELECT codpj FROM ventas WHERE codpj = proyecto.codpj)
-- Mostrar el nombre de proveedores que hayan hecho ventas por cantidad entre 100 y 500
SELECT nompro FROM PROVEEDOR WHERE EXISTS (SELECT codpro FROM ventas WHERE codpro = proveedor.codpro AND (cantidad BETWEEN 100 AND 500))
-- Mostrar el nombre de los proveedores que han hecho alguna venta a proyectos de Londres
SELECT nompro FROM proveedor WHERE EXISTS (SELECT * FROM PROYECTO NATURAL JOIN ventas WHERE codpro = proveedor.codpro AND ciudad = 'Londres')
-- Mostrar el nombre de los proveedores que hayan hecho alguna venta con cantidad superior o igual a 500
SELECT nompro FROM proveedor NATURAL JOIN ventas WHERE cantidad >= 500
-- Mostrar el nombre de los proveedores cuya ciudad esté en alguna de las ciudades donde hay un proyecto, utilizando el operador IN y SELECT anidados.
SELECT nompro FROM proveedor WHERE ciudad IN (SELECT ciudad FROM PROYECTO)
-- Mostrar el código de pieza de las piezas vendidas por el proveedor de nombre Luisa Gomez
SELECT codpie FROM pieza WHERE EXISTS (SELECT * FROM PROVEEDOR NATURAL JOIN ventas WHERE nompro = 'Luisa Gomez' AND codpie = pieza.codpie)
-- Seleccionar el código y nombre de piezas de los proyectos que se realizan en Londres
SELECT codpie,nompie FROM pieza WHERE EXISTS (SELECT * FROM ventas NATURAL JOIN proyecto WHERE ciudad = 'Londres' AND codpie = pieza.codpie)
-- Seleccionar el nombre de pieza, de proyecto y de proveedor cuyas ciudades sean la misma
SELECT nompie,nompj,nompro FROM pieza,proyecto,PROVEEDOR WHERE pieza.ciudad = proyecto.ciudad AND pieza.ciudad = proveedor.ciudad
-- Mostrar las piezas y proyectos a los que han vendido proveedores de Londres
SELECT nompie,nompj FROM pieza,proyecto WHERE EXISTS (SELECT * FROM ventas NATURAL JOIN proveedor WHERE ciudad = 'Londres' AND codpie = pieza.codpie AND codpj = proyecto.codpj)
-- Seleccionar los nombres de los proveedores que han hecho ventas por cantidad máxima
SELECT nompro FROM proveedor WHERE EXISTS (SELECT cantidad FROM VENTAS WHERE codpro = proveedor.codpro AND cantidad >= ALL (SELECT cantidad FROM ventas))
-- Seleccionar los nombres de los proveedores que han hecho ventas por cantidad mayor que la mínima
SELECT DISTINCT nompro FROM proveedor NATURAL JOIN ventas WHERE cantidad > ANY (SELECT cantidad FROM ventas)
-- Seleccionar todos los proveedores de los proyectos a los que proveen los proveedores de Madrid0
SELECT DISTINCT nompro FROM PROVEEDOR WHERE codpro IN (SELECT codpro FROM ventas WHERE codpj in( SELECT codpj FROM PROYECTO WHERE EXISTS (SELECT ciudad FROM ventas NATURAL JOIN proveedor WHERE ciudad = 'Madrid' AND codpj = proyecto.codpj)))
