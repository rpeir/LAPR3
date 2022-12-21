DECLARE
  cursor c1 is
    SELECT table_name
    FROM all_tables
    WHERE owner = 'JOANA';
BEGIN
  FOR r1 IN c1 LOOP
    EXECUTE IMMEDIATE 'GRANT SELECT, INSERT, UPDATE, DELETE ON JOANA.' || r1.table_name || ' TO ZE';
  END LOOP;
END;
/