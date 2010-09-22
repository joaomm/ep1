test_all: test_operacao test_uniao test_algoritmo1 test_algoritmo2

test_operacao: uniao_compile operacao_compile
	erl -noshell -s operacao_test test -s init stop

operacao_compile: operacao.beam operacao_test.beam

operacao.beam: operacao.erl
	erlc operacao.erl

operacao_test.beam: operacao.erl
	erlc operacao_test.erl

test_uniao: uniao_compile
	erl -noshell -s uniao_test test -s init stop

uniao_compile: uniao.beam uniao_test.beam

uniao.beam: uniao.erl
	erlc uniao.erl
	
uniao_test.beam: uniao_test.erl
	erlc uniao_test.erl

test_algoritmo1: algoritmo1_compile
	erl -noshell -s algoritmo1_test test -s init stop

algoritmo1_compile: uniao_compile operacao_compile algoritmo1.beam algoritmo1_test.beam

algoritmo1.beam: algoritmo1.erl
	erlc algoritmo1.erl
	
algoritmo1_test.beam: algoritmo1_test.erl
	erlc algoritmo1_test.erl

test_algoritmo2: algoritmo2_compile
	erl -noshell -s algoritmo2_test test -s init stop

algoritmo2_compile: uniao_compile operacao_compile algoritmo2.beam algoritmo2_test.beam

algoritmo2.beam: algoritmo2.erl
	erlc algoritmo2.erl

algoritmo2_test.beam: algoritmo2_test.erl
	erlc algoritmo2_test.erl

clean:
	rm -f *.beam
