-module (silhueta).
-export([silhueta_de_edificio/1, uniao/2, algoritmo1/1, algoritmo2/1]).
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
	
algoritmo2([Edificio]) ->
	silhueta_de_edificio(Edificio);

algoritmo2(Edificios) ->
	{PrimeiraLista, SegundaLista} = particiona(Edificios),
	PrimeiraSilhueta = algoritmo2(PrimeiraLista),
	SegundaSilhueta = algoritmo2(SegundaLista),	
	uniao(PrimeiraSilhueta, SegundaSilhueta).

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