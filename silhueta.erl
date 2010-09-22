-module (silhueta).
-export([]).

algoritmo1(Edificios) ->
	algoritmo1:recursivo(Edificios).
	
algoritmo2(Edificios) ->
	algoritmo2:recursivo(Edificios).
	
silhueta_com_foldr(Edificios) ->
	fold:silhueta_com_foldr(Edificios).
	
silhueta_com_foldl(Edificios) ->
	fold:silhueta_com_foldl(Edificios).