/*************************************************************
Proyecto: Uniformes Comercio
Descripción:Inserción de catalogos
Valor de retorno: Resultado de ejecucion de cada línea.
Precondiciones: Tener tablas y esquema creado   
Creador: Kristian Ortiz
Fecha de creación: Mayo 2018
*************************************************************/
UPDATE UNIFORMES.TATIPOSPRENDA
SET FCDESCRIPCION = 'PANTALÓN'
WHERE FIIDTIPOPRENDA = 1;

UPDATE UNIFORMES.TATIPOSPRENDA
SET FCDESCRIPCION = 'CORDÓN'
WHERE FIIDTIPOPRENDA = 4;

UPDATE UNIFORMES.TAMENUS
SET FCTITULO = 'Semestral Individual'
WHERE FIIDMENU = 2;


COMMIT;