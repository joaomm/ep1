-module(imagem).
-export([nova/2]).

nova(NomeImagem, Matriz) ->
	{Linhas, Colunas, _} = Matriz,
	{ok, S} = file:open(NomeImagem, write),
	io:fwrite(S, "P2~n", []),
	io:fwrite(S, "~p ~p~n", [Colunas, Linhas]),
	io:fwrite(S, "16~n", []),

	imprimir_matriz(Linhas, Matriz, S),
	imprimir_linha(0, Colunas, Matriz, S),
	
	file:close(S).

imprimir_matriz(0, _, _) ->
	ok;

imprimir_matriz(Linha, Matriz, S) ->
	{MaxLinhas, MaxColunas, _} = Matriz,
	imprimir_linha(MaxLinhas-Linha, MaxColunas, Matriz, S),
	imprimir_matriz(Linha-1, Matriz, S).

imprimir_linha(_, 0, _, S) ->
	io:fwrite(S, "~n", []);

imprimir_linha(Linha, Coluna, Matriz, S) ->
	{_, MaxColunas, _} = Matriz,
	Valor = matrix:get(Linha, (MaxColunas-Coluna), Matriz),
	io:fwrite(S, "~p ", [Valor]),
	imprimir_linha(Linha, Coluna-1, Matriz, S).
