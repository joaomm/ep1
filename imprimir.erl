-module(imprimir).
-export([silhueta/2]).

silhueta(stdout, Silhueta) ->
	imprimir_silhueta(stdout, Silhueta);

silhueta(NomeArquivo, Silhueta) ->
	{ok, S} = file:open(NomeArquivo, write),
	imprimir_silhueta(S, Silhueta),
	file:close(S).

imprimir_silhueta(IoDevice, Silhueta) ->
	imprimir_comprimento_silhueta(IoDevice, Silhueta),
	imprimir_lista(IoDevice, Silhueta).

imprimir_comprimento_silhueta(IoDevice, Silhueta) ->
	imprimir(IoDevice, "~p~n", [length(Silhueta)]).
	
imprimir_lista(_, []) ->
	ok;

imprimir_lista(IoDevice, [{X, Alt} | Resto]) ->
	imprimir(IoDevice, "~p ~p~n", [X, Alt]),
	imprimir_lista(IoDevice, Resto).

imprimir(stdout, Formato, Dados) ->
	io:fwrite(Formato, Dados);

imprimir(NomeArquivo, Formato, Dados) ->
	io:fwrite(NomeArquivo, Formato, Dados).