-module(imagem).
-export([nova/2, gerar_matriz/1]).

%Gerar Matriz
gerar_matriz([]) ->
	Matriz = matrix:new(600, 800),
	MatrizBranca = preencher_matriz_com_branco(Matriz),
	preencher_base(MatrizBranca).

preencher_base(Matriz) ->
	{MaxLinhas, _, _} = Matriz,
	MatrizComUltimaLinhaPreenchida = preencher_ultima_linha(Matriz),
	preencher_primeira_coluna(MaxLinhas, MatrizComUltimaLinhaPreenchida).

preencher_ultima_linha(Matriz) ->
	{_, MaxColunas, _} = Matriz,
	preencher_cada_elemento(1, MaxColunas, Matriz, 0).

preencher_primeira_coluna(0, Matriz) ->
	Matriz;

preencher_primeira_coluna(Linha, Matriz) ->
	{MaxLinhas, _, _} = Matriz,
	NovaMatriz = matrix:set(MaxLinhas-Linha, 0, 0, Matriz),
	preencher_primeira_coluna(Linha-1, NovaMatriz).

preencher_matriz_com_branco(Matriz) ->
	{Linhas, _, _} = Matriz,
	preencher_linhas_com_branco(Linhas, Matriz).

preencher_linhas_com_branco(0, Matriz) ->
	Matriz;

preencher_linhas_com_branco(Linha, Matriz) ->
	{_, Colunas, _} = Matriz,
	NovaMatriz = preencher_cada_elemento(Linha, Colunas, Matriz, 16),
	preencher_linhas_com_branco(Linha-1, NovaMatriz).

preencher_cada_elemento(_, 0, Matriz, _) ->
	Matriz;

preencher_cada_elemento(Linha, Coluna, Matriz, Valor) ->
	{MaxLinhas, MaxColunas, _} = Matriz,
	NovaMatriz = matrix:set(MaxLinhas - Linha, MaxColunas - Coluna, Valor, Matriz),
	preencher_cada_elemento(Linha, Coluna-1, NovaMatriz, Valor).




%Nova imagem
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
