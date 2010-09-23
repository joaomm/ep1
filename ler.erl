-module(ler).
-export([edificios/1]).

edificios(stdin) ->
	ler_edificios(stdin);

edificios(Filename) ->
	{ok, S} = file:open(Filename, read),
	ListaEdificios = ler_edificios(S),
	file:close(S),
	ListaEdificios.

ler_edificios(S) ->
	Tamanho = ler_tamanho(S),
	ler_edificio_e_retornar_lista(Tamanho, S, []).

ler_tamanho(S) ->
	[Tamanho] = ler(S, "~d"),
	Tamanho.

ler_edificio_e_retornar_lista(0, _, ListaEdificios) ->
	ListaEdificios;

ler_edificio_e_retornar_lista(Tamanho, S, ListaEdificios) ->
	Edificio = ler_edificio(S),
	ler_edificio_e_retornar_lista(Tamanho - 1, S, [Edificio| ListaEdificios]).

ler_edificio(S) ->
	[E, Altura, D] = ler(S, "~d ~d ~d"),
	{E, Altura, D}.

ler(stdin, Formato) ->
	{ok, Dados} = io:fread('', Formato),
	Dados;

ler(S, Formato) ->
	{ok, Dados} = io:fread(S, '', Formato),
	Dados.
