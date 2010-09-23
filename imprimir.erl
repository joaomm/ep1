-module(imprimir).
-export([lista/2]).

lista(Filename, Lista) ->
	{ok, S} = file:open(Filename, write),
	io:format(S,"~p~n",	[length(Lista)]),
	imprimir_elemento_no_arquivo(S, Lista),
	file:close(S).

imprimir_elemento_no_arquivo(_, []) ->
	ok;

imprimir_elemento_no_arquivo(S, [{X, Alt} | Tail]) ->
	io:format(S, "~p ~p~n", [X, Alt]),
	imprimir_elemento_no_arquivo(S, Tail).
