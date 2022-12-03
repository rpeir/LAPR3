--Função que cria um componente
CREATE OR REPLACE FUNCTION createComponente(subs Componentes.substancia%type, catg Componentes.categoria%type) return integer
IS
    codComp integer;
    countComp integer;
BEGIN
select COUNT(*)
into countComp
from Componentes 
where codComp=Componentes.codComponente; 
IF (countComp=1)
THEN
UPDATE Componentes SET substancia = subs, categoria=catg WHERE codComp = Componentes.codComponente;
ELSE
INSERT INTO Componentes (substancia,categoria) VALUES (subs,catg) RETURNING codComponente INTO codComp;
END IF;
RETURN codComp;
END;