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
cmds        → cmd. cmds | cmd.
cmd         → atribuicao | impressao | operacao | repeticao | controle

atribuicao  → FACA var SER valor
impressao   → MOSTRE valor
operacao    → SOME valor COM valor | MULTIPLIQUE valor POR valor
repeticao   → REPITA valor VEZES: cmds FIM | REPITA ENQUANTO condicao: cmds FIM
controle    → SE condicao ENTAO cmds FIM DO SE | SE condicao ENTAO cmds SENAO cmds FIM DO SE

condicao    → valor FOR IGUAL A valor | valor FOR MAIOR QUE valor | valor FOR MENOR QUE valor |
              (condicao OU condicao) | (condicao E condicao) | (condicao)
valor       → var | num