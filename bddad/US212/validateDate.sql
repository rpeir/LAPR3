create or replace function validaDate(dateToValidate varchar2) return int
IS
   v_new_date DATE;
BEGIN
    v_new_date := TO_DATE(dateToValidate,'DDMMYYYYHH24:MI');
    RETURN 1;
EXCEPTION
    WHEN others THEN
        RETURN 0;
end;