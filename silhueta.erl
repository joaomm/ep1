-module (silhueta).
-export([main/1, main/0]).

algoritmo1(Edificios) ->
	io:format("Utilizando Algoritmo 1~n"),
	algoritmo1:recursivo(Edificios).
	
algoritmo2(Edificios) ->
	io:format("Utilizando Algoritmo 2~n"),
	algoritmo2:recursivo(Edificios).
	
silhueta_com_foldl(Edificios) ->
	io:format("Utilizando Algoritmo Silhueta com FoldR~n"),
	fold:silhueta_com_foldl(Edificios).
	
silhueta_com_foldr(Edificios) ->
	io:format("Utilizando Algoritmo Silhueta com FoldR~n"),
	fold:silhueta_com_foldr(Edificios).
	
main([Algoritmo, _Entrada, Saida]) ->
	Edificios = [{12, 7, 16}, {2, 6, 7}, {1, 11, 5}, {24, 4, 28}, {3, 13, 9}, {19, 18, 22}, {23, 13, 29}, {14, 3, 25}],
	Silhueta = apply(escolhe_algoritmo(Algoritmo), [Edificios]),
	imprimir:silhueta(Saida, Silhueta),
	init:stop();

main([Algoritmo, _Entrada]) ->
	main([Algoritmo, _Entrada, stdout]);

main([Algoritmo]) ->
	main([Algoritmo, stdin, stdout]);

main([]) ->
	main(['2', stdin, stdout]).

main() ->
	main([]).

escolhe_algoritmo('1') ->
	fun algoritmo1/1;

escolhe_algoritmo('2') ->
	fun algoritmo2/1;
		
escolhe_algoritmo('L') ->
	fun silhueta_com_foldl/1;

escolhe_algoritmo('R') ->
	fun silhueta_com_foldr/1.