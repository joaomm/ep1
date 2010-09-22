-module (algoritmo1).
-export ([recursivo/1]).

recursivo(Edificios) ->
	recursivo(Edificios, []).

recursivo([], Silhueta) ->
	Silhueta;
		
recursivo(Edificios, Silhueta) ->
	[Edificio | Resto] = Edificios, 
	SilhuetaDoEdificio = operacao:silhueta_de_edificio(Edificio),
	recursivo(Resto, operacao:uniao(SilhuetaDoEdificio, Silhueta)).