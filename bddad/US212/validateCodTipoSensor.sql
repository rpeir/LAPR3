create or replace function validateCodTipoSensor(v_codTipoSensor TiposSensores.codTipoSensor%type) return int
as
    resultado int;
    begin
        Select count(*) into resultado from  TiposSensores tp
            where tp.codTipoSensor like v_codTipoSensor;

        return resultado;
    end;