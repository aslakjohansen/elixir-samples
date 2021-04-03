TARGETS = \
	 \

all: ${TARGETS}

clean:
	touch ${TARGETS}
	rm    ${TARGETS}

mrproper: clean
	touch d~
	rm    *~

deps:
	sudo apt-get install erlang-debugger

Elixir.Example.beam: example.ex
	elixirc example.ex 

