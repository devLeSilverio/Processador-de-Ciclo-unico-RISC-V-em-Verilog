SRC = \
    testbench_tb.v \
    ./datapath/datapath.v \
    ./blocos_auxiliares/gerador_imediato/gerador_imediato.v \
    ./blocos_auxiliares/mux/mux.v \
    ./memoria/modulo_instrucao/memoria_instrucao.v \
    ./memoria/modulo_dados/memoria_dados.v \
    ./memoria/modulo_registradores/memoria_registradores.v \
    ./ula/ula.v \
    ./ula/ula_control.v \
    ./unidade_controle/unidade_controle.v

all: vvp

vvp:
	iverilog -o testbench_tb.vvp $(SRC)

vcd: vvp
	vvp testbench_tb.vvp

gtkwave: vcd
	gtkwave testbench_result.vcd

clean:
	del /q testbench_tb.vvp testbench_.vcd 2>nul || rm -f testbench_tb.vvp testbench_.vcd

.PHONY: all vvp vcd gtkwave clean