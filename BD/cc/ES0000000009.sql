/*************************************************************
Proyecto: Uniformes Comercio v2
Descripcion: Crea el usuario, las tablas e indices.
Valor de retorno: Resultado de ejecucion de cada linea.
Precondiciones: Ninguna   
Creador: Kristian Ortiz
Fecha de creacion: Mayo 2018
*************************************************************/
CREATE OR REPLACE TYPE UNIFORMES.TYPCEDIS AS OBJECT(
    FIPAIS NUMBER(3),
    FICD   NUMBER(10)
);
/
CREATE OR REPLACE TYPE UNIFORMES.TYPARRCEDIS AS TABLE OF UNIFORMES.TYPCEDIS;
/

CREATE OR REPLACE TYPE UNIFORMES.TYPCARGA AS OBJECT(
    FIIDCARGA       NUMBER(5),
    FCDESCRIPCION   VARCHAR2(160 CHAR),
    FDFECHAINICIAL  VARCHAR2(15 CHAR),
    FDFECHAFINAL    VARCHAR2(15 CHAR),
    FIESTATUS       NUMBER(1),
    FIGENERARPEDIDO NUMBER(1),
    NEGOCIOS        UNIFORMES.TYPARRNEGOCIO,
    CEDIS           UNIFORMES.TYPARRCEDIS   
);

ALTER TABLE UNIFORMES.TASOLICITUDES
ADD FICANCELADO NUMBER(1) DEFAULT 0 NOT NULL;