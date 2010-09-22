-module (fold_test).
-include_lib("eunit/include/eunit.hrl").

fold_com_um_edificio_test() ->
	[
		?assertEqual(fold:silhueta_com_foldr([{0, 1, 1}]), [{0,1}, {1, 0}]),
		?assertEqual(fold:silhueta_com_foldl([{0, 1, 1}]), [{0,1}, {1, 0}])
	].
	
fold_com_dois_edificios_test() ->
	[
		?assertEqual(fold:silhueta_com_foldr([{0, 1, 1}, {2, 1, 3}]), [{0,1}, {1, 0}, {2, 1}, {3, 0}]),
		?assertEqual(fold:silhueta_com_foldl([{0, 1, 1}, {2, 1, 3}]), [{0,1}, {1, 0}, {2, 1}, {3, 0}])
	].

fold_com_tres_edificios_test() ->
   	[
   		?assertEqual(fold:silhueta_com_foldr([{0, 1, 1}, {1, 2, 3}]), [{0,1}, {1, 2}, {3, 0}]),
		?assertEqual(fold:silhueta_com_foldl([{0, 1, 1}, {1, 2, 3}]), [{0,1}, {1, 2}, {3, 0}])
   	].

fold_com_exemplo_do_enunciado_test() ->
   [
   		?assertEqual(fold:silhueta_com_foldr([{12, 7, 16}, {2, 6, 7}, {1, 11, 5}, {24, 4, 28}, {3, 13, 9}, {19, 18, 22}, {23, 13, 29}, {14, 3, 25}]), 
   									[{1,11}, {3,13}, {9,0}, {12,7}, {16,3}, {19,18}, {22,3}, {23,13}, {29,0}]),
		?assertEqual(fold:silhueta_com_foldl([{12, 7, 16}, {2, 6, 7}, {1, 11, 5}, {24, 4, 28}, {3, 13, 9}, {19, 18, 22}, {23, 13, 29}, {14, 3, 25}]), 
   									[{1,11}, {3,13}, {9,0}, {12,7}, {16,3}, {19,18}, {22,3}, {23,13}, {29,0}])
   ].