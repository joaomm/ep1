-module (silhueta).
-export([silhueta_de_edificio/1, uniao/2]).

silhueta_de_edificio({Esq, Alt, Dir}) ->
	[{Esq,Alt}, {Dir,0}].


uniao([{Esq1, Alt1}, {Dir1, _}], [{Dir1, Alt1}, {Dir2, _}]) ->
	[{Esq1, Alt1}, {Dir2, 0}];

uniao([{Esq1, Alt1}, {Dir1, _}], [{Dir1, Alt2}, {Dir2, _}]) ->
	[{Esq1, Alt1}, {Dir1, Alt2}, {Dir2, 0}];

uniao(ListaDePares, ListaDePares) ->
	ListaDePares;

uniao([{Esq, _}, {Dir1, _}], [{Esq, _}, {Dir2, 0}]) ->
	case Dir1 < Dir2 of
		true -> [{0, 1}, {Dir2, 0}];
		false -> [{0, 1}, {Dir1, 0}]
	end;

uniao([Par1, Par2], [Par3, Par4]) ->
		[Par1, Par2, Par3, Par4].