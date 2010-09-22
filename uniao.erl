-module (uniao).
-export ([recursiva/2]).

recursiva(ListaDePares1, ListaDePares2) ->
	recursiva(ListaDePares1, ListaDePares2, [], 0).

recursiva([], ListaDePares2, Resultado, _) ->
	lists:reverse(Resultado) ++ ListaDePares2;

recursiva(ListaDePares1, [], Resultado, _) ->
	lists:reverse(Resultado) ++ ListaDePares1;
	
recursiva(ListaDePares1, ListaDePares2, Resultado, UltimaAlturaSilhuetaOposta) ->
	[Primeiro1 | _] = ListaDePares1,
	[Primeiro2 | _] = ListaDePares2,
    case compara(Primeiro1, Primeiro2) of
		x_do_primeiro_mais_a_esquerda -> verifica_se_esta_encoberto_e_chama_uniao(ListaDePares1, ListaDePares2, Resultado, UltimaAlturaSilhuetaOposta);
		x_do_segundo_mais_a_esquerda -> verifica_altura_da_ultima_silhueta_e_chama_uniao(ListaDePares1, ListaDePares2, Resultado, UltimaAlturaSilhuetaOposta);
		x_iguais -> escolhe_maior_altura_e_chama_uniao(ListaDePares1, ListaDePares2, Resultado, UltimaAlturaSilhuetaOposta)
	end.
	
compara({X1, _Alt1}, {X2, _Alt2}) when X1 < X2 ->
	x_do_primeiro_mais_a_esquerda;

compara({X1, _Alt1}, {X2, _Alt2}) when X1 > X2 ->
	x_do_segundo_mais_a_esquerda;

compara({X1, _Alt1}, {X1, _Alt2}) ->
	x_iguais.
	
verifica_se_esta_encoberto_e_chama_uniao(ListaDePares1, ListaDePares2, [], _) ->
	[Primeiro1 | Resto1] = ListaDePares1,
	recursiva(ListaDePares2, Resto1, [Primeiro1], 0);
	
verifica_se_esta_encoberto_e_chama_uniao(ListaDePares1, ListaDePares2, Resultado, _) ->
	[Primeiro1 | Resto1] = ListaDePares1,
	{_, Altura1} = Primeiro1,
	[{_, AlturaUltimo} | _ ] = Resultado,	
	case AlturaUltimo < Altura1 of
		true -> recursiva(ListaDePares2, Resto1, [Primeiro1 | Resultado], AlturaUltimo);
		false -> recursiva(Resto1, ListaDePares2, Resultado, Altura1)
	end.
	
verifica_altura_da_ultima_silhueta_e_chama_uniao(ListaDePares1, ListaDePares2, Resultado, UltimaAlturaSilhuetaOposta) ->
	[Elemento | Resto2] = ListaDePares2,
	{X, Alt} = Elemento,
	case UltimaAlturaSilhuetaOposta < Alt of
		true -> recursiva(ListaDePares1, Resto2, [Elemento | Resultado], UltimaAlturaSilhuetaOposta);
		false -> recursiva(Resto2, ListaDePares1, [{X, UltimaAlturaSilhuetaOposta} | Resultado], Alt)
	end.
	
escolhe_maior_altura_e_chama_uniao(ListaDePares1, ListaDePares2, [], _) ->
	{ListaComElementoMaiorAltura, ListaComMenor} = lista_com_maior_altura(ListaDePares1, ListaDePares2),
	[ElementoComAlturaMaior | RestoComMaiorAltura] = ListaComElementoMaiorAltura,
	[{_,AlturaMenor} | RestoComMenorAltura] = ListaComMenor,
	recursiva(RestoComMenorAltura, RestoComMaiorAltura, [ElementoComAlturaMaior], AlturaMenor);
	
escolhe_maior_altura_e_chama_uniao(ListaDePares1, ListaDePares2, Resultado, _) ->
	[_| Resto1] = ListaDePares1,
	[_| Resto2] = ListaDePares2,
	
	[{_, AlturaUltimo} | _ ] = Resultado,
	{ListaComElementoMaiorAltura, ListaComMenor} = lista_com_maior_altura(ListaDePares1, ListaDePares2),
	[ElementoComAlturaMaior | RestoComMaiorAltura] = ListaComElementoMaiorAltura,
	[{_, AlturaMenor} | RestoComMenorAltura] = ListaComMenor,
	{_, AlturaDoElementoMaior} = ElementoComAlturaMaior, 
	case AlturaDoElementoMaior == AlturaUltimo of
		true -> recursiva(Resto1, Resto2, Resultado, 0);
		false -> recursiva(RestoComMenorAltura, RestoComMaiorAltura, [ElementoComAlturaMaior | Resultado], AlturaMenor)
	end.

lista_com_maior_altura(ListaDePares1, ListaDePares2) ->
	[{_, Alt1} | _] = ListaDePares1,
	[{_, Alt2} | _] = ListaDePares2,
	case Alt1 < Alt2 of
		true -> {ListaDePares2, ListaDePares1};
		false -> {ListaDePares1, ListaDePares2}
	end.
	