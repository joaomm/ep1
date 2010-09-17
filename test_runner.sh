#!/bin/sh

erlc silhueta_test.erl
erlc silhueta.erl

erl -noshell -s silhueta_test test -s init stop