-module (imprimir_test).
-include_lib("eunit/include/eunit.hrl").

imprimir_lista_no_arquivo_com_tamanho_zero_test() ->
	Lista = [],
	imprimir:silhueta("saida_teste.out", Lista),
	{ok, S} = file:open("saida_teste.out", read),
	
	?assertEqual(io:get_line(S, ''), "0\n"),
	
	file:close(S).

imprimir_lista_no_arquivo_com_tamanho_um_test() ->
	Lista = [{1,0}],
	imprimir:silhueta("saida_teste.out", Lista),
	{ok, S} = file:open("saida_teste.out", read),
	
	?assertEqual(io:get_line(S, ''), "1\n"),
	?assertEqual(io:get_line(S, ''), "1 0\n"),

	file:close(S).

imprimir_lista_no_arquivo_com_tamanho_maior_que_um_test() ->
	Lista = [{1,0}, {2,3}, {4,6}, {9, 0}],
	imprimir:silhueta("saida_teste.out", Lista),
	{ok, S} = file:open("saida_teste.out", read),
	
	?assertEqual(io:get_line(S, ''), "4\n"),
	?assertEqual(io:get_line(S, ''), "1 0\n"),
	?assertEqual(io:get_line(S, ''), "2 3\n"),
	?assertEqual(io:get_line(S, ''), "4 6\n"),
	?assertEqual(io:get_line(S, ''), "9 0\n"),
	
	file:close(S).


