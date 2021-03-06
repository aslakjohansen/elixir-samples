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

scriptexec:
	elixir math.exs # extension "exs" indicates that it is a script but that is simply a convention

