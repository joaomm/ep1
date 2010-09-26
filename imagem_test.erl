-module(imagem_test).
-include_lib("eunit/include/eunit.hrl").

imprimir_imagem_pgm_com_um_elemento_test() ->
	MatrizCheia = {1, 1, array:from_list([0])},
	imagem:nova("imagem_test.pgm", MatrizCheia),
	
	{ok, S} = file:open("imagem_test.pgm", read),
	
	?assertEqual(io:get_line(S, ''), "P2\n"),
	?assertEqual(io:get_line(S, ''), "1 1\n"),
	?assertEqual(io:get_line(S, ''), "15\n"),

	?assertEqual(io:get_line(S, ''), "0 \n"),

	file:close(S).

imprimir_imagem_pgm_com_tres_elementos_em_uma_linha_test() ->
	MatrizCheia = {1, 3, array:from_list([0 ,0, 0])},
	imagem:nova("imagem_test.pgm", MatrizCheia),

	{ok, S} = file:open("imagem_test.pgm", read),
	
	?assertEqual(io:get_line(S, ''), "P2\n"),
	?assertEqual(io:get_line(S, ''), "3 1\n"),
	?assertEqual(io:get_line(S, ''), "15\n"),

	?assertEqual(io:get_line(S, ''), "0 0 0 \n"),

	file:close(S).

imprimir_imagem_pgm_com_dois_elementos_em_uma_coluna_test() ->
	MatrizCheia = {2, 1, array:from_list([0, 0, 0])},
	imagem:nova("imagem_test.pgm", MatrizCheia),

	{ok, S} = file:open("imagem_test.pgm", read),
	
	?assertEqual(io:get_line(S, ''), "P2\n"),
	?assertEqual(io:get_line(S, ''), "1 2\n"),
	?assertEqual(io:get_line(S, ''), "15\n"),

	?assertEqual(io:get_line(S, ''), "0 \n"),
	?assertEqual(io:get_line(S, ''), "0 \n"),

	file:close(S).

imprimir_imagem_pgm_com_alguns_elementos_test() ->
	MatrizCheia = {3, 3, array:from_list([0, 0, 0, 0, 1, 0, 0, 0, 0])},
	imagem:nova("imagem_test.pgm", MatrizCheia),

	{ok, S} = file:open("imagem_test.pgm", read),
	
	?assertEqual(io:get_line(S, ''), "P2\n"),
	?assertEqual(io:get_line(S, ''), "3 3\n"),
	?assertEqual(io:get_line(S, ''), "15\n"),

	?assertEqual(io:get_line(S, ''), "0 0 0 \n"),
	?assertEqual(io:get_line(S, ''), "0 1 0 \n"),
	?assertEqual(io:get_line(S, ''), "0 0 0 \n"),
	file:close(S).

