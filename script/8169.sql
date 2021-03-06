﻿SET TERM ^ ;

CREATE OR ALTER trigger pedido_bu_can_wms for pedido
active before update position 10010
AS
DECLARE VARIABLE VAR_ROTA VARCHAR(100);
DECLARE VARIABLE VAR_ROMANEIO INTEGER;
DECLARE VARIABLE VAR_PLACA_VEICULO VARCHAR(8);
BEGIN
     IF (NEW.FILIAL = 1 ) THEN BEGIN
     IF (((NEW.CANCELADO <> OLD.CANCELADO) AND (NEW.FATURADO = 'S') AND (NEW.CANCELADO = 'S'))) THEN BEGIN
        SELECT FIRST 1 ITEMROMANEIO.ROMANEIO, VEICULO.PLACA
        FROM ITEMROMANEIO
        INNER JOIN ROMANEIO ON ROMANEIO.CODIGO = ITEMROMANEIO.ROMANEIO AND ROMANEIO.FILIAL =1
        INNER JOIN VEICULO ON VEICULO.CODIGO = ROMANEIO.VEICULO
        WHERE ITEMROMANEIO.NUMERO = NEW.NUMERO
        INTO :VAR_ROMANEIO,  :VAR_PLACA_VEICULO;
        VAR_ROTA = 'R' || :VAR_ROMANEIO || '/' || :VAR_PLACA_VEICULO;
        INSERT INTO LOG_WMS VALUES ('DEV'||NEW.NUMERO, 'VIEW_WMS_PEDIDO', 'NUMERO', 'I', NULL, :VAR_ROTA, NULL);
     END
     END
END^

SET TERM ; ^


SET TERM ^ ;

CREATE OR ALTER trigger pedido_bu_wmsdelete for pedido
active before update position 10000
AS
begin
     if (new.filial = 1) then begin
     if (((NEW.CANCELADO <> OLD.CANCELADO) AND (NEW.CANCELADO = 'S')AND (NEW.FATURADO = 'N'))) then BEGIN
        INSERT INTO LOG_WMS VALUES (NEW.NUMERO, 'VIEW_WMS_PEDIDO', 'NUMERO', 'D', null, NULL, null);
     END
     end
end^

SET TERM ; ^

