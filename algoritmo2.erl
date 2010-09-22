-module (algoritmo2).
-export ([recursivo/1]).

recursivo([Edificio]) ->
	operacao:silhueta_de_edificio(Edificio);

recursivo(Edificios) ->
	{PrimeiraLista, SegundaLista} = particiona(Edificios),
	PrimeiraSilhueta = recursivo(PrimeiraLista),
	SegundaSilhueta = recursivo(SegundaLista),	
	operacao:uniao(PrimeiraSilhueta, SegundaSilhueta).

particiona(Edificios) ->
	particiona([], Edificios, Edificios).

particiona(PrimeiraMetade, SegundaMetade, []) ->
	{lists:reverse(PrimeiraMetade), SegundaMetade};
	
particiona(PrimeiraMetade, SegundaMetade, [_Edificio]) ->
	particiona(PrimeiraMetade, SegundaMetade, []);

particiona(PrimeiraMetade, SegundaMetade, ListaParaAndar) ->
	{EdificioAndado, ListaComUmAndado} = anda_um(SegundaMetade),
	ListaAndandoDoisEdificios = anda_dois(ListaParaAndar),
	particiona([EdificioAndado | PrimeiraMetade], ListaComUmAndado, ListaAndandoDoisEdificios).

anda_um([EdificioAndado | ListaComUmAndado]) ->
	{EdificioAndado, ListaComUmAndado}.
	
anda_dois([_, _ | ListaComDoisAndado]) ->
	ListaComDoisAndado.