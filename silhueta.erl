-module (silhueta).
-export([main/1, main/0]).

algoritmo1(Edificios) ->
	io:format(" - Utilizando Algoritmo 1...~n"),
	algoritmo1:recursivo(Edificios).
	
algoritmo2(Edificios) ->
	io:format(" - Utilizando Algoritmo 2...~n"),
	algoritmo2:recursivo(Edificios).
	
silhueta_com_foldl(Edificios) ->
	io:format(" - Utilizando Algoritmo Silhueta com FoldR...~n"),
	fold:silhueta_com_foldl(Edificios).
	
silhueta_com_foldr(Edificios) ->
	io:format(" - Utilizando Algoritmo Silhueta com FoldR...~n"),
	fold:silhueta_com_foldr(Edificios).

main([Algoritmo, Entrada, Saida, NomeDaImagem]) ->
	Edificios = le_entrada(Entrada),
	Silhueta = roda_algoritmo(Algoritmo, Edificios), 
	imprime_silhueta_no_arquivo_de_saida(Saida, Silhueta),
	gera_imagem(NomeDaImagem, Silhueta),
	init:stop();

main([Algoritmo, Entrada, Saida]) ->
	Edificios = le_entrada(Entrada),
	Silhueta = roda_algoritmo(Algoritmo, Edificios), 
	imprime_silhueta_no_arquivo_de_saida(Saida, Silhueta),
	init:stop();

main([Algoritmo, Entrada]) ->
	main([Algoritmo, Entrada, stdout]);

main([Algoritmo]) ->
	main([Algoritmo, stdin, stdout]);

main([]) ->
	main(['2', stdin, stdout]).

main() ->
	main([]).

le_entrada(Entrada) ->
	io:format(" - Lendo entrada em ~p...~n", [Entrada]),
	ler:edificios(Entrada).

roda_algoritmo(Algoritmo, Edificios) ->
	apply(escolhe_algoritmo(Algoritmo), [Edificios]).

imprime_silhueta_no_arquivo_de_saida(Saida, Silhueta) ->
	io:format(" - Imprimindo silhueta em ~p...~n", [Saida]),
	imprimir:silhueta(Saida, Silhueta).

gera_imagem(NomeDaImagem, Silhueta) ->
	io:format(" - Gerando a matriz da silhueta ..~n"),
	Matriz = imagem:gerar_matriz(Silhueta),
	io:format(" - Gerando imagem pgm ~p..,~n", [NomeDaImagem]),
	imagem:nova(NomeDaImagem, Matriz).

escolhe_algoritmo('1') ->
	fun algoritmo1/1;

escolhe_algoritmo('2') ->
	fun algoritmo2/1;
		
escolhe_algoritmo('L') ->
	fun silhueta_com_foldl/1;

escolhe_algoritmo('R') ->
	fun silhueta_com_foldr/1.
