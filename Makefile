PROJECT = minmay

include erlang.mk

TEST_ERLC_OPTS += +debug_info
CT_OPTS += -cover test/cover.spec -vvv -erl_args -boot start_sasl 

SHELL_OPTS = -name ${PROJECT}@`hostname` -s ${PROJECT} -pa ebin deps/*/ebin
