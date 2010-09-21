-module (silhueta).
-export([silhueta_de_edificio/1, uniao/2]).

silhueta_de_edificio({Esq, Alt, Dir}) ->
	[{Esq,Alt}, {Dir,0}].

uniao(ListaDePares1, ListaDePares2) ->
	uniao_recursiva(ListaDePares1, ListaDePares2, []).

uniao_recursiva([], ListaDePares2, Resultado) ->
	lists:reverse(Resultado) ++ ListaDePares2;

uniao_recursiva(ListaDePares1, [], Resultado) ->
	lists:reverse(Resultado) ++ ListaDePares1;
	
uniao_recursiva(ListaDePares1, ListaDePares2, Resultado) ->
	[Primeiro1 | _Resto1] = ListaDePares1,
	[Primeiro2 | Resto2] = ListaDePares2,
    case compara(Primeiro1, Primeiro2) of
		x_do_primeiro_mais_a_esquerda -> verifica_altura_e_chama_uniao(ListaDePares1, ListaDePares2, Resultado);
		x_do_segundo_mais_a_esquerda -> uniao_recursiva(ListaDePares1, Resto2, [Primeiro2 | Resultado]);
		x_igual -> escolhe_maior_altura_e_chama_uniao(ListaDePares1, ListaDePares2, Resultado)
	end.

compara({X1, _Alt1}, {X2, _Alt2}) when X1 < X2 ->
	x_do_primeiro_mais_a_esquerda;

compara({X1, _Alt1}, {X2, _Alt2}) when X1 > X2 ->
	x_do_segundo_mais_a_esquerda;

compara({X1, _Alt1}, {X1, _Alt2}) ->
	x_igual.

verifica_altura_e_chama_uniao(ListaDePares1, ListaDePares2, []) ->
	[Primeiro1 | Resto1] = ListaDePares1,
	uniao_recursiva(ListaDePares2, Resto1, [Primeiro1]);
	
verifica_altura_e_chama_uniao(ListaDePares1, ListaDePares2, Resultado) ->
	[Primeiro1 | Resto1] = ListaDePares1,
	{_, Altura1} = Primeiro1,
	[{_, AlturaUltimo} | _ ] = Resultado,	
	case AlturaUltimo < Altura1 of
		true -> uniao_recursiva(ListaDePares2, Resto1, [Primeiro1 | Resultado]);
		false -> uniao_recursiva(Resto1, ListaDePares2, Resultado)
	end.

escolhe_maior_altura_e_chama_uniao(ListaDePares1, ListaDePares2, []) ->
	{ListaComElementoMaiorAltura, ListaComMenor} = lista_com_maior_altura(ListaDePares1, ListaDePares2),
	[ElementoComAlturaMaior | RestoComMaiorAltura] = ListaComElementoMaiorAltura,
	[_ | RestoComMenorAltura] = ListaComMenor,
	uniao_recursiva(RestoComMenorAltura, RestoComMaiorAltura, [ElementoComAlturaMaior]);
	
escolhe_maior_altura_e_chama_uniao(ListaDePares1, ListaDePares2, Resultado) ->
	[_| Resto1] = ListaDePares1,
	[_| Resto2] = ListaDePares2,
	
	[{_, AlturaUltimo} | _ ] = Resultado,
	{ListaComElementoMaiorAltura, ListaComMenor} = lista_com_maior_altura(ListaDePares1, ListaDePares2),
	[ElementoComAlturaMaior | RestoComMaiorAltura] = ListaComElementoMaiorAltura,
	[_ | RestoComMenorAltura] = ListaComMenor,
	{_, AlturaDoElementoMaior} = ElementoComAlturaMaior, 
	case AlturaDoElementoMaior == AlturaUltimo of
		true -> uniao_recursiva(Resto1, Resto2, Resultado);
		false -> uniao_recursiva(RestoComMenorAltura, RestoComMaiorAltura, [ElementoComAlturaMaior | Resultado])
	end.
	
lista_com_maior_altura(ListaDePares1, ListaDePares2) ->
	[{_, Alt1} | _] = ListaDePares1,
	[{_, Alt2} | _] = ListaDePares2,
	case Alt1 < Alt2 of
		true -> {ListaDePares2, ListaDePares1};
		false -> {ListaDePares1, ListaDePares2}
	end.