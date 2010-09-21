-module (silhueta_test).
-include_lib("eunit/include/eunit.hrl").

silhueta_de_edificio_test_() ->
	[
		?_assert(silhueta:silhueta_de_edificio({0, 1, 1}) == [{0, 1}, {1, 0}]),
		?_assert(silhueta:silhueta_de_edificio({0, 2, 1}) == [{0, 2}, {1, 0}]),
		?_assert(silhueta:silhueta_de_edificio({0, 2, 2}) == [{0, 2}, {2, 0}]),
		?_assert(silhueta:silhueta_de_edificio({1, 2, 2}) == [{1, 2}, {2, 0}]),
		?_assert(silhueta:silhueta_de_edificio({12, 7, 16}) == [{12, 7}, {16, 0}])		
	].
	
uniao_nao_grudados_test_() ->
	[
		?_assert(silhueta:uniao([{0, 1},{1, 0}], [{2, 1}, {3, 0}]) == [{0, 1}, {1, 0}, {2, 1}, {3, 0}]),
		?_assert(silhueta:uniao([{0, 1},{1, 0}], [{3, 1}, {4, 0}]) == [{0, 1}, {1, 0}, {3, 1}, {4, 0}])
	].

uniao_grudados_e_mesma_altura_test_() ->
	[
		?_assert(silhueta:uniao([{0, 1},{1, 0}], [{1, 1}, {2, 0}]) == [{0, 1}, {2, 0}]),
		?_assert(silhueta:uniao([{0, 2},{1, 0}], [{1, 2}, {2, 0}]) == [{0, 2}, {2, 0}]),
		?_assert(silhueta:uniao([{0, 2},{1, 0}], [{1, 2}, {3, 0}]) == [{0, 2}, {3, 0}]),
		?_assert(silhueta:uniao([{1, 2},{2, 0}], [{2, 2}, {3, 0}]) == [{1, 2}, {3, 0}]),
		?_assert(silhueta:uniao([{0, 2},{2, 0}], [{2, 2}, {3, 0}]) == [{0, 2}, {3, 0}])		
	].

