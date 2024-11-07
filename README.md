# INF1022
Compilador de Matemágica

##### Gramática Original

programa    → cmds
cmds        → cmd | cmd cmds
cmd         → atribuicao | impressao | operacao | repeticao
atribuicao  → FACA var SER num.
impressao   → MOSTRE var. | MOSTRE operacao.
operacao    → SOME var COM var. | SOME var COM num. | SOME num COM num.
repeticao   → REPITA num VEZES: cmds FIM

##### Gramática Alterada

programa    → cmds
cmds        → cmd | cmd cmds
cmd         → atribuicao | impressao | operacao | repeticao | controle

atribuicao  → FACA var SER valor.
impressao   → MOSTRE valor. | MOSTRE operacao.
operacao    → SOME valor COM valor. | MULTIPLIQUE valor POR valor.
repeticao   → REPITA valor VEZES: cmds FIM. | REPITA ENQUANTO condicao: cmds FIM.
controle    → SE condicao ENTAO cmds. | SE condicao ENTAO cmds SENAO cmds.

condicao    → valor FOR IGUAL A valor | valor FOR MAIOR QUE valor | valor FOR MENOR QUE valor |
              condicao OU condicao | condicao E condicao
valor       → var | num