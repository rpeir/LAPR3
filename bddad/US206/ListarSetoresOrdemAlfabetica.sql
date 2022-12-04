-- VIEW QUE LISTA OS SETORES POR ORDEM ALFABÉTICA

CREATE OR REPLACE VIEW viewlistarSetoresOrdemAlfabetica AS
    SELECT * FROM SetoresAgricolas sa
    ORDER BY designacaoSetorAgricola;

-- VIEW QUE LISTA OS SETORES POR ORDEM DE TAMANHO, EM ORDEM CRESCENTE

CREATE OR REPLACE VIEW viewlistarSetoresOrdemTamanhoCrescente AS
    SELECT sa.designacaoSetorAgricola, sa.areaSetorAgricola FROM SetoresAgricolas sa
    ORDER BY areaSetorAgricola;

-- VIEW QUE LISTA OS SETORES POR ORDEM DE TAMANHO, EM ORDEM DECRESCENTE

CREATE OR REPLACE VIEW viewlistarSetoresOrdemTamanhoDecrescente AS
    SELECT sa.designacaoSetorAgricola, sa.areaSetorAgricola FROM SetoresAgricolas sa
    ORDER BY areaSetorAgricola DESC;

-- VIEW QUE LISTA OS SETORES POR ORDENADOS POR TIPO DE CULTURA E CULTURA

CREATE OR REPLACE VIEW viewlistarSetoresOrdemTipoCulturaCultura AS
    SELECT sa.designacaoSetorAgricola, cul.tipoCultura, cul.designacaoCultura FROM SetoresAgricolas sa
    INNER JOIN SetoresAgricolas_Culturas sac 
    ON sa.codSetorAgricola = sac.codSetorAgricola
    INNER JOIN Culturas cul
    ON sac.codCultura = cul.codCultura
    ORDER BY cul.tipoCultura, cul.designacaoCultura;