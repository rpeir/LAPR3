SELECT SID, SERIAL#, USERNAME, STATUS, MACHINE
FROM V$SESSION;

SELECT USERNAME, DEFAULT_TABLESPACE, TEMPORARY_TABLESPACE
FROM DBA_USERS;

SELECT OWNER
FROM ALL_TABLES
WHERE TABLE_NAME = 'Clientes';

SELECT SYS_CONTEXT('USERENV', 'DB_NAME') FROM DUAL;

DECLARE
  cursor c1 is
    SELECT table_name
    FROM all_tables
    WHERE owner = 'ras';
BEGIN
  FOR r1 IN c1 LOOP
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON ras.' || r1.table_name || ' TO ras';
  END LOOP;
END;
/

DECLARE
  cursor c1 is
    SELECT table_name
    FROM all_tables
    WHERE owner = 'JOANA';
  l_sql VARCHAR2(32767);
BEGIN
  FOR r1 IN c1 LOOP
    -- Generate the INSERT INTO statement for the current table
    l_sql := 'INSERT INTO other_session.' || r1.table_name || ' (SELECT * FROM JOANA.' || r1.table_name || ')';

    -- Execute the INSERT INTO statement
    EXECUTE IMMEDIATE l_sql;
  END LOOP;
END;
/

-- database name = XEPDB1
INSERT INTO Cliente (codCliente, nome, emailCliente, nrFiscal)
SELECT codInterno, nome, emailCliente, nrFiscal
FROM [database_name.schema_name].[Clientes];
