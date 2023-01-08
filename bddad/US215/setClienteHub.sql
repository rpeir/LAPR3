CREATE OR REPLACE procedure setClienteHub(param_codHub Hub.codHub%type, param_codInterno Clientes.codInterno%type) as
    existente int;
    clienteTest int;
    hubTest int;
    invalidHub exception;
    invalidCliente exception;
Begin
    Begin
        Select count(*) into hubTest from hub where codHub = param_codHub;
        Select count(*) into clienteTest from clientes where codInterno = param_codInterno;
        if hubTest > 0 then
            if clienteTest > 0 then
                Select count(*) into existente from hubCliente  where codInterno = param_codInterno;
                if existente > 0 then
                    UPDATE hubCliente
                        SET codHub = param_codHub
                        WHERE codInterno = param_codInterno;
                else
                    insert into hubCliente (codHub, codInterno) values (param_codHub, param_codInterno);
                end if;
            else
                raise invalidCliente;
            end if;
        else
            raise invalidHub;
        end if;
    End;
exception
    when invalidCliente then
        raise_application_error(-20001,'Cliente invalido');
    when invalidHub then
        raise_application_error(-20002,'Hub invalido');
end;
