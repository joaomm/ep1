-module(ler).
-export([edificios/1]).

edificios(Filename) ->
	{ok, S} = file:open(Filename, read),
	Tamanho = ler_tamanho(S),
	ListaEdificios = ler_edificio_e_retornar_lista(Tamanho, S, []),
	file:close(S),
	ListaEdificios.

ler_tamanho(S) ->
	{ok, [Tamanho]} = io:fread(S, '', "~d"),
	Tamanho.

ler_edificio_e_retornar_lista(0, _, ListaEdificios) ->
	ListaEdificios;

ler_edificio_e_retornar_lista(Tamanho, S, ListaEdificios) ->
	Edificio = ler_edificio(S),
	ler_edificio_e_retornar_lista(Tamanho - 1, S, [Edificio| ListaEdificios]).
	
ler_edificio(S) ->
	{ok, [E, Altura, D]} = io:fread(S, '', "~d ~d ~d"),
	{E, Altura, D}.
