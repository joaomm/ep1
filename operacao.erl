-module (operacao).
-export ([silhueta_de_edificio/1, uniao/2]).

silhueta_de_edificio({Esq, Alt, Dir}) ->
	[{Esq,Alt}, {Dir,0}].

uniao(Silhueta1, Silhueta2) ->
	uniao:recursiva(Silhueta1, Silhueta2).