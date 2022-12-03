create or replace PROCEDURE rentabilidade( colheitaA SetoresAgricolas_Colheitas_Culturas.codColheita%type) AS
 c_Setor SetoresAgricolas_Colheitas_Culturas.codSetorAgricola%type;
 c_cultura SetoresAgricolas_Colheitas_Culturas.codCultura%type;
 c_valorSetor SetoresAgricolas_Colheitas_Culturas.valorSetor%type;

	CURSOR c_culturas(colheita SetoresAgricolas_Colheitas_Culturas.codColheita%type) IS
		SELECT codSetorAgricola, codCultura, valorSetor from SetoresAgricolas_Colheitas_Culturas
		 WHERE codColheita = colheita
		 ORDER BY valorSetor DESC;
	colheita_inexistente EXCEPTION;
	dummy Colheitas.codColheita%type;
BEGIN
	SELECT COUNT(*) INTO dummy FROM Colheitas WHERE codColheita = colheita;
	IF dummy = 0 THEN
	 RAISE colheita_inexistente;
	ELSE
	 OPEN c_colheitas(colheitaA);
	LOOP
		FETCH c_culturas INTO c_codSetorAgricola, c_codCultura, c_valorSetor;
		EXIT WHEN c_colheitas%notfound
			dbms_output.put_line(codSetorAgricola || "-" ||  codCultura || "-" || valorSetor);
	END LOOP
	CLOSE c_culturas;
END;