create or replace function validateCodTipoSensor(codTipoSensor TiposSensores.codTipoSensor%type) return int
as
    resultado int;
    begin
        Select count(*) into resultado from  TiposSensores tp
            where tp.codTipoSensor like 'HS';

        return resultado;
    end;