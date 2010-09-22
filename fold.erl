-module (fold).
-export ([silhueta_com_foldr/1, silhueta_com_foldl/1]).

silhueta_com_foldr(Edificios) ->
	lists:foldr(fun uniao_das_silhuetas/2, [], Edificios).

silhueta_com_foldl(Edificios) ->
	lists:foldl(fun uniao_das_silhuetas/2, [], Edificios).

uniao_das_silhuetas(Edificio, Silhueta) ->
	SilhuetaDoEdificio = operacao:silhueta_de_edificio(Edificio),
	operacao:uniao(SilhuetaDoEdificio, Silhueta).
	
