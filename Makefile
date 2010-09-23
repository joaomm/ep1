all_tests: operacao_test uniao_test algoritmo1_test algoritmo2_test fold_test imprimir_test

operacao_test: operacao_compile
	erl -noshell -s operacao_test test -s init stop

operacao_compile: uniao_compile operacao.beam operacao_test.beam

operacao.beam: operacao.erl
	erlc operacao.erl

operacao_test.beam: operacao.erl
	erlc operacao_test.erl

uniao_test: uniao_compile
	erl -noshell -s uniao_test test -s init stop

uniao_compile: uniao.beam uniao_test.beam

uniao.beam: uniao.erl
	erlc uniao.erl
	
uniao_test.beam: uniao_test.erl
	erlc uniao_test.erl

algoritmo1_test: algoritmo1_compile
	erl -noshell -s algoritmo1_test test -s init stop

algoritmo1_compile: uniao_compile operacao_compile algoritmo1.beam algoritmo1_test.beam

algoritmo1.beam: algoritmo1.erl
	erlc algoritmo1.erl
	
algoritmo1_test.beam: algoritmo1_test.erl
	erlc algoritmo1_test.erl

algoritmo2_test: algoritmo2_compile
	erl -noshell -s algoritmo2_test test -s init stop

algoritmo2_compile: uniao_compile operacao_compile algoritmo2.beam algoritmo2_test.beam

algoritmo2.beam: algoritmo2.erl
	erlc algoritmo2.erl

algoritmo2_test.beam: algoritmo2_test.erl
	erlc algoritmo2_test.erl

fold_test: operacao_compile fold_compile
	erl -noshell -s fold_test test -s init stop

fold_compile: fold.beam fold_test.beam

fold.beam: fold.erl
	erlc fold.erl

fold_test.beam: fold_test.erl
	erlc fold_test.erl

imprimir_test: operacao_compile imprimir_compile
	erl -noshell -s imprimir_test test -s init stop

imprimir_compile: imprimir.beam imprimir_test.beam algoritmo1.beam

imprimir.beam: imprimir.erl
	erlc imprimir.erl

imprimir_test.beam: imprimir_test.erl
	erlc imprimir_test.erl

clean:
	rm -f *.beam
