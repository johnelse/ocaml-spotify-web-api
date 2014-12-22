all: build

NAME=spotify-web-api
J=4

TESTS_FLAG=--enable-tests

ATDGEN_FILES=$(wildcard lib/*.atd)
ATDGEN_J_FILES=$(ATDGEN_FILES:.atd=_j.ml)
ATDGEN_T_FILES=$(ATDGEN_FILES:.atd=_t.ml)

lib/%_j.ml: lib/%.atd
	atdgen -j $<

lib/%_t.ml: lib/%.atd
	atdgen -t $<

setup.data: $(ATDGEN_J_FILES) $(ATDGEN_T_FILES)
	ocaml setup.ml -configure $(TESTS_FLAG)

build: setup.data
	ocaml setup.ml -build -j $(J)

test: build
	ocaml setup.ml -test

install: setup.ml
	ocaml setup.ml -install

uninstall:
	ocamlfind remove $(NAME)

reinstall: setup.data
	ocamlfind remove $(NAME) || true
	ocaml setup.ml -reinstall

clean:
	ocamlbuild -clean
	$(foreach FILE, $(ATDGEN_FILES), rm -f `atdgen -list $(FILE)`)
	rm -f setup.data setup.log
