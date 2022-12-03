--Função que cria um componente
CREATE OR ALTER FUNCTION createComponente(subs Componentes.substancia%type, catg Componentes.categoria%type) return integer
AS
    DECLARE codComp integer;
BEGIN
IF (EXISTS(SELECT * FROM COMPONENTE WHERE codComp = Componentes.codComponente))
THEN
UPDATE COMPONENTE SET substancia = subs, categoria=catg WHERE codComp = Componentes.codComponente;
ELSE
INSERT INTO COMPONENTE (codComponente,substancia,categoria) VALUES (:new.codComponente,substancia,categoria) RETURNING codComponente INTO codComp;
END
END IF;
RETURN codComp;
END;