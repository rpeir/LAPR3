create or replace function validateCodTipoSensor(codTipoSensor TiposSensores.codTipoSensor%type) return int
as
    resultado int;
begin
Select count(*) into resultado from (
                                        Select * from TiposSensores tp
                                        where tp.codTipoSensor like codTipoSensor
                                    );

return resultado;
end;