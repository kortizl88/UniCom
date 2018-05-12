/*************************************************************
Proyecto: Uniformes Comercio
Descripci�n:Inserci�n de catalogos
Valor de retorno: Resultado de ejecucion de cada l�nea.
Precondiciones: Tener tablas y esquema creado   
Creador: Kristian Ortiz
Fecha de creaci�n: Mayo 2018
*************************************************************/
UPDATE UNIFORMES.TATIPOSPRENDA
SET FCDESCRIPCION = 'PANTAL�N'
WHERE FIIDTIPOPRENDA = 1;

UPDATE UNIFORMES.TATIPOSPRENDA
SET FCDESCRIPCION = 'CORD�N'
WHERE FIIDTIPOPRENDA = 4;

UPDATE UNIFORMES.TAMENUS
SET FCTITULO = 'Semestral Individual'
WHERE FIIDMENU = 2;


COMMIT;