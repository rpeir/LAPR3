-- FUNCAO QUE ADICIONA SETOR AGRICOLA ATRAVES DAS DESIGNACOES DOS SEUS PARAMENTROS

CREATE OR REPLACE FUNCTION fncAdicionarSetorByDesignacao (
    in_designacaoSA IN SetoresAgricolas.designacaoSetorAgricola%TYPE,
    in_areaSA IN SetoresAgricolas.areaSetorAgricola%TYPE,
    in_designacaoZG IN ZonasGeograficas.designacaoZonaGeografica%TYPE,
    in_designacaoIA IN InstalacoesAgricolas.designacao%TYPE
) RETURN SetoresAgricolas.codSetorAgricola%TYPE

IS l_codSA SetoresAgricolas.codSetorAgricola%TYPE;
    l_codZG ZonasGeograficas.codZonaGeografica%TYPE;
    l_codIA InstalacoesAgricolas.codInstalacaoAgricola%TYPE;
    
BEGIN

    l_codZG := fncGetZonaGeograficaByDesignacao(in_designacaoZG);
    IF l_codZG IS NULL THEN
        RAISE_APPLICATION_ERROR(-20000, 'Não foi encontrada a zona geográfica correspondente.');
    END IF;
    l_codIA:=fncGetInstalacaoAgricolaByDesignacao(in_designacaoIA);
    IF l_codIA IS NULL THEN
        RAISE_APPLICATION_ERROR(-20000, 'Não foi encontrada a instalação agrícola correspondente.');
    END IF;
    INSERT INTO SetoresAgricolas(designacaoSetorAgricola, areaSetorAgricola, codZonaGeografica, codInstalacaoAgricola) VALUES(in_designacaoSA, in_areaSA, l_codZG, l_codIA) RETURNING codSetorAgricola INTO l_codSA;
    RETURN l_codSA;


END;

-- FUNCAO QUE RETORNA O CODIGO DA ZONA GEOGRAFICA ATRAVES DA SUA DESIGNACAO

CREATE OR REPLACE FUNCTION fncGetZonaGeograficaByDesignacao (
    in_designacaoZG IN ZonasGeograficas.designacaoZonaGeografica%TYPE
) RETURN ZonasGeograficas.codZonaGeografica%TYPE

IS l_codZG ZonasGeograficas.codZonaGeografica%TYPE;

BEGIN

    SELECT codZonaGeografica INTO l_codZG FROM ZonasGeograficas WHERE designacaoZonaGeografica = in_designacaoZG;
    RETURN l_codZG;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;
END;

-- FUNCAO QUE RETORNA O CODIGO DA INSTALACAO AGRICOLA ATRAVES DA SUA DESIGNACAO

CREATE OR REPLACE FUNCTION fncGetInstalacaoAgricolaByDesignacao (
    in_designacaoIA IN InstalacoesAgricolas.designacao%TYPE
) RETURN InstalacoesAgricolas.codInstalacaoAgricola%TYPE

IS l_codIA InstalacoesAgricolas.codInstalacaoAgricola%TYPE;

BEGIN

    SELECT codInstalacaoAgricola INTO l_codIA FROM InstalacoesAgricolas WHERE designacao = in_designacaoIA;
    RETURN l_codIA;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RETURN NULL;

END;

-- FUNCAO QUE ADICIONA CULTURA DE UM SETOR AGRICOLA

CREATE OR REPLACE FUNCTION fncAddSetoresAgricolasCulturas (
    in_codSA IN SetoresAgricolas.codSetorAgricola%TYPE,
    in_codC IN Culturas.codCultura%TYPE,
    in_dataPlantacao IN SetoresAgricolas_Culturas.dataPlantacao%TYPE
) RETURN BOOLEAN

IS l_dataPlantacao SetoresAgricolas_Culturas.dataPlantacao%TYPE;

BEGIN

    INSERT INTO SetoresAgricolas_Culturas(codSetorAgricola, codCultura, dataPlantacao) VALUES(in_codSA, in_codC, in_dataPlantacao);
    RETURN TRUE;

EXCEPTION
    WHEN OTHERS THEN
        RETURN FALSE;

END;

-- FUNCAO QUE ADICIONA CULTURA ATRAVES DAS DESIGNACOES DOS SEUS PARAMENTROS

CREATE OR REPLACE FUNCTION fncAddCulturaByDesignacao (
    in_designacaoC IN Culturas.designacaoCultura%TYPE,
    in_tipoC IN Culturas.tipoCultura%TYPE,
    in_objetivoC IN Culturas.objetivoCultura%TYPE,
    in_tempoC IN Culturas.tempoCrescimento%TYPE
) RETURN Culturas.codCultura%TYPE
IS
    l_codC Culturas.codCultura%TYPE;

BEGIN

    INSERT INTO Culturas(designacaoCultura, tipoCultura, objetivoCultura, tempoCrescimento) VALUES(in_designacaoC, in_tipoC, in_objetivoC, in_tempoC) RETURNING codCultura INTO l_codC;
    RETURN l_codC;

END;