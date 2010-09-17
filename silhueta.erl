-module (silhueta).
-export([silhueta_de_edificio/1]).

silhueta_de_edificio({Esq, Alt, Dir}) ->
	[{Esq,Alt}, {Dir,0}].