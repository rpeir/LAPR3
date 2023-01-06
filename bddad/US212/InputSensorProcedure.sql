CREATE OR REPLACE PROCEDURE passar3F
AS
  v_idSensor varchar(5);
  v_tipoSensor varchar(2);
  v_valorLido  varchar(3);
  v_valorReferencia varchar(2);
  v_instanteLeitura varchar(23);
  codLeitura number;
  duplicado number;



Cursor c_idSensor is
Select substr(input_string,1,5) as substring from input_sensor;
Cursor c_tipoSensor is
Select substr(input_string,6,2) as substring from input_sensor;
Cursor c_valorLido is
Select substr(input_string,8,3) as substring from input_sensor;
Cursor c_valorReferencia is
Select substr(input_string,11,2) as substring from input_sensor;
Cursor c_instanteLeitura is
Select substr(input_string,13,13) as substring from input_sensor;

Begin
Select count(*) into codLeitura from Leituras;
Open c_idSensor;
Open c_tipoSensor;
Open c_valorLido;
Open c_valorReferencia;
Open c_instanteLeitura;
Loop
Fetch c_idSensor into v_idSensor;
Fetch c_tipoSensor into v_tipoSensor;
Fetch c_valorLido into v_valorLido;
Fetch c_valorReferencia into v_valorReferencia;
Fetch c_instanteLeitura into v_instanteLeitura;
Exit when c_idsensor%notfound or c_tiposensor%notfound or
             c_valorLido%notfound or c_valorReferencia%notfound or
             c_instanteLeitura%notfound;
      codLeitura := codLeitura + 1;

Select count(*) into duplicado from sensores where valorReferencia = v_valorReferencia OR idSensor = v_idSensor;
If duplicado = 0 then
         Insert into Sensores (idSensor, codTipoSensor, codEstacaoMeteorologica, valorReferencia) values (v_idSensor, v_tipoSensor, NULL, TO_NUMBER(v_valorReferencia));
END IF;

INSERT INTO Leituras(codLeitura, idSensor, instanteLeitura, valorLido) values
    (codLeitura, v_idSensor, TO_DATE(v_instanteLeitura,'DDMMYYYYHH24:MI'),TO_NUMBER(v_valorLido));

End Loop;
End;