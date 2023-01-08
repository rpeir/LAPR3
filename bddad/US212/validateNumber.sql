create or replace function validateNumber(numberToValidate varchar2) return int
IS
   v_new_num NUMBER;
BEGIN
    v_new_num := TO_NUMBER(numberToValidate);
    RETURN 1;
EXCEPTION
    WHEN VALUE_ERROR THEN
        RETURN 0;
end;
