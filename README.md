# Processador RISC-V em Verilog

## 📌 Descrição

Este projeto implementa um processador RISC-V de ciclo único em Verilog, compatível com o subconjunto RV32I. Desenvolvido com foco educacional, o projeto prioriza clareza e modularidade, permitindo a simulação de instruções básicas, como `add`, `sub`, `and`, `or`, `lw`, `sw` e `beq`.

---

## 🧠 Arquitetura

O processador segue a arquitetura RISC-V de 32 bits e é composto pelos seguintes módulos principais:

- **Unidade Lógica e Aritmética (ULA):** Executa operações aritméticas e lógicas.
- **Banco de Registradores:** Armazena os 32 registradores de 32 bits do RV32I.
- **Memória de Instruções:** Contém o código do programa em formato binário.
- **Memória de Dados:** Gerencia operações de leitura e escrita de dados.
- **Unidade de Controle:** Decodifica instruções e gera sinais de controle.
- **Gerador de Imediato:** Extrai e formata valores imediatos das instruções.
- **Datapath (Caminho de Dados):** Integra os módulos para executar instruções.
- **Testbench:** Simula o comportamento do processador para testes.

---

## 🛠️ Requisitos

Para compilar e simular o projeto, você precisará das seguintes ferramentas:

- [Icarus Verilog](http://iverilog.icarus.com/) (compilador Verilog)
- [GTKWave](http://gtkwave.sourceforge.net/) (visualizador de formas de onda)
- [Make](https://www.gnu.org/software/make/) (opcional, para usar o Makefile)

---

## 🚀 Instruções para Simulação

### 🔧 Usando o Makefile

O projeto inclui um Makefile para facilitar a compilação e simulação. Execute os comandos abaixo no terminal:

```bash
# Compila todos os módulos e gera o binário .vvp
make vvp

# Gera o arquivo vcd
make vcd

# Abre o GTKWave com o dump de sinais
make gtkwave

# Limpa arquivos de testbench gerados
make clean
```

### 🔸 Forma Tradicional (Sem Makefile)

Se preferir compilar manualmente, use os comandos abaixo:

```bash
# Compilação com iverilog
iverilog -o testbench_tb.vvp testbench_tb.v ./datapath/datapath.v ./blocos_auxiliares/gerador_imediato/gerador_imediato.v ./blocos_auxiliares/mux/mux.v ./memoria/modulo_instrucao/memoria_instrucao.v ./memoria/modulo_dados/memoria_dados.v ./memoria/modulo_registradores/memoria_registradores.v ./ula/ula.v ./ula/ula_control.v ./unidade_controle/unidade_controle.v

# Geração do arquivo vcd
vvp testbench_tb.vvp

# Visualização dos sinais no GTKWave
gtkwave testbench_result.vcd
```

---

## 📂 Estrutura do Projeto

```plaintext
├── ula.v                      # Módulo da Unidade Lógica e Aritmética
├── ula_control.v              # Controle da ULA
├── unidade_cotrole.v          # Unidade de Controle
├── gerador_imediato.v         # Gerador de Imediato
├── mux.v                      # Multiplexador
├── memoria_instrucao.v        # Memória de Instruções
├── memoria_registradores.v    # Banco de Registradores
├── memoria_dados.v            # Memória de Dados
├── datapath.v                 # Caminho de Dados
├── tb.v                       # Testbench para simulação
├── Makefile                   # Script para automação
└── README.md                  # Documentação do projeto
```

---

### 👀 Imagem do processador de referência abaixo

![image](https://github.com/user-attachments/assets/18fdaef1-761a-406f-a503-93c99a31067b)


## 🛠 Contribuições

Um grande agradecimento a todos que contribuíram para o projeto. Abaixo estão alguns dos principais colaboradores:

- [Henrique Martins](https://github.com/hmartiins)  
- [João Victor](https://github.com/joaovds)  
- [Gabriel Carvalho](https://github.com/GabrielQuinteiro)  
- [Leticia Silverio](https://github.com/devLeSilverio)  
- [Vitor Cavicchiolli](https://github.com/Vitorcavic)  
- [Rennys Cardoso](https://github.com/yrsenn)


