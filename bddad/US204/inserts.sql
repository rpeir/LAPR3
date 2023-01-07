--Tabela Clientes
INSERT INTO clientes(codInterno, tipo, nome, emailCliente, plafond, nrFiscal) VALUES (1, 'P', 'Amanda Myers', 'amandamyers@gmail.com', 45, 123456779);
INSERT INTO clientes(codInterno, tipo, nome, emailCliente, plafond, nrFiscal) VALUES (2, 'P', 'Carla Mendes', 'carlamendes@gmail.com', 45, 123456729);
INSERT INTO clientes(codInterno, tipo, nome, emailCliente, plafond, nrFiscal) VALUES (3, 'P', 'Sergio Guilerme', 'sergioguilherme@gmail.com', 45, 423456789);
INSERT INTO clientes(codInterno, tipo, nome, emailCliente, plafond, nrFiscal) VALUES (4, 'P', 'Semanda Mesa', 'semandamesa@gmail.com', 45, 123456719);
INSERT INTO clientes(codInterno, tipo, nome, emailCliente, plafond, nrFiscal) VALUES (5, 'P', 'Valter Djedje', 'ValterDjeje@gmail.com', 45, 123450789);
INSERT INTO clientes(codInterno, tipo, nome, emailCliente, plafond, nrFiscal) VALUES (6, 'E', 'Aevin', 'aevin@gmail.com', 45, 123456781);
INSERT INTO clientes(codInterno, tipo, nome, emailCliente, plafond, nrFiscal) VALUES (7, 'E', 'lipaf', 'lipaf@gmail.com', 45, 123456785);
INSERT INTO clientes(codInterno, tipo, nome, emailCliente, plafond, nrFiscal) VALUES (8, 'E', 'sobs', 'sobs@gmail.com', 45, 123456788);
INSERT INTO clientes(codInterno, tipo, nome, emailCliente, plafond, nrFiscal) VALUES (9, 'E', 'watters', 'watters@gmail.com', 45, 129456789);
INSERT INTO clientes(codInterno, tipo, nome, emailCliente, plafond, nrFiscal) VALUES (10, 'E', 'vertens', 'vertens@gmail.com', 45, 133456789);

--Tabela Moradas
INSERT INTO moradas(codMorada, rua, nrEdificio, andar, codPostal, localidade, pais) VALUES (1, 'Rua das laranjas', 234, 1, 4200-389, 'Porto', 'Portugal');
INSERT INTO moradas(codMorada, rua, nrEdificio, andar, codPostal, localidade, pais) VALUES (2, 'Rua das macas', 235, 5, 4200-309, 'Porto', 'Portugal');
INSERT INTO moradas(codMorada, rua, nrEdificio, andar, codPostal, localidade, pais) VALUES (3, 'Rua das bananas', 236, 3, 4100-389, 'Porto', 'Portugal');
INSERT INTO moradas(codMorada, rua, nrEdificio, andar, codPostal, localidade, pais) VALUES (4, 'Rua das rosas', 237, 3, 4200-809, 'Porto', 'Portugal');
INSERT INTO moradas(codMorada, rua, nrEdificio, andar, codPostal, localidade, pais) VALUES (5, 'Rua das flores', 238, 2, 4210-389, 'Porto', 'Portugal');
INSERT INTO moradas(codMorada, rua, nrEdificio, andar, codPostal, localidade, pais) VALUES (6, 'Rua das carolinas', 239, 3, 4200-389, 'Porto', 'Portugal');
INSERT INTO moradas(codMorada, rua, nrEdificio, andar, codPostal, localidade, pais) VALUES (7, 'Rua das sementes', 244, 6, 4200-189, 'Porto', 'Portugal');
INSERT INTO moradas(codMorada, rua, nrEdificio, andar, codPostal, localidade, pais) VALUES (8, 'Rua das mesas', 264, 3, 4200-999, 'Porto', 'Portugal');
INSERT INTO moradas(codMorada, rua, nrEdificio, andar, codPostal, localidade, pais) VALUES (9, 'Rua das magoas', 274, 1, 4200-359, 'Porto', 'Portugal');
INSERT INTO moradas(codMorada, rua, nrEdificio, andar, codPostal, localidade, pais) VALUES (10, 'Rua das turanjas', 284, 0, 4200-109, 'Porto', 'Portugal');
INSERT INTO moradas(codMorada, rua, nrEdificio, andar, codPostal, localidade, pais) VALUES (11, 'Rua das tartarugas', 324, 0, 4200-189, 'Porto', 'Portugal');
INSERT INTO moradas(codMorada, rua, nrEdificio, andar, codPostal, localidade, pais) VALUES (12, 'Rua das lagartas', 894, 0,4200-769, 'Porto', 'Portugal');

--Tabela MoradasCorrespondencia
INSERT INTO MoradasCorrespondencia(codInterno, codMorada) VALUES (1, 1);
INSERT INTO MoradasCorrespondencia(codInterno, codMorada) VALUES (2, 2);
INSERT INTO MoradasCorrespondencia(codInterno, codMorada) VALUES (3, 3);
INSERT INTO MoradasCorrespondencia(codInterno, codMorada) VALUES (4, 4);
INSERT INTO MoradasCorrespondencia(codInterno, codMorada) VALUES (5, 5);
INSERT INTO MoradasCorrespondencia(codInterno, codMorada) VALUES (6, 6);
INSERT INTO MoradasCorrespondencia(codInterno, codMorada) VALUES (7, 7);
INSERT INTO MoradasCorrespondencia(codInterno, codMorada) VALUES (8, 8);
INSERT INTO MoradasCorrespondencia(codInterno, codMorada) VALUES (9, 9);
INSERT INTO MoradasCorrespondencia(codInterno, codMorada) VALUES (10, 10);

--Tabela MoradasEntrega
INSERT INTO MoradasEntrega(codInterno, codMorada) VALUES (1, 1);
INSERT INTO MoradasEntrega(codInterno, codMorada) VALUES (2, 2);
INSERT INTO MoradasEntrega(codInterno, codMorada) VALUES (3, 3);
INSERT INTO MoradasEntrega(codInterno, codMorada) VALUES (4, 4);
INSERT INTO MoradasEntrega(codInterno, codMorada) VALUES (5, 5);
INSERT INTO MoradasEntrega(codInterno, codMorada) VALUES (6, 6);
INSERT INTO MoradasEntrega(codInterno, codMorada) VALUES (7, 7);
INSERT INTO MoradasEntrega(codInterno, codMorada) VALUES (8, 8);
INSERT INTO MoradasEntrega(codInterno, codMorada) VALUES (9, 9);
INSERT INTO MoradasEntrega(codInterno, codMorada) VALUES (10, 10);


--Tabela Niveis
INSERT INTO niveis(codNivel, designacaoNivel) VALUES (1, 'A'); 
INSERT INTO niveis(codNivel, designacaoNivel) VALUES (2, 'B'); 
INSERT INTO niveis(codNivel, designacaoNivel) VALUES (3, 'C'); 

--Tabela Cliente_Niveis
INSERT INTO Clientes_niveis(codInterno, codNivel, dataAtribuicao) VALUES (1, 1, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO Clientes_niveis(codInterno, codNivel, dataAtribuicao) VALUES (2, 1, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO Clientes_niveis(codInterno, codNivel, dataAtribuicao) VALUES (3, 3, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO Clientes_niveis(codInterno, codNivel, dataAtribuicao) VALUES (4, 1, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO Clientes_niveis(codInterno, codNivel, dataAtribuicao) VALUES (5, 1, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO Clientes_niveis(codInterno, codNivel, dataAtribuicao) VALUES (6, 2, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO Clientes_niveis(codInterno, codNivel, dataAtribuicao) VALUES (7, 1, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO Clientes_niveis(codInterno, codNivel, dataAtribuicao) VALUES (8, 1, TO_DATE('21/Abril/2021','DD/MON/YY'));
INSERT INTO Clientes_niveis(codInterno, codNivel, dataAtribuicao) VALUES (8, 2, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO Clientes_niveis(codInterno, codNivel, dataAtribuicao) VALUES (8, 3, TO_DATE('23/Abril/2021','DD/MON/YY'));
INSERT INTO Clientes_niveis(codInterno, codNivel, dataAtribuicao) VALUES (9, 3, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO Clientes_niveis(codInterno, codNivel, dataAtribuicao) VALUES (10, 1, TO_DATE('22/Abril/2021','DD/MON/YY'));

--Tabela Pedidos
INSERT INTO pedidos(codPedido, codInterno, valorTotal, dataPedido, dataVencimento) VALUES (1, 1, 45, TO_DATE('22/Abril/2022','DD/MON/YY'), TO_DATE('29/Abril/2022','DD/MON/YY'));
INSERT INTO pedidos(codPedido, codInterno, valorTotal, dataPedido, dataVencimento) VALUES (2, 2, 450, TO_DATE('22/Maio/2022','DD/MON/YY'), TO_DATE('29/Maio/2022','DD/MON/YY'));
INSERT INTO pedidos(codPedido, codInterno, valorTotal, dataPedido, dataVencimento) VALUES (3, 1, 440, TO_DATE('12/Abril/2022','DD/MON/YY'), TO_DATE('29/Abril/2022','DD/MON/YY'));
INSERT INTO pedidos(codPedido, codInterno, valorTotal, dataPedido, dataVencimento) VALUES (4, 4, 550, TO_DATE('20/Outubro/2022','DD/MON/YY'), TO_DATE('29/Outubro/2022','DD/MON/YY'));
INSERT INTO pedidos(codPedido, codInterno, valorTotal, dataPedido, dataVencimento) VALUES (5, 5, 150, TO_DATE('11/Abril/2022','DD/MON/YY'), TO_DATE('19/Abril/2022','DD/MON/YY'));
INSERT INTO pedidos(codPedido, codInterno, valorTotal, dataPedido, dataVencimento) VALUES (6, 5, 750, TO_DATE('15/Maio/2022','DD/MON/YY'), TO_DATE('22/Maio/2022', 'DD/MON/YY'));
INSERT INTO pedidos(codPedido, codInterno, valorTotal, dataPedido, dataVencimento) VALUES (7, 7, 850, TO_DATE('12/Fevereiro/2022','DD/MON/YY'), TO_DATE('29/Abril/2022','DD/MON/YY'));
INSERT INTO pedidos(codPedido, codInterno, valorTotal, dataPedido, dataVencimento) VALUES (8, 9, 50, TO_DATE('10/Janeiro/2022','DD/MON/YY'), TO_DATE('17/Janeiro/2022','DD/MON/YY'));
INSERT INTO pedidos(codPedido, codInterno, valorTotal, dataPedido, dataVencimento) VALUES (9, 10, 1450, TO_DATE('13/Abril/2022','DD/MON/YY'), TO_DATE('20/Abril/2022','DD/MON/YY'));
INSERT INTO pedidos(codPedido, codInterno, valorTotal, dataPedido, dataVencimento) VALUES (10, 10, 250, TO_DATE('20/Agosto/2022','DD/MON/YY'), TO_DATE('27/Agosto/2022','DD/MON/YY'));

--Tabela Pagamentos
INSERT INTO pagamentos(codPagamento, dataPagamento) VALUES (1, TO_DATE('22/Abril/2022','DD/MON/YY')); 
INSERT INTO pagamentos(codPagamento, dataPagamento) VALUES (2, TO_DATE('22/Outubro/2022','DD/MON/YY')); 
INSERT INTO pagamentos(codPagamento, dataPagamento) VALUES (3, TO_DATE('22/Outubro/2022','DD/MON/YY')); 
INSERT INTO pagamentos(codPagamento, dataPagamento) VALUES (4, TO_DATE('22/Outubro/2022','DD/MON/YY')); 
INSERT INTO pagamentos(codPagamento, dataPagamento) VALUES (5, TO_DATE('13/Abril/2022','DD/MON/YY')); 
INSERT INTO pagamentos(codPagamento, dataPagamento) VALUES (6, TO_DATE('17/Maio/2022','DD/MON/YY')); 
INSERT INTO pagamentos(codPagamento, dataPagamento) VALUES (7, TO_DATE('17/Fevereiro/2022','DD/MON/YY')); 
INSERT INTO pagamentos(codPagamento, dataPagamento) VALUES (8, TO_DATE('10/Janeiro/2022','DD/MON/YY')); 
INSERT INTO pagamentos(codPagamento, dataPagamento) VALUES (9, TO_DATE('14/Abril/2022','DD/MON/YY')); 
INSERT INTO pagamentos(codPagamento, dataPagamento) VALUES (10, TO_DATE('22/Agosto/2022','DD/MON/YY')); 

--Tabela Colheitas
INSERT INTO colheitas(codColheita, anoColheita) VALUES (1, 2022);
INSERT INTO colheitas(codColheita, anoColheita) VALUES (2, 2020);
INSERT INTO colheitas(codColheita, anoColheita) VALUES (3, 2021);
INSERT INTO colheitas(codColheita, anoColheita) VALUES (4, 2022);
INSERT INTO colheitas(codColheita, anoColheita) VALUES (5, 2019);

--Tabela Culturas
INSERT INTO culturas(codCultura, designacaoCultura, tipoCultura, objetivoCultura, tempoCrescimento) VALUES( 1, 'Bananeira', 'P', 'C', 190);
INSERT INTO culturas(codCultura, designacaoCultura, tipoCultura, objetivoCultura, tempoCrescimento) VALUES( 2, 'Laranjeira', 'P', 'C', 190);
INSERT INTO culturas(codCultura, designacaoCultura, tipoCultura, objetivoCultura, tempoCrescimento) VALUES( 3, 'Maciera', 'P', 'C', 190);
INSERT INTO culturas(codCultura, designacaoCultura, tipoCultura, objetivoCultura, tempoCrescimento) VALUES( 4, 'Mangueira', 'P', 'C', 190);
INSERT INTO culturas(codCultura, designacaoCultura, tipoCultura, objetivoCultura, tempoCrescimento) VALUES( 5, 'Abacateira', 'P', 'C', 90);
INSERT INTO culturas(codCultura, designacaoCultura, tipoCultura, objetivoCultura, tempoCrescimento) VALUES( 6, 'Couve', 'T', 'C', 90);
INSERT INTO culturas(codCultura, designacaoCultura, tipoCultura, objetivoCultura, tempoCrescimento) VALUES( 7, 'Alface', 'T', 'C', 90);
INSERT INTO culturas(codCultura, designacaoCultura, tipoCultura, objetivoCultura, tempoCrescimento) VALUES( 8, 'Centeio', 'T', 'AC', 90);
INSERT INTO culturas(codCultura, designacaoCultura, tipoCultura, objetivoCultura, tempoCrescimento) VALUES( 9, 'Milho', 'T', 'C', 90);
INSERT INTO culturas(codCultura, designacaoCultura, tipoCultura, objetivoCultura, tempoCrescimento) VALUES( 10, 'Soja', 'T', 'C', 90);

--Tabela InstalacoesAgricolas
INSERT INTO instalacoesAgricolas(codInstalacaoAgricola, codMorada, designacao) VALUES (1, 11, 'Quinta Mendes');
INSERT INTO instalacoesAgricolas(codInstalacaoAgricola, codMorada, designacao) VALUES (2, 12, 'Quinta Semedo');

--Tabela ZonasGeograficas
INSERT INTO zonasGeograficas(codZonaGeografica, codInstalacaoAgricola, designacaoZonaGeografica) VALUES (1,1, 'Zona Norte');
INSERT INTO zonasGeograficas(codZonaGeografica, codInstalacaoAgricola, designacaoZonaGeografica) VALUES (2,2, 'Zona Norte');
INSERT INTO zonasGeograficas(codZonaGeografica, codInstalacaoAgricola, designacaoZonaGeografica) VALUES (3,1, 'Zona Sul');
INSERT INTO zonasGeograficas(codZonaGeografica, codInstalacaoAgricola, designacaoZonaGeografica) VALUES (4,2, 'Zona Sul');
INSERT INTO zonasGeograficas(codZonaGeografica, codInstalacaoAgricola, designacaoZonaGeografica) VALUES (5,1, 'Zona Este');
INSERT INTO zonasGeograficas(codZonaGeografica, codInstalacaoAgricola, designacaoZonaGeografica) VALUES (6,2, 'Zona Este');
INSERT INTO zonasGeograficas(codZonaGeografica, codInstalacaoAgricola, designacaoZonaGeografica) VALUES (7,1, 'Zona Oeste');
INSERT INTO zonasGeograficas(codZonaGeografica, codInstalacaoAgricola, designacaoZonaGeografica) VALUES (8,2, 'Zona Oeste');

--Tabela SertoresAgricolas
INSERT INTO setoresAgricolas(codSetorAgricola, codZonaGeografica, designacaoSetorAgricola, areaSetorAgricola) VALUES (1, 1, 'QMZN1',250);
INSERT INTO setoresAgricolas(codSetorAgricola, codZonaGeografica, designacaoSetorAgricola, areaSetorAgricola) VALUES (2, 1, 'QMZN2',250);
INSERT INTO setoresAgricolas(codSetorAgricola, codZonaGeografica, designacaoSetorAgricola, areaSetorAgricola) VALUES (3, 1, 'QMZN3',250);

INSERT INTO setoresAgricolas(codSetorAgricola, codZonaGeografica, designacaoSetorAgricola, areaSetorAgricola) VALUES (4, 2, 'QSZN1',250);
INSERT INTO setoresAgricolas(codSetorAgricola, codZonaGeografica, designacaoSetorAgricola, areaSetorAgricola) VALUES (5, 2, 'QSZN2',250);
INSERT INTO setoresAgricolas(codSetorAgricola, codZonaGeografica, designacaoSetorAgricola, areaSetorAgricola) VALUES (6, 2, 'QSZN3',250);

INSERT INTO setoresAgricolas(codSetorAgricola, codZonaGeografica, designacaoSetorAgricola, areaSetorAgricola) VALUES (7, 3, 'QMZS1',250);
INSERT INTO setoresAgricolas(codSetorAgricola, codZonaGeografica, designacaoSetorAgricola, areaSetorAgricola) VALUES (8, 3, 'QMZS2',250);
INSERT INTO setoresAgricolas(codSetorAgricola, codZonaGeografica, designacaoSetorAgricola, areaSetorAgricola) VALUES (9, 3, 'QMZS3',250);

INSERT INTO setoresAgricolas(codSetorAgricola, codZonaGeografica, designacaoSetorAgricola, areaSetorAgricola) VALUES (10, 4, 'QSZS',250);
INSERT INTO setoresAgricolas(codSetorAgricola, codZonaGeografica, designacaoSetorAgricola, areaSetorAgricola) VALUES (11, 4, 'QSZS',250);
INSERT INTO setoresAgricolas(codSetorAgricola, codZonaGeografica, designacaoSetorAgricola, areaSetorAgricola) VALUES (12, 2, 'QSZS3',250);

--Tabela Produtos
INSERT INTO produtos(codProduto, codCultura, precoKg, stockKg, designacaoProduto) VALUES (1, 1, 20, 500, 'banana');
INSERT INTO produtos(codProduto, codCultura, precoKg, stockKg, designacaoProduto) VALUES (2, 2, 20, 500, 'laranja');
INSERT INTO produtos(codProduto, codCultura, precoKg, stockKg, designacaoProduto) VALUES (3, 3, 30, 500, 'maca');
INSERT INTO produtos(codProduto, codCultura, precoKg, stockKg, designacaoProduto) VALUES (4, 4, 40, 500, 'manga');
INSERT INTO produtos(codProduto, codCultura, precoKg, stockKg, designacaoProduto) VALUES (5, 5, 50, 500, 'abacate');
INSERT INTO produtos(codProduto, codCultura, precoKg, stockKg, designacaoProduto) VALUES (6, 6, 60, 500, 'couve');
INSERT INTO produtos(codProduto, codCultura, precoKg, stockKg, designacaoProduto) VALUES (7, 7, 70, 500, 'alface');


--Tabela Pedidos_Produtos
INSERT INTO Pedidos_Produtos(codPedido, codProduto, quantidadeProduto, precoPedido) VALUES (1, 1, 10, 200);
INSERT INTO Pedidos_Produtos(codPedido, codProduto, quantidadeProduto, precoPedido) VALUES (1, 4, 1, 40);
INSERT INTO Pedidos_Produtos(codPedido, codProduto, quantidadeProduto, precoPedido) VALUES (2, 1, 50, 100);
INSERT INTO Pedidos_Produtos(codPedido, codProduto, quantidadeProduto, precoPedido) VALUES (2, 2, 50, 100);
INSERT INTO Pedidos_Produtos(codPedido, codProduto, quantidadeProduto, precoPedido) VALUES (3, 1, 70, 70);
INSERT INTO Pedidos_Produtos(codPedido, codProduto, quantidadeProduto, precoPedido) VALUES (3, 3, 10, 300);

--Tabela Entregas
INSERT INTO Entregas(codEntrega, codMorada, dataEntrega) VALUES (1, 1, TO_DATE('22/Abril/2022','DD/MON/YY'));
INSERT INTO Entregas(codEntrega, codMorada, dataEntrega) VALUES (2, 2, TO_DATE('29/Maio/2022','DD/MON/YY'));
INSERT INTO Entregas(codEntrega, codMorada, dataEntrega) VALUES (3, 3, TO_DATE('29/Abril/2022','DD/MON/YY'));
INSERT INTO Entregas(codEntrega, codMorada, dataEntrega) VALUES (4, 4, TO_DATE('29/Outubro/2022','DD/MON/YY'));
INSERT INTO Entregas(codEntrega, codMorada, dataEntrega) VALUES (8, 8, TO_DATE('17/Janeiro/2022','DD/MON/YY'));

--Tabela Pedidos_Pagamentos_Entregas
INSERT INTO Pedidos_Pagamentos_Entregas(codPedido, codPagamento, codEntrega, estadoAtual) VALUES (1, 1, 1, 'E');
INSERT INTO Pedidos_Pagamentos_Entregas(codPedido, codPagamento, codEntrega, estadoAtual) VALUES (2, 1, 1, 'R');
INSERT INTO Pedidos_Pagamentos_Entregas(codPedido, codPagamento, codEntrega, estadoAtual) VALUES (3, 1, 1, 'R');
INSERT INTO Pedidos_Pagamentos_Entregas(codPedido, codPagamento, codEntrega, estadoAtual) VALUES (5, 1, 1, 'P');

--Tabela Incidentes
INSERT INTO INCIDENTES(codIncidente, codPedido, codInterno, codPagamento, dataOcorrencia) VALUES (1, 1, 1, 1, TO_DATE('22/Abril/2022','DD/MON/YY'));
INSERT INTO INCIDENTES(codIncidente, codPedido, codInterno, codPagamento, dataOcorrencia) VALUES (2, 2, 2, 2, TO_DATE('31/Maio/2022','DD/MON/YY'));
INSERT INTO INCIDENTES(codIncidente, codPedido, codInterno, codPagamento, dataOcorrencia) VALUES (3, 3, 3, 3, TO_DATE('30/Abril/2022','DD/MON/YY'));

--Tabela Colheitas_Culturas
INSERT INTO Colheitas_Culturas(codColheita, codCultura, valorTotalColheita) VALUES (1, 1, 1000);
INSERT INTO Colheitas_Culturas(codColheita, codCultura, valorTotalColheita) VALUES (1, 2, 1000);
INSERT INTO Colheitas_Culturas(codColheita, codCultura, valorTotalColheita) VALUES (1, 4, 1000);
INSERT INTO Colheitas_Culturas(codColheita, codCultura, valorTotalColheita) VALUES (2, 3, 1000);
INSERT INTO Colheitas_Culturas(codColheita, codCultura, valorTotalColheita) VALUES (2, 2, 1000);
INSERT INTO Colheitas_Culturas(codColheita, codCultura, valorTotalColheita) VALUES (3, 1, 1000);

--Tabela SetoresAgricolas_Culturas
INSERT INTO SetoresAgricolas_Culturas(codSetorAgricola, codCultura, dataPlantacao) VALUES (1, 1, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO SetoresAgricolas_Culturas(codSetorAgricola, codCultura, dataPlantacao) VALUES (1, 1, TO_DATE('22/Abril/2022','DD/MON/YY'));
INSERT INTO SetoresAgricolas_Culturas(codSetorAgricola, codCultura, dataPlantacao) VALUES (2, 1, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO SetoresAgricolas_Culturas(codSetorAgricola, codCultura, dataPlantacao) VALUES (3, 1, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO SetoresAgricolas_Culturas(codSetorAgricola, codCultura, dataPlantacao) VALUES (1, 2, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO SetoresAgricolas_Culturas(codSetorAgricola, codCultura, dataPlantacao) VALUES (2, 2, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO SetoresAgricolas_Culturas(codSetorAgricola, codCultura, dataPlantacao) VALUES (5, 1, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO SetoresAgricolas_Culturas(codSetorAgricola, codCultura, dataPlantacao) VALUES (5, 2, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO SetoresAgricolas_Culturas(codSetorAgricola, codCultura, dataPlantacao) VALUES (7, 1, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO SetoresAgricolas_Culturas(codSetorAgricola, codCultura, dataPlantacao) VALUES (8, 1, TO_DATE('22/Abril/2021','DD/MON/YY'));
INSERT INTO SetoresAgricolas_Culturas(codSetorAgricola, codCultura, dataPlantacao) VALUES (8, 3, TO_DATE('22/Abril/2021','DD/MON/YY'));

--Tabela PlanosAnuais
INSERT INTO PlanosAnuais (anoPlanoAnual) VALUES (2019);
INSERT INTO PlanosAnuais (anoPlanoAnual) VALUES (2020);
INSERT INTO PlanosAnuais (anoPlanoAnual) VALUES (2021);
INSERT INTO PlanosAnuais (anoPlanoAnual) VALUES (2022);

--Tabela CalendariosOperacoes
INSERT INTO CalendariosOperacoes (codCalendarioOperacoes, anoCalendarioOperacoes) VALUES (1, 2019);
INSERT INTO CalendariosOperacoes (codCalendarioOperacoes, anoCalendarioOperacoes) VALUES (2, 2020);
INSERT INTO CalendariosOperacoes (codCalendarioOperacoes, anoCalendarioOperacoes) VALUES (3, 2021);
INSERT INTO CalendariosOperacoes (codCalendarioOperacoes, anoCalendarioOperacoes) VALUES (4, 2022);

--Tabela Operacoes
INSERT INTO operacoes( codOperacao, anoPlanoAnual, codCalendarioOperacoes, dataPrevistaPlano, dataOperacao, formaAplicacao, estadoOperacao) VALUES (1, 2021,3, TO_DATE('22/Abril/2021','DD/MON/YY'), TO_DATE('22/Abril/2021','DD/MON/YY'), 'FR', 'M');
INSERT INTO operacoes( codOperacao, anoPlanoAnual, codCalendarioOperacoes, dataPrevistaPlano, dataOperacao, formaAplicacao, estadoOperacao) VALUES (2, 2021,3, TO_DATE('25/Abril/2021','DD/MON/YY'), TO_DATE('25/Abril/2021','DD/MON/YY'), 'F', 'M');
INSERT INTO operacoes( codOperacao, anoPlanoAnual, codCalendarioOperacoes, dataPrevistaPlano, dataOperacao, formaAplicacao, estadoOperacao) VALUES (3, 2021,3, TO_DATE('26/Abril/2021','DD/MON/YY'), TO_DATE('26/Abril/2021','DD/MON/YY'), 'FR', 'M');
INSERT INTO operacoes( codOperacao, anoPlanoAnual, codCalendarioOperacoes, dataPrevistaPlano, dataOperacao, formaAplicacao, estadoOperacao) VALUES (4, 2021,3, TO_DATE('27/Abril/2021','DD/MON/YY'), TO_DATE('27/Abril/2021','DD/MON/YY'), 'S', 'C');
INSERT INTO operacoes( codOperacao, anoPlanoAnual, codCalendarioOperacoes, dataPrevistaPlano, dataOperacao, formaAplicacao, estadoOperacao) VALUES (5, 2021,3, TO_DATE('28/Abril/2021','DD/MON/YY'), TO_DATE('28/Abril/2021','DD/MON/YY'), 'S', 'C');

--Tabela Regas
INSERT INTO regas(codRega, codOperacao, tempoRega) VALUES (1,1,60);
INSERT INTO regas(codRega, codOperacao, tempoRega) VALUES (2,2,60);
INSERT INTO regas(codRega, codOperacao, tempoRega) VALUES (3,3,60);
INSERT INTO regas(codRega, codOperacao, tempoRega) VALUES (4,4,60);
INSERT INTO regas(codRega, codOperacao, tempoRega) VALUES (5,5,60);

--Tabela AplicacaoRegas
INSERT INTO AplicacaoRegas(codRega, codCultura, codSetorAgricola, tipoRega) VALUES (1, 1, 1, 'G');
INSERT INTO AplicacaoRegas(codRega, codCultura, codSetorAgricola, tipoRega) VALUES (2, 2, 2, 'G');
INSERT INTO AplicacaoRegas(codRega, codCultura, codSetorAgricola, tipoRega) VALUES (3, 3, 3, 'G');
INSERT INTO AplicacaoRegas(codRega, codCultura, codSetorAgricola, tipoRega) VALUES (4, 4, 4, 'G');
INSERT INTO AplicacaoRegas(codRega, codCultura, codSetorAgricola, tipoRega) VALUES (5, 5, 5, 'G');

--Tabela PlanosRega
INSERT INTO PlanosRega (anoPlanoAnual, codSetorAgricola, codCultura, codRega) VALUES (2021, 1, 1, 1);
INSERT INTO PlanosRega (anoPlanoAnual, codSetorAgricola, codCultura, codRega) VALUES (2021, 1, 1, 2);
INSERT INTO PlanosRega (anoPlanoAnual, codSetorAgricola, codCultura, codRega) VALUES (2021, 2, 1, 3);
INSERT INTO PlanosRega (anoPlanoAnual, codSetorAgricola, codCultura, codRega) VALUES (2021, 3, 1, 1);
INSERT INTO PlanosRega (anoPlanoAnual, codSetorAgricola, codCultura, codRega) VALUES (2021, 1, 2, 2);
INSERT INTO PlanosRega (anoPlanoAnual, codSetorAgricola, codCultura, codRega) VALUES (2021, 5, 1, 3);
INSERT INTO PlanosRega (anoPlanoAnual, codSetorAgricola, codCultura, codRega) VALUES (2021, 7, 1, 3);
INSERT INTO PlanosRega (anoPlanoAnual, codSetorAgricola, codCultura, codRega) VALUES (2021, 8, 1, 2);

--Tabela Culturas_Regas
INSERT INTO Culturas_Regas(codCultura, codRega, tipoDistribuicao) VALUES (1, 1, 'G');
INSERT INTO Culturas_Regas(codCultura, codRega, tipoDistribuicao) VALUES (1, 2, 'G');
INSERT INTO Culturas_Regas(codCultura, codRega, tipoDistribuicao) VALUES (1, 3, 'A');
INSERT INTO Culturas_Regas(codCultura, codRega, tipoDistribuicao) VALUES (2, 2, 'G');
INSERT INTO Culturas_Regas(codCultura, codRega, tipoDistribuicao) VALUES (2, 3, 'G');

--Tabela PlanosAnuais_SetoresAgricolas
INSERT INTO PlanosAnuais_SetoresAgricolas(anoPlanoAnual, codSetorAgricola, ordemRega, periodicidadeRegaSetor) VALUES (4, 1, 1, 5);
INSERT INTO PlanosAnuais_SetoresAgricolas(anoPlanoAnual, codSetorAgricola, ordemRega, periodicidadeRegaSetor) VALUES (4, 2, 2, 5);
INSERT INTO PlanosAnuais_SetoresAgricolas(anoPlanoAnual, codSetorAgricola, ordemRega, periodicidadeRegaSetor) VALUES (4, 3, 3, 5);
INSERT INTO PlanosAnuais_SetoresAgricolas(anoPlanoAnual, codSetorAgricola, ordemRega, periodicidadeRegaSetor) VALUES (4, 4, 4, 5);
INSERT INTO PlanosAnuais_SetoresAgricolas(anoPlanoAnual, codSetorAgricola, ordemRega, periodicidadeRegaSetor) VALUES (4, 5, 5, 5);

--Tabela FatoresProducao
INSERT INTO FatoresProducao(codFatorProducao, tipoFatorProducao, precoKg, nomeComercial, formulacao) VALUES ( 1, 'FE', 45, 'FP1', 'G');
INSERT INTO FatoresProducao(codFatorProducao, tipoFatorProducao, precoKg, nomeComercial, formulacao) VALUES ( 2, 'AD', 45, 'FP2', 'G');
INSERT INTO FatoresProducao(codFatorProducao, tipoFatorProducao, precoKg, nomeComercial, formulacao) VALUES ( 3, 'CO', 45, 'FP3', 'G');
INSERT INTO FatoresProducao(codFatorProducao, tipoFatorProducao, precoKg, nomeComercial, formulacao) VALUES ( 4, 'FE', 95, 'FP4', 'G');
INSERT INTO FatoresProducao(codFatorProducao, tipoFatorProducao, precoKg, nomeComercial, formulacao) VALUES ( 5, 'FI', 15, 'FP5', 'G');
INSERT INTO FatoresProducao(codFatorProducao, tipoFatorProducao, precoKg, nomeComercial, formulacao) VALUES ( 6, 'FI', 450, 'FP6', 'G');
INSERT INTO FatoresProducao(codFatorProducao, tipoFatorProducao, precoKg, nomeComercial, formulacao) VALUES ( 7, 'AD', 34, 'FP7', 'G');


--Tabela AplicacaoFatorProducao
INSERT INTO AplicacaoFatorProducao( codOperacao, codFatorProducao, codSetorAgricola, codCultura, qtFatorProducao) VALUES ( 1, 1, 1, 1, 100);
INSERT INTO AplicacaoFatorProducao( codOperacao, codFatorProducao, codSetorAgricola, codCultura, qtFatorProducao) VALUES ( 2, 2, 2, 1, 100);
INSERT INTO AplicacaoFatorProducao( codOperacao, codFatorProducao, codSetorAgricola, codCultura, qtFatorProducao) VALUES ( 3, 3, 3, 1, 100);
INSERT INTO AplicacaoFatorProducao( codOperacao, codFatorProducao, codSetorAgricola, codCultura, qtFatorProducao) VALUES ( 4, 1, 8, 1, 100);
INSERT INTO AplicacaoFatorProducao( codOperacao, codFatorProducao, codSetorAgricola, codCultura, qtFatorProducao) VALUES ( 5, 1, 5, 1, 100);

--Tabela SetoresAgricolas_Colheitas_Culturas
INSERT INTO SetoresAgricolas_Colheitas_Culturas( codSetorAgricola, codColheita, codCultura, valorSetor) VALUES (1, 2, 4, 100);
INSERT INTO SetoresAgricolas_Colheitas_Culturas( codSetorAgricola, codColheita, codCultura, valorSetor) VALUES (1, 1, 1, 100);
INSERT INTO SetoresAgricolas_Colheitas_Culturas( codSetorAgricola, codColheita, codCultura, valorSetor) VALUES (2, 2, 1, 100);
INSERT INTO SetoresAgricolas_Colheitas_Culturas( codSetorAgricola, codColheita, codCultura, valorSetor) VALUES (1, 2, 2, 100);
INSERT INTO SetoresAgricolas_Colheitas_Culturas( codSetorAgricola, codColheita, codCultura, valorSetor) VALUES (1, 1, 3, 100);


--Tabela Edificios
INSERT INTO EDIFICIOS (codEdificio, codInstalacaoAgricola, tipoEdificio) VALUES (1, 1, 'G');
INSERT INTO EDIFICIOS (codEdificio, codInstalacaoAgricola, tipoEdificio) VALUES (2, 1, 'A');
INSERT INTO EDIFICIOS (codEdificio, codInstalacaoAgricola, tipoEdificio) VALUES (3, 1, 'R');
INSERT INTO EDIFICIOS (codEdificio, codInstalacaoAgricola, tipoEdificio) VALUES (4, 1, 'E');
INSERT INTO EDIFICIOS (codEdificio, codInstalacaoAgricola, tipoEdificio) VALUES (5, 2, 'G');
INSERT INTO EDIFICIOS (codEdificio, codInstalacaoAgricola, tipoEdificio) VALUES (6, 2, 'A');
INSERT INTO EDIFICIOS (codEdificio, codInstalacaoAgricola, tipoEdificio) VALUES (7, 2, 'R');
INSERT INTO EDIFICIOS (codEdificio, codInstalacaoAgricola, tipoEdificio) VALUES (8, 2, 'E');


--Tabela Restricoes
INSERT INTO Restricoes (codZonaGeografica, codFatorProducao, dataInicio, dataFim) VALUES (1, 1, TO_DATE('22/Abril/2021','DD/MON/YY'), TO_DATE('22/Maio/2021','DD/MON/YY'));
INSERT INTO Restricoes (codZonaGeografica, codFatorProducao, dataInicio, dataFim) VALUES (2, 1, TO_DATE('22/Abril/2021','DD/MON/YY'), TO_DATE('22/Maio/2021','DD/MON/YY'));
INSERT INTO Restricoes (codZonaGeografica, codFatorProducao, dataInicio, dataFim) VALUES (3, 2, TO_DATE('22/Abril/2021','DD/MON/YY'), TO_DATE('22/Maio/2021','DD/MON/YY'));
INSERT INTO Restricoes (codZonaGeografica, codFatorProducao, dataInicio, dataFim) VALUES (4, 3, TO_DATE('22/Abril/2021','DD/MON/YY'), TO_DATE('22/Maio/2021','DD/MON/YY'));
INSERT INTO Restricoes (codZonaGeografica, codFatorProducao, dataInicio, dataFim) VALUES (5, 2, TO_DATE('22/Abril/2021','DD/MON/YY'), TO_DATE('22/Maio/2021','DD/MON/YY'));

--Tabela Tipos Sensores
INSERT INTO TiposSensores( codTipoSensor) VALUES ('HS'); 
INSERT INTO TiposSensores( codTipoSensor) VALUES ('PI'); 
INSERT INTO TiposSensores( codTipoSensor) VALUES ('TS'); 
INSERT INTO TiposSensores( codTipoSensor) VALUES ('VV'); 
INSERT INTO TiposSensores( codTipoSensor) VALUES ('TA'); 
INSERT INTO TiposSensores( codTipoSensor) VALUES ('HA'); 
INSERT INTO TiposSensores( codTipoSensor) VALUES ('PA'); 

--Tabela EstacoesMeteorologicas
INSERT INTO EstacoesMeteorologicas( codEstacaoMeteorologica, codZonaGeografica) VALUES (1, 1);
INSERT INTO EstacoesMeteorologicas( codEstacaoMeteorologica, codZonaGeografica) VALUES (2, 2);
INSERT INTO EstacoesMeteorologicas( codEstacaoMeteorologica, codZonaGeografica) VALUES (3, 3);
INSERT INTO EstacoesMeteorologicas( codEstacaoMeteorologica, codZonaGeografica) VALUES (4, 4);
INSERT INTO EstacoesMeteorologicas( codEstacaoMeteorologica, codZonaGeografica) VALUES (5, 5);
INSERT INTO EstacoesMeteorologicas( codEstacaoMeteorologica, codZonaGeografica) VALUES (6, 6);
INSERT INTO EstacoesMeteorologicas( codEstacaoMeteorologica, codZonaGeografica) VALUES (7, 7);
INSERT INTO EstacoesMeteorologicas( codEstacaoMeteorologica, codZonaGeografica) VALUES (8, 8);

--Tabela Sensores
INSERT INTO Sensores( idSensor, codTipoSensor, codEstacaoMeteorologica, valorReferencia) VALUES ('1', 'HS', 1, 1);
INSERT INTO Sensores( idSensor, codTipoSensor, codEstacaoMeteorologica, valorReferencia) VALUES ('2', 'HS', 2, 2);
INSERT INTO Sensores( idSensor, codTipoSensor, codEstacaoMeteorologica, valorReferencia) VALUES ('3', 'HS', 3, 3);
INSERT INTO Sensores( idSensor, codTipoSensor, codEstacaoMeteorologica, valorReferencia) VALUES ('4', 'TS', 1, 4);
INSERT INTO Sensores( idSensor, codTipoSensor, codEstacaoMeteorologica, valorReferencia) VALUES ('5', 'PA', 1, 5);
INSERT INTO Sensores( idSensor, codTipoSensor, codEstacaoMeteorologica, valorReferencia) VALUES ('6', 'HS', 3, 6);
INSERT INTO Sensores( idSensor, codTipoSensor, codEstacaoMeteorologica, valorReferencia) VALUES ('7', 'HS', 4, 7);

--Tabela Leituras
INSERT INTO Leituras (codLeitura, idSensor, instanteLeitura, valorLido) VALUES (1, 1, TO_DATE('22/Maio/2021','DD/MON/YY'), 100);
INSERT INTO Leituras (codLeitura, idSensor, instanteLeitura, valorLido) VALUES (2, 2, TO_DATE('22/Maio/2021','DD/MON/YY'), 100);
INSERT INTO Leituras (codLeitura, idSensor, instanteLeitura, valorLido) VALUES (3, 3, TO_DATE('22/Maio/2021','DD/MON/YY'), 100);
INSERT INTO Leituras (codLeitura, idSensor, instanteLeitura, valorLido) VALUES (4, 4, TO_DATE('22/Maio/2021','DD/MON/YY'), 100);
INSERT INTO Leituras (codLeitura, idSensor, instanteLeitura, valorLido) VALUES (5, 5, TO_DATE('22/Maio/2021','DD/MON/YY'), 100);

--Tabela FichasTecnicas
INSERT INTO FichasTecnicas( codFichaTecnica, codFatorProducao) VALUES (1,1);
INSERT INTO FichasTecnicas( codFichaTecnica, codFatorProducao) VALUES (2,2);
INSERT INTO FichasTecnicas( codFichaTecnica, codFatorProducao) VALUES (3,3);
INSERT INTO FichasTecnicas( codFichaTecnica, codFatorProducao) VALUES (4,4);
INSERT INTO FichasTecnicas( codFichaTecnica, codFatorProducao) VALUES (5,5);

--Table Componentes
INSERT INTO Componentes ( codComponente, substancia, categoria) VALUES (1, 'Nitrogenio', 'Solido');
INSERT INTO Componentes ( codComponente, substancia, categoria) VALUES (2, 'Sodio', 'Liquido');
INSERT INTO Componentes ( codComponente, substancia, categoria) VALUES (3, 'Bromo', 'Vapor');
INSERT INTO Componentes ( codComponente, substancia, categoria) VALUES (4, 'Ferro', 'Verde');

--Table FichasTecnicas_Componentes
INSERT INTO FichasTecnicas_Componentes( codFichaTecnica, codComponente, unidade, quantidade) VALUES (1, 1, 'uma', 40);
INSERT INTO FichasTecnicas_Componentes( codFichaTecnica, codComponente, unidade, quantidade) VALUES (2, 2, 'uma', 40);
INSERT INTO FichasTecnicas_Componentes( codFichaTecnica, codComponente, unidade, quantidade) VALUES (3, 3, 'uma', 40);
INSERT INTO FichasTecnicas_Componentes( codFichaTecnica, codComponente, unidade, quantidade) VALUES (4, 4, 'uma', 40);
INSERT INTO FichasTecnicas_Componentes( codFichaTecnica, codComponente, unidade, quantidade) VALUES (5, 1, 'uma', 40);

--Tabela input_sensor
INSERT INTO input_sensor(input_string) VALUES ('AAAAAPI049012305202013:25');
INSERT INTO input_sensor(input_string) VALUES ('BBBBBTS050022405202014:25');
INSERT INTO input_sensor(input_string) VALUES ('CCCCCVV100032505202015:25');
INSERT INTO input_sensor(input_string) VALUES ('DDDDDHS099042605202016:25');
INSERT INTO input_sensor(input_string) VALUES ('EEEEETA089052705202013:25');
INSERT INTO input_sensor(input_string) VALUES ('FFFFFPA087062805202015:25');
INSERT INTO input_sensor(input_string) VALUES ('GGGGGPL069072905202003:25');
INSERT INTO input_sensor(input_string) VALUES ('HHHHHPI019083005202019:25');
INSERT INTO input_sensor(input_string) VALUES ('IIIIIPI049093105202009:25');
INSERT INTO input_sensor(input_string) VALUES ('JJJJJTS073100106202009:25');
