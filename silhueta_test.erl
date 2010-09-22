-module (silhueta_test).
-include_lib("eunit/include/eunit.hrl").

silhueta_de_edificio_test() ->
	[          
		?assertEqual(silhueta:silhueta_de_edificio({0, 1, 1}), [{0, 1}, {1, 0}]),
		?assertEqual(silhueta:silhueta_de_edificio({0, 2, 1}), [{0, 2}, {1, 0}]),
		?assertEqual(silhueta:silhueta_de_edificio({0, 2, 2}), [{0, 2}, {2, 0}]),
		?assertEqual(silhueta:silhueta_de_edificio({1, 2, 2}), [{1, 2}, {2, 0}]),
		?assertEqual(silhueta:silhueta_de_edificio({12, 7, 16}), [{12, 7}, {16, 0}])		
	].

algoritmo1_test() ->
	[
		?assertEqual(silhueta:algoritmo1([{0, 1, 1}]), [{0,1}, {1, 0}]),
		?assertEqual(silhueta:algoritmo1([{0, 1, 1}, {2, 1, 3}]), [{0,1}, {1, 0}, {2, 1}, {3, 0}]),
		?assertEqual(silhueta:algoritmo1([{0, 1, 1}, {1, 2, 3}]), [{0,1}, {1, 2}, {3, 0}]),
		?assertEqual(silhueta:algoritmo1([{12, 7, 16}, {2, 6, 7}, {1, 11, 5}, {24, 4, 28}, {3, 13, 9}, {19, 18, 22}, {23, 13, 29}, {14, 3, 25}]), 
										[{1,11}, {3,13}, {9,0}, {12,7}, {16,3}, {19,18}, {22,3}, {23,13}, {29,0}])
	].

uniao_nao_grudados_test() ->
	[
		?assertEqual(silhueta:uniao([{0, 1},{1, 0}], [{2, 1}, {3, 0}]), [{0, 1}, {1, 0}, {2, 1}, {3, 0}]),
		?assertEqual(silhueta:uniao([{0, 1},{1, 0}], [{3, 1}, {4, 0}]), [{0, 1}, {1, 0}, {3, 1}, {4, 0}])
	].

uniao_grudados_e_mesma_altura_test() ->
	[
		?assertEqual(silhueta:uniao([{0, 1},{1, 0}], [{1, 1}, {2, 0}]), [{0, 1}, {2, 0}]),
		?assertEqual(silhueta:uniao([{0, 2},{1, 0}], [{1, 2}, {2, 0}]), [{0, 2}, {2, 0}]),
		?assertEqual(silhueta:uniao([{0, 2},{1, 0}], [{1, 2}, {3, 0}]), [{0, 2}, {3, 0}]),
		?assertEqual(silhueta:uniao([{1, 2},{2, 0}], [{2, 2}, {3, 0}]), [{1, 2}, {3, 0}]),
		?assertEqual(silhueta:uniao([{0, 2},{2, 0}], [{2, 2}, {3, 0}]), [{0, 2}, {3, 0}]),
		?assertEqual(silhueta:uniao([{2, 2}, {3, 0}], [{0, 2},{2, 0}]), [{0, 2}, {3, 0}])
	].

uniao_grudados_com_alturas_diferentes_test() ->
	[
		?assertEqual(silhueta:uniao([{0, 1}, {1, 0}], [{1, 2}, {2, 0}]), [{0, 1}, {1, 2}, {2, 0}]),
		?assertEqual(silhueta:uniao([{0, 3}, {1, 0}], [{1, 2}, {2, 0}]), [{0, 3}, {1, 2}, {2, 0}])
	].

uniao_com_sobreposicao_total_test() ->
	[
		?assertEqual(silhueta:uniao([{0, 2}, {3, 0}], [{1, 1}, {2, 0}]), [{0, 2}, {3, 0}]),
		?assertEqual(silhueta:uniao([{1, 1}, {2, 0}], [{0, 2}, {3, 0}]), [{0, 2}, {3, 0}])
	].
	
uniao_de_sobreposicao_com_ordem_importando_test() ->
	[
		?assertEqual(silhueta:uniao([{1,1}, {2,0}, {3,1}, {4,0}], [{2,2}, {5, 0}]), [{1,1}, {2,2}, {5,0}])
	].
	
uniao_de_identicos_test() ->
	[
		?assertEqual(silhueta:uniao([{1,2}, {2,0}], [{1,2}, {2,0}]), [{1,2}, {2,0}])
	].

uniao_com_descida_test() ->
	[
		?assertEqual(silhueta:uniao([{0,2}, {2,0}], [{0,1}, {3,0}]), [{0,2}, {2,1}, {3,0}]),
		?assertEqual(silhueta:uniao([{0,1}, {5,0}], [{1,3}, {2,0}, {3,2}, {4,0}]), [{0,1},{1,3},{2,1},{3,2},{4,1},{5,0}]),
		?assertEqual(silhueta:uniao([{1,3}, {2,0}, {3,2}, {4,0}], [{0,1}, {5,0}]), [{0,1},{1,3},{2,1},{3,2},{4,1},{5,0}]),
		?assertEqual(silhueta:uniao([{1,4}, {2,1}, {3,3}, {4,0}], [{0,2}, {5,0}]), [{0,2},{1,4},{2,2},{3,3},{4,2},{5,0}])
	].
	
uniao_master_test() ->
	[
		?assertEqual(silhueta:uniao([{1,11}, {3,13}, {9,0}], [{2,6}, {7,0}]), [{1,11}, {3,13}, {9,0}]),
		?assertEqual(silhueta:uniao([{1,11}, {3,13}, {9,0}, {14, 3}, {23,13}, {29,0}], 
									[{2,6}, {7,0}, {12, 7}, {16,0}]),
									[{1,11}, {3,13}, {9,0}, {12,7}, {16,3}, {23,13}, {29,0}]),
		?assertEqual(silhueta:uniao([{1,11}, {3,13}, {9,0}, {14, 3}, {23,13}, {29,0}],
									[{2,6}, {7,0}, {12, 7}, {16,0}, {19,18}, {22, 0}, {24,4}, {27,0}]),
									[{1,11}, {3,13}, {9,0}, {12,7}, {16,3}, {19,18}, {22,3}, {23,13}, {29,0}]),
   		?assertEqual(silhueta:uniao([{1,11}, {3,13}, {9,0}, {14, 3}, {23,13}, {29,0}],
   									[{2,6}, {7,0}, {12, 7}, {16,0}, {19,18}, {22, 0}, {23,3}, {24,4}, {27,0}]),
   									[{1,11}, {3,13}, {9,0}, {12,7}, {16,3}, {19,18}, {22,3}, {23,13}, {29,0}])
	].

uniao_enunciado_test() ->
	[
		?assertEqual(silhueta:uniao([{12,4},{16,17},{19,14},{22,9},{27,0}],
									[{14,6}, {18,16}, {20, 11}, {23, 5}, {25,0}]),
									[{12,4}, {14,6}, {16, 17}, {19, 16}, {20, 14}, {22, 11}, {23, 9}, {27,0}]),

		?assertEqual(silhueta:uniao([{3,6},{7,2},{8,9},{12,4},{16,17},{19,14},{22,9},{27,0}],
									[{5,4}, {9,13}, {14,6}, {18,16}, {20, 11}, {23, 5}, {25,0}]),
									[{3,6}, {7,4}, {8,9}, {9,13}, {14,6}, {16, 17}, {19, 16}, {20, 14}, {22, 11}, {23, 9}, {27,0}]),
									
		?assertEqual(silhueta:uniao([{5,4}, {9,13}, {14,6}, {18,16}, {20, 11}, {23, 5}, {25,0}],
									[{3,6},{7,2},{8,9},{12,4},{16,17},{19,14},{22,9},{27,0}]),
									[{3,6}, {7,4}, {8,9}, {9,13}, {14,6}, {16, 17}, {19, 16}, {20, 14}, {22, 11}, {23, 9}, {27,0}])
	].