-module (silhueta_test).
-compile(export_all).
-include_lib("eunit/include/eunit.hrl").

silhueta_de_edificio_test_() ->
	[
		?_assert(silhueta:silhueta_de_edificio({0, 1, 1}) == [{0,1}, {1,0}]),
		?_assert(silhueta:silhueta_de_edificio({0, 2, 1}) == [{0,2}, {1,0}]),
		?_assert(silhueta:silhueta_de_edificio({0, 2, 2}) == [{0,2}, {2,0}]),
		?_assert(silhueta:silhueta_de_edificio({1, 2, 2}) == [{1,2}, {2,0}]),
		?_assert(silhueta:silhueta_de_edificio({12, 7, 16}) == [{12,7}, {16,0}])		
	].