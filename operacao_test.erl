-module (operacao_test).
-include_lib("eunit/include/eunit.hrl").

silhueta_de_edificio_test() ->
	[          
		?assertEqual(operacao:silhueta_de_edificio({0, 1, 1}), [{0, 1}, {1, 0}]),
		?assertEqual(operacao:silhueta_de_edificio({0, 2, 1}), [{0, 2}, {1, 0}]),
		?assertEqual(operacao:silhueta_de_edificio({0, 2, 2}), [{0, 2}, {2, 0}]),
		?assertEqual(operacao:silhueta_de_edificio({1, 2, 2}), [{1, 2}, {2, 0}]),
		?assertEqual(operacao:silhueta_de_edificio({12, 7, 16}), [{12, 7}, {16, 0}])		
	].