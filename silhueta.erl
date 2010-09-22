-module (silhueta).
-export([silhueta_de_edificio/1, uniao/2, algoritmo1/1]).
-import (uniao, [recursiva/2]).

silhueta_de_edificio({Esq, Alt, Dir}) ->
	[{Esq,Alt}, {Dir,0}].

uniao(ListaDePares1, ListaDePares2) ->
	uniao:recursiva(ListaDePares1, ListaDePares2).
	
algoritmo1(Edificios) ->
	algoritmo1_recursivo(Edificios, []).

algoritmo1_recursivo([], Silhueta) ->
	Silhueta;

algoritmo1_recursivo(Edificios, Silhueta) ->
	[Edificio | Resto] = Edificios, 
	SilhuetaDoEdificio = silhueta_de_edificio(Edificio),
	algoritmo1_recursivo(Resto, uniao(SilhuetaDoEdificio, Silhueta)).