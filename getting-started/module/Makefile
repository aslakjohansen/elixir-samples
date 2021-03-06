TARGETS = \
	Elixir.Math.beam \

all: ${TARGETS}

clean:
	touch ${TARGETS}
	rm    ${TARGETS}

mrproper: clean
	touch d~
	rm    *~

Elixir.Math.beam: math.ex
	elixirc math.ex

