test_silhueta: compile_silhueta
	erl -noshell -s silhueta_test test -s init stop

compile_silhueta: silhueta.beam silhueta_test.beam

silhueta.beam: silhueta.erl
	erlc silhueta.erl
	
silhueta_test.beam: silhueta_test.erl
	erlc silhueta_test.erl

clean:
	rm -f *.beam
