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
	[Primeiro2 | _Resto2] = ListaDePares2,
    case compara(Primeiro1, Primeiro2) of
		x_do_primeiro_mais_a_esquerda -> uniao_recursiva(Resto1, ListaDePares2, [Primeiro1 | Resultado]);
		x_igual -> escolhe_maior_altura_e_chama_uniao(ListaDePares1, ListaDePares2, Resultado)
	end.

compara({X1, _Alt1}, {X2, _Alt2}) when X1 < X2 ->
	x_do_primeiro_mais_a_esquerda;

compara({X1, _Alt1}, {X1, _Alt2}) ->
	x_igual.

escolhe_maior_altura_e_chama_uniao(ListaDePares1, ListaDePares2, Resultado) ->
	[_Primeiro1 | Resto1] = ListaDePares1,
	[Primeiro2 | Resto2] = ListaDePares2,
	{_, Altura2} = Primeiro2,
	[{_, AlturaUltimo} | _ ] = Resultado,
	case Altura2 == AlturaUltimo of
		true -> uniao_recursiva(Resto1, Resto2, Resultado);
		false -> uniao_recursiva(Resto1, Resto2, [Primeiro2 | Resultado])
	end.
	
	
