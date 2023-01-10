Create or replace procedure loadHub as
    v_codHub varchar(5);
    v_tipoHub VARCHAR(50);
    v_lat varchar(8);
    v_lng varchar(8);
    v_input_string VARCHAR(25);
    duplicado int;
    isCliente int;

    Cursor c_input_hub is
        Select * from input_hub;


Begin
    Open c_input_hub;
    Loop
        Fetch c_input_hub into v_input_string;
        Exit when c_input_hub%notfound;

        Select string_parts into v_codHub from (
                                                   SELECT ROW_NUMBER() OVER (ORDER BY 1)
                                                              AS row_num, string_parts FROM (
                                                                                                SELECT
                                                                                                    REGEXP_SUBSTR (
                                                                                                            v_input_string, '[^;]+', 1, level
                                                                                                        ) AS string_parts
                                                                                                FROM dual
                                                                                                CONNECT BY REGEXP_SUBSTR (
                                                                                                                   v_input_string, '[^;]+', 1, level
                                                                                                               ) IS NOT NULL))
        WHERE row_num = 1;

        Select string_parts into v_lat from (
                                                SELECT ROW_NUMBER() OVER (ORDER BY 1)
                                                           AS row_num, string_parts FROM (
                                                                                             SELECT
                                                                                                 REGEXP_SUBSTR (
                                                                                                         v_input_string, '[^;]+', 1, level
                                                                                                     ) AS string_parts
                                                                                             FROM dual
                                                                                             CONNECT BY REGEXP_SUBSTR (
                                                                                                                v_input_string, '[^;]+', 1, level
                                                                                                            ) IS NOT NULL))
        WHERE row_num = 2;

        Select string_parts into v_lng from (
                                                SELECT ROW_NUMBER() OVER (ORDER BY 1)
                                                           AS row_num, string_parts FROM (
                                                                                             SELECT
                                                                                                 REGEXP_SUBSTR (
                                                                                                         v_input_string, '[^;]+', 1, level
                                                                                                     ) AS string_parts
                                                                                             FROM dual
                                                                                             CONNECT BY REGEXP_SUBSTR (
                                                                                                                v_input_string, '[^;]+', 1, level
                                                                                                            ) IS NOT NULL))
        WHERE row_num = 3;

        Select string_parts into v_tipoHub from (
                                                    SELECT ROW_NUMBER() OVER (ORDER BY 1)
                                                               AS row_num, string_parts FROM (
                                                                                                 SELECT
                                                                                                     REGEXP_SUBSTR (
                                                                                                             v_input_string, '[^;]+', 1, level
                                                                                                         ) AS string_parts
                                                                                                 FROM dual
                                                                                                 CONNECT BY REGEXP_SUBSTR (
                                                                                                                    v_input_string, '[^;]+', 1, level
                                                                                                                ) IS NOT NULL))
        WHERE row_num = 4;



        Select count(*) into duplicado from hub where codHub like v_codHub;
        Select count(*)  into isCliente from (Select dummy from (Select v_tipoHub dummy from dual ) where dummy like '%C%' );
        if duplicado = 0 and isCliente = 0  then
            insert into Hub(codHub, tipoHub, lat, lng) values (v_codHub, v_tipoHub, To_number(v_lat), to_number(v_lng));
        end if;
    End Loop;
End;