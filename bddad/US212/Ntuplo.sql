Create or Replace Function nTuplo(parm_n int) return varchar
is
string_return varchar(25);
begin
    Select input_string into string_return from (
                                                SELECT ROW_NUMBER() OVER (ORDER BY 1)
		 AS row_num, input_string FROM input_sensor)
    WHERE row_num = parm_n;
    return (string_return);
end;