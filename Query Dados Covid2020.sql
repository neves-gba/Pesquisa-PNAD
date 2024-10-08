/* Após importar as bases para o SQL, iniciei o tratamento da base criando o campo 'Mes' nas tabelas para conseguir identificar o período exato. 
Em seguida vou unificar as 3 tabelas em uma só */

-- Julho
    ALTER TABLE [BANCOTESTE].[dbo].[PNAD_COVID_072020] ADD Mes VARCHAR(2);
	UPDATE [BANCOTESTE].[dbo].[PNAD_COVID_072020] SET Mes = '07';
-- Agosto
   ALTER TABLE [BANCOTESTE].[dbo].[PNAD_COVID_082020] ADD Mes VARCHAR(2);
UPDATE [BANCOTESTE].[dbo].[PNAD_COVID_082020] SET Mes = '08';
-- Setembro
    ALTER TABLE [BANCOTESTE].[dbo].[PNAD_COVID_092020] ADD Mes VARCHAR(2);
UPDATE [BANCOTESTE].[dbo].[PNAD_COVID_092020] SET Mes = '09';

/* Antes de unificar as tabelas, vamos conferir se elas possuem a mesma estrutura */

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'PNAD_COVID_072020';

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'PNAD_COVID_082020';

SELECT COLUMN_NAME, DATA_TYPE, CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'PNAD_COVID_092020';

/* Após comparar se a estrutura das tabelas está igual, criei uma nova tabela chamada 'PNAD_COVID_UNIFICADA' 
com todos os dados do terceiro trimestre para agilizar a análise */

SELECT * INTO [BANCOTESTE].[dbo].[PNAD_COVID_UNIFICADA]
FROM [BANCOTESTE].[dbo].[PNAD_COVID_072020];

INSERT INTO [BANCOTESTE].[dbo].[PNAD_COVID_UNIFICADA]
SELECT * FROM [BANCOTESTE].[dbo].[PNAD_COVID_082020];

INSERT INTO [BANCOTESTE].[dbo].[PNAD_COVID_UNIFICADA]
SELECT * FROM [BANCOTESTE].[dbo].[PNAD_COVID_092020];

/* A partir de agora só usarei a tabela unificada. Fiz a seleção das colunas que serão usadas para a análise, 
com base nos questionamentos definidos anteriormente. Como o foco dessa análise será a capital de São Paulo, 
começarei segmentando os dados pela localidade */

SELECT 
    UF, 
    CAPITAL, 
    A003, 
    B008, 
    B007, 
    B002, 
    B011, 
    B005, 
    B0011, 
    B0012, 
    B0013, 
    B0014, 
    B0015, 
    B0016, 
    B0017, 
    B0018, 
    B0019, 
    B00110, 
    B00111, 
    B00112, 
    B00113, 
    Mes,
    CONCAT(B009B, ' ', B009D, ' ', B009F) AS Result_teste_covid  -- Mesclando as colunas B009B, B009D e B009F, onde ficam os resultados dos testes de covid
FROM 
    [BANCOTESTE].[dbo].[PNAD_COVID_UNIFICADA]
WHERE 
    UF = 35 AND CAPITAL = 35;
 /* O Código 35 do campo UF e CAPITAL se referem ao Estado e cidade de São Paulo respectivamente. 
Também seria possivel realizar essa consulta utilizando o campo V1023 = 1*/