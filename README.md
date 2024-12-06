# INF1022
Compilador de Matemágica

##### Gramática Original

programa            → cmds
cmds                → cmd | cmd cmds
cmd                 → atribuicao | impressao | operacao | repeticao
atribuicao          → FACA var SER num.
impressao           → MOSTRE var. | MOSTRE operacao.
operacao            → SOME var COM var. | SOME var COM num. | SOME num COM num.
repeticao           → REPITA num VEZES: cmds FIM

##### Gramática Alterada

programa            → cmd_list
cmd_list            → cmd. cmd_list | cmd.
cmd                 → atribuicao | impressao | operacao | repeticao | controle

atribuicao          → FACA var SER valor
impressao           → MOSTRE valor
operacao            → SOME var COM valor | SOME num COM valor MOSTRANDO | MULTIPLIQUE var POR valor | MULTIPLIQUE num POR valor MOSTRANDO
repeticao           → REPITA valor VEZES: cmd_list FIM
controle            → SE expressao_booleana ENTAO cmd_list opt_senao FIM
opt_senao           → SENAO cmd_list | epsilon
expressao_booleana  → valor | comparacao | comparacao operador_logico comparacao
comparacao          → valor operador_relacional valor 
operador_relacional → FOR MAIOR QUE | FOR MENOR QUE | FOR IGUAL A
operador_logico     → OU | E
valor               → var | num