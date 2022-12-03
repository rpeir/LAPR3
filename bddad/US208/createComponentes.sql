--Função que cria um componente
CREATE OR REPLACE FUNCTION createComponente(subs Componentes.substancia%type, catg Componentes.categoria%type) return integer
IS
    DECLARE codComp integer;
BEGIN
IF (EXISTS(SELECT * FROM Componentes WHERE codComp = Componentes.codComponente))
THEN
UPDATE Componentes SET substancia = subs, categoria=catg WHERE codComp = Componentes.codComponente;
ELSE
INSERT INTO Componentes (codComponente,substancia,categoria) VALUES (:new.codComponente,substancia,categoria) RETURNING codComponente INTO codComp;
END IF;
RETURN codComp;
END;