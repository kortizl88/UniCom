DROP TABLE UNIFORMES.TAPEDIDOSCD CASCADE CONSTRAINT;

DROP TABLE UNIFORMES.TASOLICITUDESDETALLE CASCADE CONSTRAINT;

DROP TABLE UNIFORMES.TABITACORASOLICITUD  CASCADE CONSTRAINT;

CREATE TABLE UNIFORMES.TASOLICITUDESDETALLE
(	FIFOLIOSOLICITUD NUMBER (20) NOT NULL,
	FIIDDETALLE      NUMBER (10) NOT NULL,
	FIPEDIDO         NUMBER (10) NOT NULL,
	FIPAIS           NUMBER (3) NOT NULL,
	FICANAL          NUMBER (10) NOT NULL,
	FISUCURSAL       NUMBER (10) NOT NULL,
	FIIDTIPOPRENDA   NUMBER (3) NOT NULL,
	FITALLA          NUMBER (10) NOT NULL,
	FISKU			 NUMBER (12) NOT NULL,
	FICANTIDAD       NUMBER (3) NOT NULL,
	FNPRECIOUNITARIO NUMBER (10,2) NOT NULL,
	FNPRECIOTOTAL    NUMBER (10,2) NOT NULL,
	FIESTATUSSOL     NUMBER (5) NOT NULL,
	FIESTATUSCD      NUMBER (5) NOT NULL,
	FDFECHAACT       DATE NOT NULL,
	FIACTIVO         NUMBER(1) NOT NULL,
	CONSTRAINT PK_TASOLICITUDESDETALLE PRIMARY KEY (FIFOLIOSOLICITUD, FIIDDETALLE, FIPAIS, FICANAL, FISUCURSAL, FIPEDIDO, FISKU),
	CONSTRAINT FK_TASOLICITUDESDETALLE_01 FOREIGN KEY (FIFOLIOSOLICITUD) REFERENCES UNIFORMES.TASOLICITUDES (FIFOLIOSOLICITUD),
	CONSTRAINT FK_TASOLICITUDESDETALLE_02 FOREIGN KEY (FIIDTIPOPRENDA) REFERENCES UNIFORMES.TATIPOSPRENDA (FIIDTIPOPRENDA),
	CONSTRAINT FK_TASOLICITUDESDETALLE_03 FOREIGN KEY (FITALLA) REFERENCES UNIFORMES.TATALLAS (FITALLA)
)
LOGGING
TABLESPACE TBS_UNIFORMES_OPE_DAT;

CREATE TABLE UNIFORMES.TABITACORASOLICITUD
	(
	FIIDBITACORA     NUMBER (20) NOT NULL,
	FIFOLIOSOLICITUD NUMBER (20) NOT NULL,
	FIIDDETALLE      NUMBER (10) NOT NULL,
	FCDATOSPROCESO   CLOB,
	FIESTATUSANT     NUMBER (5) NOT NULL,
	FIESTATUSNVO     NUMBER (5) NOT NULL,
	FDFECHA          DATE NOT NULL,
	FCCOMENTARIOS    VARCHAR2 (1000 CHAR) DEFAULT ' ' NOT NULL,
    FIIDERROR        NUMBER (5) DEFAULT 0 NOT NULL,
	CONSTRAINT PK_TABITACORASOLICITUD PRIMARY KEY (FIIDBITACORA),
	CONSTRAINT FK_TABITACORASOLICITUD_01 FOREIGN KEY (FIESTATUSANT) REFERENCES UNIFORMES.TAESTATUSPEDIDOS (FIIDESTATUSPEDIDO),
	CONSTRAINT FK_TABITACORASOLICITUD_02 FOREIGN KEY (FIESTATUSNVO) REFERENCES UNIFORMES.TAESTATUSPEDIDOS (FIIDESTATUSPEDIDO),
	CONSTRAINT FK_TABITACORASOLICITUD_03 FOREIGN KEY (FIIDERROR) REFERENCES UNIFORMES.TATIPOSERROR (FIIDERROR)
	)
	LOGGING
	TABLESPACE TBS_UNIFORMES_OPE_DAT;

CREATE TABLE UNIFORMES.TAREMISIONESXPEDIDO
	(
	FIFOLIOSOLICITUD NUMBER (20) NOT NULL,
	FIIDDETALLE      NUMBER (10) NOT NULL,
	FIPAIS           NUMBER (3) NOT NULL,
	FICANAL          NUMBER (10) NOT NULL,
	FISUCURSAL       NUMBER (10) NOT NULL,
	FIPEDIDO         NUMBER (10) NOT NULL,
	FISKU            NUMBER (20) NOT NULL,
	FIREMISION       NUMBER (20) NOT NULL,
	FICANTIDAD       NUMBER (3) NOT NULL,
	FIEMPLEADORECIBE NUMBER (10) NOT NULL,
	CONSTRAINT PK_TAREMISIONESXPEDIDO PRIMARY KEY (FIPAIS, FICANAL, FISUCURSAL, FIPEDIDO, FISKU, FIREMISION),
	CONSTRAINT FK_TAREMISIONESXPEDIDO_01 FOREIGN KEY (FIFOLIOSOLICITUD, FIIDDETALLE, FIPAIS, FICANAL, FISUCURSAL, FIPEDIDO, FISKU) REFERENCES UNIFORMES.TASOLICITUDESDETALLE (FIFOLIOSOLICITUD, FIIDDETALLE, FIPAIS, FICANAL, FISUCURSAL, FIPEDIDO, FISKU)
	)
	TABLESPACE TBS_UNIFORMES_OPE_DAT
	LOGGING
	NOCACHE
	STORAGE (BUFFER_POOL DEFAULT);

/*TYPE CARGA */
CREATE OR REPLACE TYPE UNIFORMES.TYPNEGOCIO AS OBJECT
   (
   	  FINEGOCIO NUMBER(3),
   	  FCNEGOCIO VARCHAR2(100 CHAR)
   )
/
CREATE OR REPLACE TYPE UNIFORMES.TYPARRNEGOCIO AS TABLE OF UNIFORMES.TYPNEGOCIO;

CREATE OR REPLACE TYPE UNIFORMES.TYPCARGA AS OBJECT
   (
   	  FIIDCARGA NUMBER(5),
   	  FCDESCRIPCION VARCHAR2(160 CHAR),
   	  FDFECHAINICIAL VARCHAR2(15 CHAR),
   	  FDFECHAFINAL VARCHAR2(15 CHAR),
   	  FIESTATUS NUMBER(1),
   	  FIGENERARPEDIDO NUMBER(1),
   	  NEGOCIOS UNIFORMES.TYPARRNEGOCIO
   );
   
DELETE FROM TAESTATUSPEDIDOS;
INSERT INTO UNIFORMES.TAESTATUSPEDIDOS (FIIDESTATUSPEDIDO, FCDESCRIPCION)
VALUES (0, 'CANCELADO');
INSERT INTO UNIFORMES.TAESTATUSPEDIDOS (FIIDESTATUSPEDIDO, FCDESCRIPCION)
VALUES (1, 'SOLICITUD GENERADA');
INSERT INTO UNIFORMES.TAESTATUSPEDIDOS (FIIDESTATUSPEDIDO, FCDESCRIPCION)
VALUES (2, 'SOLICITADO EN TIENDA');
INSERT INTO UNIFORMES.TAESTATUSPEDIDOS (FIIDESTATUSPEDIDO, FCDESCRIPCION)
VALUES (3, 'SOLICITADO EN CD');
INSERT INTO UNIFORMES.TAESTATUSPEDIDOS (FIIDESTATUSPEDIDO, FCDESCRIPCION)
VALUES (4, 'ATENDIDO EN CD');
INSERT INTO UNIFORMES.TAESTATUSPEDIDOS (FIIDESTATUSPEDIDO, FCDESCRIPCION)
VALUES (5, 'EN CAMINO A TIENDA');
INSERT INTO UNIFORMES.TAESTATUSPEDIDOS (FIIDESTATUSPEDIDO, FCDESCRIPCION)
VALUES (6, 'RECIBIDO EN TIENDA');
INSERT INTO UNIFORMES.TAESTATUSPEDIDOS (FIIDESTATUSPEDIDO, FCDESCRIPCION)
VALUES (7, 'ENTREGADO');
INSERT INTO UNIFORMES.TAESTATUSPEDIDOS (FIIDESTATUSPEDIDO, FCDESCRIPCION)
VALUES (8, 'DESCUENTO SAP');
INSERT INTO UNIFORMES.TAESTATUSPEDIDOS (FIIDESTATUSPEDIDO, FCDESCRIPCION)
VALUES (9, 'DESCUENTO SPPI');