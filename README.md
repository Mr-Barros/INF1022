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
cmds                → cmd. cmd_list | cmd.
cmd                 → atribuicao | impressao | operacao | repeticao | controle

atribuicao          → FACA var SER valor
impressao           → MOSTRE valor
operacao            → operador_numerico var COM valor | operador_numerico num COM valor MOSTRANDO
operador_numerico   → SOME | MULTIPLIQUE
repeticao           → REPITA valor VEZES: cmd_list FIM
controle            → SE expressao_booleana ENTAO cmd_list opt_senao FIM DO SE
opt_senao           → SENAO cmd_list | epsilon
expressao_booleana  → comparacao | comparacao operador_logico comparacao
comparacao          → valor operador_relacional valor 
operador_relacional → FOR MAIOR QUE | FOR MENOR QUE | FOR IGUAL A
operador_logico     → OU | E
valor               → var | num