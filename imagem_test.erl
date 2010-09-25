-module(imagem_test).
-include_lib("eunit/include/eunit.hrl").

imprimir_imagem_pgm_com_um_elemento_test() ->
	MatrizCheia = {1, 1, array:from_list([0])},
	imagem:nova("imagem_test.pgm", MatrizCheia),
	
	{ok, S} = file:open("imagem_test.pgm", read),
	
	?assertEqual(io:get_line(S, ''), "P2\n"),
	?assertEqual(io:get_line(S, ''), "1 1\n"),
	?assertEqual(io:get_line(S, ''), "16\n"),

	?assertEqual(io:get_line(S, ''), "0 \n"),

	file:close(S).

imprimir_imagem_pgm_com_tres_elementos_em_uma_linha_test() ->
	MatrizCheia = {1, 3, array:from_list([0 ,0, 0])},
	imagem:nova("imagem_test.pgm", MatrizCheia),

	{ok, S} = file:open("imagem_test.pgm", read),
	
	?assertEqual(io:get_line(S, ''), "P2\n"),
	?assertEqual(io:get_line(S, ''), "3 1\n"),
	?assertEqual(io:get_line(S, ''), "16\n"),

	?assertEqual(io:get_line(S, ''), "0 0 0 \n"),

	file:close(S).

imprimir_imagem_pgm_com_dois_elementos_em_uma_coluna_test() ->
	MatrizCheia = {2, 1, array:from_list([0, 0, 0])},
	imagem:nova("imagem_test.pgm", MatrizCheia),

	{ok, S} = file:open("imagem_test.pgm", read),
	
	?assertEqual(io:get_line(S, ''), "P2\n"),
	?assertEqual(io:get_line(S, ''), "1 2\n"),
	?assertEqual(io:get_line(S, ''), "16\n"),

	?assertEqual(io:get_line(S, ''), "0 \n"),
	?assertEqual(io:get_line(S, ''), "0 \n"),

	file:close(S).

imprimir_imagem_pgm_com_alguns_elementos_test() ->
	MatrizCheia = {3, 3, array:from_list([0, 0, 0, 0, 1, 0, 0, 0, 0])},
	imagem:nova("imagem_test.pgm", MatrizCheia),

	{ok, S} = file:open("imagem_test.pgm", read),
	
	?assertEqual(io:get_line(S, ''), "P2\n"),
	?assertEqual(io:get_line(S, ''), "3 3\n"),
	?assertEqual(io:get_line(S, ''), "16\n"),

	?assertEqual(io:get_line(S, ''), "0 0 0 \n"),
	?assertEqual(io:get_line(S, ''), "0 1 0 \n"),
	?assertEqual(io:get_line(S, ''), "0 0 0 \n"),
	file:close(S).

%
gerar_matriz_para_imagem_com_nenhum_desenho_test() ->
	SilhuetaVazia = [],
	Matriz = imagem:gerar_matriz(SilhuetaVazia),
	{Linhas, Colunas, _A} = Matriz,

	?assertEqual(Linhas, 600),
	?assertEqual(Colunas, 800),
  todos_elementos_devem_estar_com_maxval(Matriz),
	verificar_base(Matriz).

gerar_matriz_para_imagem_com_dois_pares_de_silhueta_test() ->
	Silhueta = [{0,1}, {2, 0}],
	Matriz = imagem:gerar_matriz(Silhueta),
	?assertEqual(10, matrix:get(598,1, Matriz)),
	?assertEqual(10, matrix:get(598,2, Matriz)),

	?assertEqual(16, matrix:get(597,1, Matriz)),
	?assertEqual(16, matrix:get(597,2, Matriz)),
	?assertEqual(16, matrix:get(597,3, Matriz)),
	?assertEqual(16, matrix:get(598,3, Matriz)),

	?assertEqual(0, matrix:get(599,0, Matriz)),
	?assertEqual(0, matrix:get(599,1, Matriz)),
	?assertEqual(0, matrix:get(599,2, Matriz)),
	?assertEqual(0, matrix:get(599,3, Matriz)),

	?assertEqual(0, matrix:get(598,0, Matriz)).

todos_elementos_devem_estar_com_maxval(Matriz) ->
	{Linhas, _, _} = Matriz,
	verificar_linha_toda_e_chamar_proxima(Linhas, Matriz, 16).

verificar_base(Matriz) ->
	{MaxLinhas, _, _} = Matriz,
	verificar_linha_toda(1, Matriz, 0),
	verificar_primeira_coluna(MaxLinhas, Matriz).

verificar_primeira_coluna(0, _) ->
	ok;

verificar_primeira_coluna(Linha, Matriz) ->
	{MaxLinhas, _, _} = Matriz,
	?assertEqual(0, matrix:get(MaxLinhas-Linha, 0, Matriz)),
	verificar_primeira_coluna(Linha-1,Matriz).

verificar_linha_toda_e_chamar_proxima(1, _, _) ->
	ok;

verificar_linha_toda_e_chamar_proxima(Linha, Matriz, Valor) ->
	verificar_linha_toda(Linha, Matriz, Valor),
	verificar_linha_toda_e_chamar_proxima(Linha-1,Matriz, Valor).

verificar_linha_toda(Linha, Matriz, Valor) ->
	{_, Colunas, _} = Matriz,
	verificar_cada_elemento(Linha, Colunas-1, Matriz, Valor).

verificar_cada_elemento(_, 0, _, _) ->
	ok;

verificar_cada_elemento(Linha, Coluna, Matriz, Valor) ->
	{MaxLinhas, MaxColunas, _} = Matriz,
	ValorAtual = matrix:get(MaxLinhas - Linha, MaxColunas - Coluna, Matriz),
	?assertEqual(Valor, ValorAtual),
	verificar_cada_elemento(Linha, Coluna-1, Matriz, Valor).
%




