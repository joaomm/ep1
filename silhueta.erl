-module (silhueta).
-export([silhueta_de_edificio/1, uniao/2]).

silhueta_de_edificio({Esq, Alt, Dir}) ->
	[{Esq,Alt}, {Dir,0}].

uniao(ListaDePares1, ListaDePares2) ->
	uniao_recursiva(ListaDePares1, ListaDePares2, []).

uniao_recursiva([], ListaDePares2, Resultado) ->
	lists:reverse(Resultado) ++ ListaDePares2;

uniao_recursiva(ListaDePares1, ListaDePares2, Resultado) ->
	[Primeiro1 | Resto1] = ListaDePares1,
	[Primeiro2 | Resto2] = ListaDePares2,
	case compara(Primeiro1, Primeiro2) of
		x_do_primeiro_mais_a_esquerda -> uniao_recursiva(Resto1, ListaDePares2, [Primeiro1 | Resultado]);
		x_igual -> uniao_recursiva(Resto1, Resto2, Resultado)
	end.
	
compara({X1, Alt1}, {X2, Alt2}) ->
	case X1 < X2 of
		true -> x_do_primeiro_mais_a_esquerda;
		false -> x_igual
	end.