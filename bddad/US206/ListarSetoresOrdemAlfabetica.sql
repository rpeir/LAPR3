create or replace procedure listarSetoresOrdemAlfabetica

begin
    SELECT * FROM SetoresAgricolas ORDER BY designacaoSetorAgricola;
    
end listarSetoresOrdemAlfabetica;