CREATE OR REPLACE PROCEDURE passar3F
AS
    v_idSensor varchar(5);
    v_tipoSensor varchar(2);
    v_valorLido  varchar(3);
    v_valorReferencia varchar(2);
    v_instanteLeitura varchar(23);
    codLeitura number;
    duplicado number;
    nrSucessos int := 0;
    nrInvalidos number := 0;
    nrRegistoLidos number:= 0;
    erroHS int := 0;
    erroPI int := 0;
    erroTS int := 0;
    erroVV int := 0;
    erroTA int := 0;
    erroPA int := 0;
    erroHA int := 0;


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

            nrRegistoLidos := nrRegistoLidos + 1;
            If validateCodTipoSensor(v_tipoSensor) > 0 and validateNumber(v_valorLido) > 0 and validateNumber(v_valorReferencia) > 0 and validaDate(v_instanteLeitura) > 0 then
                Select count(*) into duplicado from sensores where valorReferencia = v_valorReferencia OR idSensor = v_idSensor;
                If duplicado = 0 then
                    Insert into Sensores (idSensor, codTipoSensor, codEstacaoMeteorologica, valorReferencia) values (v_idSensor, v_tipoSensor, NULL, TO_NUMBER(v_valorReferencia));
                END IF;

                codLeitura := codLeitura + 1;
                INSERT INTO Leituras(codLeitura, idSensor, instanteLeitura, valorLido) values
                    (codLeitura, v_idSensor, TO_DATE(v_instanteLeitura,'DDMMYYYYHH24:MI'),TO_NUMBER(v_valorLido));

                delete from input_sensor where input_string like (Select concat(
                                                                                 v_idSensor,(Select concat(
                                                                                                            v_tipoSensor,(Select concat (
                                                                                                                                         v_valorLido,(Select concat(v_valorReferencia,v_instanteLeitura) from dual)
                                                                                                                                     ) from dual)
                                                                                                        ) from dual)
                                                                             ) from dual);
                nrSucessos := nrSucessos + 1;
            Else
                nrInvalidos := nrInvalidos + 1;
                IF v_tipoSensor LIKE 'HS' THEN
                    erroHS := erroHS + 1;
                end if;
                IF v_tipoSensor LIKE 'PI' THEN
                    erroPI := erroPI + 1;
                end if;
                IF v_tipoSensor LIKE 'TS' THEN
                    erroTS := erroTS + 1;
                end if;
                IF v_tipoSensor LIKE 'VV' THEN
                    erroVV := erroVV + 1;
                end if;
                IF v_tipoSensor LIKE 'TA' THEN
                    erroTA := erroTA + 1;
                End if;
                IF v_tipoSensor LIKE 'HA' THEN
                    erroHA := erroHA + 1;
                end if;
                IF v_tipoSensor LIKE 'PA' THEN
                    erroPA := erroPA + 1;
                end if;
            end if;
        End Loop;
        Close c_idSensor;
        Close c_tipoSensor;
        Close c_valorLido;
        Close c_valorReferencia;
        Close c_instanteLeitura;
        dbms_output.put_line('Nr de Registos lidos: '|| nrRegistoLidos);
        dbms_output.put_line('Nr de Sucessos: '|| nrSucessos);
        dbms_output.put_line('Nr de Registos Inválidos: ' || nrInvalidos);
        dbms_output.put_line('Erros no sensor do tipo HS: ' || erroHS);
        dbms_output.put_line('Erros no sensor do tipo PI: ' || erroPI);
        dbms_output.put_line('Erros no sensor do tipo TS: ' || erroTS);
        dbms_output.put_line('Erros no sensor do tipo VV: ' || erroVV);
        dbms_output.put_line('Erros no sensor do tipo TA: ' || erroTA);
        dbms_output.put_line('Erros no sensor do tipo HA: ' || erroHA);
        dbms_output.put_line('Erros no sensor do tipo PA: ' || erroPA);
End;