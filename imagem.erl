-module(imagem).
-export([nova/2, gerar_matriz/1]).

%n_lins() -> 600.                      % número de linhas da imagem
%n_cols() -> 800.                      % número de colunas da imagem
%borda_inf() -> n_lins() - 1.          % borda inferior (última linha da imagem) 
%margem_inf() -> 20.                   % linhas do eixo base à borda inferior da imagem
%base() -> borda_inf() - margem_inf(). % linha do eixo base 
   
branco() -> 16.                       % valor de maxval
cinza() -> 10.                        % cor da silhueta preenchida
preto() -> 0.                         % cor do eixo base

gerar_matriz(Silhueta) ->
	Matriz = matrix:new(600, 800),
	MatrizCompleta = preencher_colunas_recursivamente(Silhueta, 0, 0, Matriz),
	preencher_base(MatrizCompleta).

preencher_colunas_recursivamente(_, _, 800, Matriz) ->
	Matriz;

preencher_colunas_recursivamente(Silhueta, AlturaAtual, Coluna, Matriz) ->
	{SilhuetaNova, AlturaNova} = nova_silhueta_e_altura(Silhueta, AlturaAtual, Coluna),
	MatrizNova = preencher_coluna(Coluna + 1, AlturaNova, Matriz),
	preencher_colunas_recursivamente(SilhuetaNova, AlturaNova, Coluna+1, MatrizNova).

nova_silhueta_e_altura([], AlturaAtual, _) ->
	{[], AlturaAtual};

nova_silhueta_e_altura(Silhueta, AlturaAtual, Coluna) ->
	[{X, Alt} | Resto ] = Silhueta,
	case X == Coluna of
		true -> {Resto, Alt};
		false -> {Silhueta, AlturaAtual}
	end.

preencher_coluna(Coluna, Altura, Matriz) ->
	MatrizNova = preencher_elementos_da_coluna_recursivamente(0, 599-Altura, Coluna, Matriz, branco()),
	preencher_elementos_da_coluna_recursivamente(599-Altura, 599, Coluna, MatrizNova, cinza()).

preencher_elementos_da_coluna_recursivamente(Linha, Linha, _, Matriz, _) ->
	Matriz;

preencher_elementos_da_coluna_recursivamente(Linha, LinhaFinal, Coluna, Matriz, Cor) ->
	MatrizNova = matrix:set(Linha, Coluna, Cor, Matriz),
	preencher_elementos_da_coluna_recursivamente(Linha+1, LinhaFinal, Coluna, MatrizNova, Cor).

preencher_base(Matriz) ->
	{MaxLinhas, _, _} = Matriz,
	MatrizComUltimaLinhaPreenchida = preencher_ultima_linha(Matriz),
	preencher_primeira_coluna(MaxLinhas, MatrizComUltimaLinhaPreenchida).

preencher_ultima_linha(Matriz) ->
	{_, MaxColunas, _} = Matriz,
	preencher_cada_elemento(1, MaxColunas, Matriz, preto()).

preencher_primeira_coluna(0, Matriz) ->
	Matriz;

preencher_primeira_coluna(Linha, Matriz) ->
	{MaxLinhas, _, _} = Matriz,
	NovaMatriz = matrix:set(MaxLinhas-Linha, 0, 0, Matriz),
	preencher_primeira_coluna(Linha-1, NovaMatriz).

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
