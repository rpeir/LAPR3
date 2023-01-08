Create or replace trigger triggerEncomendas
    Before Insert or Update on PEDIDOS
    for each row
    declare
        existente int;
    Begin
        Select count(*) into  existente from Hub where codHub = :new.codHub;
        if existente = 0 then
            raise_application_error(-20001,'Hub invalido');
        end if;
    end;
