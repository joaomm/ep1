test_silhueta: compile_silhueta
	erl -noshell -s silhueta_test test -s init stop

compile_silhueta: uniao.beam silhueta.beam silhueta_test.beam

uniao.beam: uniao.erl
	erlc uniao.erl
	
silhueta.beam: silhueta.erl
	erlc silhueta.erl
	
silhueta_test.beam: silhueta_test.erl
	erlc silhueta_test.erl

clean:
	rm -f *.beam
