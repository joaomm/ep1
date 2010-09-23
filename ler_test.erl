-module(ler_test).
-include_lib("eunit/include/eunit.hrl").

ler_arquivo_com_lista_de_edificios_com_nenhum_ed_e_retornar_lista_vazia_test() ->
	{ok, S} = file:open("entrada_teste.in", write),
	io:fwrite(S, "0~n", []),
	file:close(S),

	ListaEdificios = ler:edificios("entrada_teste.in"),
	?assertEqual(length(ListaEdificios), 0).
	
ler_arquivo_com_lista_de_edificios_com_um_ed_e_retornar_lista_com_um_elemento_test() ->
	{ok, S} = file:open("entrada_teste.in", write),
	io:fwrite(S, "1~n12 7 16~n", []),
	file:close(S),

	ListaEdificios = ler:edificios("entrada_teste.in"),
	?assertEqual(length(ListaEdificios), 1),

	[Ed1 | _] = ListaEdificios,
	?assertEqual(Ed1, {12, 7, 16}).

ler_arquivo_com_lista_de_edificios_com_mais_de_um_edificio_test() ->
	{ok, S} = file:open("entrada_teste.in", write),
	io:fwrite(S, "3~n12 7 16~n2 6 7~n1 11 5~n", []),
	file:close(S),

	ListaEdificios = ler:edificios("entrada_teste.in"),
	?assertEqual(length(ListaEdificios), 3).
	
		
