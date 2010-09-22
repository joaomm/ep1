-module (silhueta).
-export([silhueta_de_edificio/1, uniao/2]).
-import (uniao, [recursiva/2]).

silhueta_de_edificio({Esq, Alt, Dir}) ->
	[{Esq,Alt}, {Dir,0}].

uniao(ListaDePares1, ListaDePares2) ->
	uniao:recursiva(ListaDePares1, ListaDePares2).

