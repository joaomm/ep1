-module (silhueta).
-export([main/1]).

algoritmo1(Edificios) ->
	algoritmo1:recursivo(Edificios).
	
algoritmo2(Edificios) ->
	algoritmo2:recursivo(Edificios).
	
silhueta_com_foldl(Edificios) ->
	fold:silhueta_com_foldl(Edificios).
	
silhueta_com_foldr(Edificios) ->
	fold:silhueta_com_foldr(Edificios).
	
main([Algoritmo, _, ArquivoSilhueta]) ->
	Edificios = [{12, 7, 16}, {2, 6, 7}, {1, 11, 5}, {24, 4, 28}, {3, 13, 9}, {19, 18, 22}, {23, 13, 29}, {14, 3, 25}],
	Silhueta = apply(escolhe_algoritmo(Algoritmo), [Edificios]),
	imprimir:silhueta(ArquivoSilhueta, Silhueta),
	init:stop();

main([Algoritmo, _]) ->
	Edificios = [{12, 7, 16}, {2, 6, 7}, {1, 11, 5}, {24, 4, 28}, {3, 13, 9}, {19, 18, 22}, {23, 13, 29}, {14, 3, 25}],
	Silhueta = apply(escolhe_algoritmo(Algoritmo), [Edificios]),
	imprimir:silhueta(stdout, Silhueta),
	init:stop();

main([Algoritmo]) ->
	Edificios = [{12, 7, 16}, {2, 6, 7}, {1, 11, 5}, {24, 4, 28}, {3, 13, 9}, {19, 18, 22}, {23, 13, 29}, {14, 3, 25}],
	Silhueta = apply(escolhe_algoritmo(Algoritmo), [Edificios]),
	imprimir:silhueta(stdout, Silhueta),
	init:stop();

main([]) ->
	main(['2', stdin, stdout]).

escolhe_algoritmo('1') ->
	fun algoritmo1/1;

escolhe_algoritmo('2') ->
	fun algoritmo2/1;
		
escolhe_algoritmo('L') ->
	fun silhueta_com_foldl/1;

escolhe_algoritmo('R') ->
	fun silhueta_com_foldr/1.