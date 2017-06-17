-- // CREACIÓN DE LA TABLA PROVEEDOR
create table proveedor(
-- defino atributo codpro (código proveedor)
-- como cadena de 3 caracteres no nula
codpro char(3) constraint nncodpro not null
-- que es clave primaria de la tabla
constraint cppro primary key,
-- y defino atributo nompro (nombre proveedor)
-- como cadena variable (max 30 caracteres) no nula
nompro varchar(30) constraint nnnompro not null,
-- defino atributo status. Que valdra entre 1 y 10
status number constraint entre1y10estado
check(status>=1 and status<=10),
-- defino atributo ciudad como cadena de caracteres variable max 15 carc.
ciudad varchar(15));
describe proveedor

  -- // CREACIÓN DE LA TABLA PIEZA
  create table pieza(
  -- atributo codpie identifica a una pieza
  -- es una cad. caracteres de tamaño 3 y es clave primaria de la tabla
    codpie char(3) constraint cppie primary key,
  -- atributo nompie nombre de pieza, cadena variable 10 caracteres no nulo
    nompie varchar2(10) constraint nnnompie not null,
  -- atrib. color (puede ser nulo cuando la pieza sea multicolor o transparente)
    color varchar2(10),
    -- atributo peso que tiene 5 dígitos y 2 decimales
    peso number(5,2)
    -- limitamos el peso entre 0 y 100 pa no hundir los camiones.
    CONSTRAINT entre0y100peso check(peso>0 and peso <= 100),
    -- otro atributo más, ciudad, cad maximo 15 caracteres.
    ciudad varchar2(15));

  -- // CREACIÓN DE LA TABLA PROYECTO
    create table proyecto(
    -- atributo codpj (código del proyecto) que es clave primaria
    codpj char(3) constraint cppjj primary key,
    -- atributo nompj (nombre del peoyecto) no nulo (max 20 c, variable)
    nompj varchar2(20) constraint nompj_no_nulo not null,
    -- atributo ciudad cc varible max 15 c
    ciudad varchar2(15));

  -- // CREACION DE LA TABLA VENTAS
  create table ventas (
    -- codigo producto es clave externa de la tabla producto
    codpro constraint codpro_CE_proveedor
    references proveedor(codpro),
    -- código pieza es clave externa de la tabla pieza
    codpie constraint codpie_CE_pieza
    references pieza(codpie),
    -- código proyecto es clave externa de la tabla pieza
    codpj constraint codpj_CE_proyecto
    references proyecto(codpj),
    -- atributo cantidad de 4 digitos sin decimales. Clave primaria
    cantidad number(4),
    constraint clave_primaria primary key (codpro,codpie,codpj));
