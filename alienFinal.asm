jmp main
Win: string "VOCE VENCEU"
Dead: string "VOCE MORREU"
Msg: string "Jogar novamente? (s/n)"

Letra: var #1			; Contem a letra que foi digitada

posNave: var #1			; Contem a posicao atual da Nave
posAntNave: var #1		; Contem a posicao anterior da Nave

posAlien: var #1		; Contem a posicao atual do Alien
posAntAlien: var #1		; Contem a posicao anterior do Alien
dirAlien: var #1

posAlien2: var #1		; Contem a posicao atual do Alien
posAntAlien2: var #1	; Contem a posicao anterior do Alien
dirAlien2: var #1

posAlien3: var #1		; Contem a posicao atual do Alien
posAntAlien3: var #1	; Contem a posicao anterior do Alien
dirAlien3: var #1

posAlien4: var #1		; Contem a posicao atual do Alien
posAntAlien4: var #1	; Contem a posicao anterior do Alien
dirAlien4: var #1

posAlien5: var #1		; Contem a posicao atual do Alien
posAntAlien5: var #1	; Contem a posicao anterior do Alien
dirAlien5: var #1

;Codigo principal
main:
	call ApagaTela
	loadn r1, #tela1Linha0		; Endereco onde comeca a primeira linha do cenario!!
	loadn r2, #1536  			; cor branca!
	call ImprimeTela2   		;  rotina de Impresao de Cenario na Tela Inteira
    
	loadn r1, #tela2Linha0		; Endereco onde comeca a primeira linha do cenario!!
	loadn r2, #512  			; cor branca!
	call ImprimeTela2   		;  rotina de Impresao de Cenario na Tela Inteira
    
	loadn r1, #tela3Linha0		; Endereco onde comeca a primeira linha do cenario!!
	loadn r2, #2816   			; cor branca!
	call ImprimeTela2   		;  rotina de Impresao de Cenario na Tela Inteira

	loadn r1, #tela4Linha0		; Endereco onde comeca a primeira linha do cenario!!
	loadn r2, #256   			; cor branca!
	call ImprimeTela2   		;  rotina de Impresao de Cenario na Tela Inteira

	Loadn r0, #0			
	store posNave, r0		; Seta Posicao Atual da Nave (dentro do GO)
	store posAntNave, r0	; Seta Posicao Anterior da Nave
	
	Loadn r0, #48			; Alien de cima
	store posAlien, r0		; Seta Posicao Atual do Alien
	store posAntAlien, r0	; Seta Posicao Anterior do Alien
	loadn r0, #1
	store dirAlien, r0		; Alien começa indo pra baixo
	
	Loadn r0, #842			; Alien da esquerda
	store posAlien2, r0		; Seta Posicao Atual do Alien
	store posAntAlien2, r0	; Seta Posicao Anterior do Alien
	loadn r0, #2
	store dirAlien2, r0		; Alien começa indo pra direita
	
	Loadn r0, #1151			; Alien de baixo
	store posAlien3, r0		; Seta Posicao Atual do Alien
	store posAntAlien3, r0	; Seta Posicao Anterior do Alien
	loadn r0, #3
	store dirAlien3, r0		; Alien começa indo pra cima
	
	Loadn r0, #357			; Alien da direita
	store posAlien4, r0		; Seta Posicao Atual do Alien
	store posAntAlien4, r0	; Seta Posicao Anterior do Alien
	loadn r0, #0
	store dirAlien4, r0		; Alien começa indo pra esquerda
	
	Loadn r0, #746			; Alien do meio
	store posAlien5, r0		; Seta Posicao Atual do Alien
	store posAntAlien5, r0	; Seta Posicao Anterior do Alien
	loadn r0, #0
	store dirAlien5, r0		; Alien começa indo pra esquerda
	 
	Loadn r0, #0			; Contador para os Mods	= 0
	loadn r2, #0			; Para verificar se (mod(c/10)==0

	Loop:
	
		loadn r1, #10
		mod r1, r0, r1
		cmp r1, r2		; if (mod(c/10)==0
		ceq MoveNave	; Chama rotina de movimentacao da Nave
	
		loadn r1, #10
		mod r1, r0, r1
		cmp r1, r2		; if (mod(c/10)==0
		ceq MoveAlien	; Chama rotina de movimentacao do Alien 
		
		loadn r1, #10
		mod r1, r0, r1
		cmp r1, r2		; if (mod(c/10)==0
		ceq MoveAlien2	; Chama rotina de movimentacao do Alien 2
		
		loadn r1, #10
		mod r1, r0, r1
		cmp r1, r2		; if (mod(c/10)==0
		ceq MoveAlien3	; Chama rotina de movimentacao do Alien 3
		
		loadn r1, #10
		mod r1, r0, r1
		cmp r1, r2		; if (mod(c/10)==0
		ceq MoveAlien4	; Chama rotina de movimentacao do Alien 4
		
		loadn r1, #10
		mod r1, r0, r1
		cmp r1, r2		; if (mod(c/10)==0
		ceq MoveAlien5	; Chama rotina de movimentacao do Alien 5
		
		loadn r1, #10
		mod r1, r0, r1
		cmp r1, r2		; if (mod(c/10)==0
		call ChecaPos	; Chama rotina de verificacao de colisao
	
		call Delay
		inc r0 	;c++
		jmp Loop
	
;Funcoes
;--------------------------
;-----------NAVE-----------
;--------------------------

MoveNave:
		push r0
		push r1
		
		call MoveNave_recalculaPos		; recalcula Posicao da Nave

		; So Apaga e redesenha se (pos != posAnt)
		; if (posNave != posAntNave)	{	
		load r0, posNave
		load r1, posAntNave
		cmp r0, r1
		jeq MoveNave_Skip
			call MoveNave_Apaga
			call MoveNave_Desenha		;}
	  	MoveNave_Skip:
		
		pop r1
		pop r0
		rts
		
;------------------------
		
MoveNave_Apaga:		; Apaga a Nave preservando o Cenario!
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

	load r0, posAntNave	; r0 = posAnt
	
	; --> r2 = Tela1Linha0 + posAnt + posAnt/40  
	; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!

	loadn r1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add r2, r1, r0			; r2 = Tela1Linha0 + posAnt
	loadn r4, #40
	div r3, r0, r4			; r3 = posAnt/40
	add r2, r2, r3			; r2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi r5, r2			; r5 = Char (Tela(posAnt))
	
	outchar r5, r0			; Apaga o Obj na tela com o Char correspondente na memoria do cenario
	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
;--------------------------
		
MoveNave_recalculaPos:		; recalcula posicao da Nave em funcao das Teclas pressionadas
	push r0
	push r1
	push r2
	push r3

	load r0, posNave
	
	inchar r1				; Le Teclado para controlar a Nave
	loadn r2, #'a'
	cmp r1, r2
	jeq MoveNave_recalculaPos_A
	
	loadn r2, #'d'
	cmp r1, r2
	jeq MoveNave_recalculaPos_D
		
	loadn r2, #'w'
	cmp r1, r2
	jeq MoveNave_recalculaPos_W
		
	loadn r2, #'s'
	cmp r1, r2
	jeq MoveNave_recalculaPos_S
	
  	MoveNave_recalculaPos_Fim:	; Se nao for nenhuma tecla valida, vai embora
		store posNave, r0
		pop r3
		pop r2
		pop r1
		pop r0
		rts

  	MoveNave_recalculaPos_A:	; Move Nave para Esquerda
		loadn r1, #40
		loadn r2, #0
		mod r1, r0, r1	; Testa condicoes de Contorno 
		cmp r1, r2
		jeq MoveNave_recalculaPos_Fim
		dec r0			; pos = pos -1
		jmp MoveNave_recalculaPos_Fim
		
  	MoveNave_recalculaPos_D:	; Move Nave para Direita	
		loadn r1, #40
		loadn r2, #39
		mod r1, r0, r1	; Testa condicoes de Contorno 
		cmp r1, r2
		jeq MoveNave_recalculaPos_Fim
		inc r0			; pos = pos + 1
		jmp MoveNave_recalculaPos_Fim
	
  	MoveNave_recalculaPos_W:	; Move Nave para Cima
		loadn r1, #40
		cmp r0, r1		; Testa condicoes de Contorno 
		jle MoveNave_recalculaPos_Fim
		sub r0, r0, r1	; pos = pos - 40
		jmp MoveNave_recalculaPos_Fim

  	MoveNave_recalculaPos_S:	; Move Nave para Baixo
		loadn r1, #1159
		cmp r0, r1		; Testa condicoes de Contorno 
		jgr MoveNave_recalculaPos_Fim
		loadn r1, #40
		add r0, r0, r1	; pos = pos + 40
		jmp MoveNave_recalculaPos_Fim	

MoveNave_Desenha:	; Desenha caractere da Nave
	push r0
	push r1
	
	Loadn r1, #'$'	; Nave
	load r0, posNave
	outchar r1, r0
	store posAntNave, r0	; Atualiza Posicao Anterior da Nave = Posicao Atual
	
	pop r1
	pop r0
	rts

;-----------------------------------
;--------------ALIEN----------------
;----------------------------------

MoveAlien:
	push r0
	push r1
	
	call MoveAlien_recalculaPos
	
	; So Apaga e redesenha se (pos != posAnt)
	; if (pos != posAnt)	{	
	load r0, posAlien
	load r1, posAntAlien
	cmp r0, r1
	jeq MoveAlien_Skip
		call MoveAlien_Apaga
		call MoveAlien_Desenha		;}
  	MoveAlien_Skip:
	
	pop r1
	pop r0
	rts
			
; ----------------------------
			
MoveAlien_Apaga:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

	load r0, posAntAlien	; r0 == posAnt
	load r1, posAntNave 	; r1 = posAnt
	cmp r0, r1

	MoveAlien_Apaga_Skip:	
	  
		; --> r2 = Tela1Linha0 + posAnt + posAnt/40  
		; tem que somar posAnt/40 no ponteiro pois as linhas da string terminam com /0 !!
		loadn r1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add r2, r1, r0	; r2 = Tela1Linha0 + posAnt
		loadn r4, #40
		div r3, r0, r4	; r3 = posAnt/40
		add r2, r2, r3	; r2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi r5, r2	; r5 = Char (Tela(posAnt))
	  
	  	MoveAlien_Apaga_Fim:	
		outchar r5, r0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

	MoveAlien_recalculaPos:
		push r0
		push r1
		push r2
		push r3

		load r0, posAlien
		load r1, dirAlien

		MoveAlien_Esquerda:
		 	loadn r2, #0	;se dir = 0
			cmp r1, r2
			jne MoveAlien_Baixo
			loadn r1, #1
			sub r0, r0, r1
			loadn r1, #48
			cmp r0, r1
			jne MoveAlien_FimSwitch	; Break do Switch
			loadn r1, #1
			store dirAlien, r1
			jmp MoveAlien_FimSwitch
		
		MoveAlien_Baixo:
		 	loadn r2, #1	;se dir = 1
			cmp r1, r2
			jne MoveAlien_Direita
			loadn r1, #40
			add r0, r0, r1
			loadn r1, #248
			cmp r0, r1
			jne MoveAlien_FimSwitch	; Break do Switch
			loadn r1, #2
			store dirAlien, r1
			jmp MoveAlien_FimSwitch
		
		MoveAlien_Direita:
		 	loadn r2, #2	;se dir = 2
			cmp r1, r2
			jne MoveAlien_Cima
			loadn r1, #1
			add r0, r0, r1
			loadn r1, #275
			cmp r0, r1
			jne MoveAlien_FimSwitch	; Break do Switch
			loadn r1, #3
			store dirAlien, r1
			jmp MoveAlien_FimSwitch
		
	 	MoveAlien_Cima:
		 	loadn r2, #3	;se dir = 3
			cmp r1, r2
			jne MoveAlien_FimSwitch
			loadn r1, #40
			sub r0, r0, r1
			loadn r1, #75
			cmp r0, r1
			jne MoveAlien_FimSwitch	; Break do Switch
			loadn r1, #0
			store dirAlien, r1

	  	MoveAlien_FimSwitch:	
			store posAlien, r0	; Grava a posicao alterada na memoria
			pop r3
			pop r2
			pop r1
			pop r0
			rts
			
	;----------------------------------

	MoveAlien_Desenha:
		push r0
		push r1
		
		Loadn r1, #'*'	; Alien
		load r0, posAlien
		outchar r1, r0
		store posAntAlien, r0
		
		pop r1
		pop r0
		rts

;----------------------------------
;------------ALIEN 2---------------
;----------------------------------

MoveAlien2:
	push r0
	push r1
	
	call MoveAlien2_recalculaPos
	
; So' Apaga e redesenha se (pos != posAnt)
;	If (pos != posAnt)	{	
	load r0, posAlien2
	load r1, posAntAlien2
	cmp r0, r1
	jeq MoveAlien2_Skip
		call MoveAlien2_Apaga
		call MoveAlien2_Desenha		;}
	MoveAlien2_Skip:
	
		pop r1
		pop r0
		rts
			
	; ----------------------------
			
	MoveAlien2_Apaga:
		push r0
		push r1
		push r2
		push r3
		push r4
		push r5

		load r0, posAntAlien2	; r0 == posAnt
		load r1, posAntNave		; r1 = posAnt
		cmp r0, r1

	MoveAlien2_Apaga_Skip:	
	  
		; --> r2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
		loadn r1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add r2, r1, r0	; r2 = Tela1Linha0 + posAnt
		loadn r4, #40
		div r3, r0, r4	; r3 = posAnt/40
		add r2, r2, r3	; r2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi r5, r2	; r5 = Char (Tela(posAnt))
	  
	MoveAlien2_Apaga_Fim:	
		outchar r5, r0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

	MoveAlien2_recalculaPos:
		push r0
		push r1
		push r2
		push r3

		load r0, posAlien2
		load r1, dirAlien2

	 	MoveAlien2_Esquerda:
		 	loadn r2, #0	;se dir = 0
			cmp r1, r2
			jne MoveAlien2_Baixo
			loadn r1, #1
			sub r0, r0, r1
			loadn r1, #322
			cmp r0, r1
			jne MoveAlien2_FimSwitch	; Break do Switch
			loadn r1, #1
			store dirAlien2, r1
			jmp MoveAlien2_FimSwitch
		
	 	MoveAlien2_Baixo:
		 	loadn r2, #1	;se dir = 1
			cmp r1, r2
			jne MoveAlien2_Direita
			loadn r1, #40
			add r0, r0, r1
			loadn r1, #842
			cmp r0, r1
			jne MoveAlien2_FimSwitch	; Break do Switch
			loadn r1, #2
			store dirAlien2, r1
			jmp MoveAlien2_FimSwitch
		
	 	MoveAlien2_Direita:
		 	loadn r2, #2	;se dir = 2
			cmp r1, r2
			jne MoveAlien2_Cima
			loadn r1, #1
			add r0, r0, r1
			loadn r1, #849
			cmp r0, r1
			jne MoveAlien2_FimSwitch	; Break do Switch
			loadn r1, #3
			store dirAlien2, r1
			jmp MoveAlien2_FimSwitch
		
		MoveAlien2_Cima:
		 	loadn r2, #3	;se dir = 3
			cmp r1, r2
			jne MoveAlien2_FimSwitch
			loadn r1, #40
			sub r0, r0, r1
			loadn r1, #329
			cmp r0, r1
			jne MoveAlien2_FimSwitch	; Break do Switch
			loadn r1, #0
			store dirAlien2, r1

	  	MoveAlien2_FimSwitch:	
			store posAlien2, r0	; Grava a posicao alterada na memoria
			pop r3
			pop r2
			pop r1
			pop r0
			rts

	;----------------------------------
	
	MoveAlien2_Desenha:
		push r0
		push r1
		
		Loadn r1, #'*'	; Alien
		load r0, posAlien2
		outchar r1, r0
		store posAntAlien2, r0
		
		pop r1
		pop r0
		rts

;----------------------------------
;--------------ALIEN 3-------------
;----------------------------------

MoveAlien3:
	push r0
	push r1
	
	call MoveAlien3_recalculaPos
	
	; So Apaga e redesenha se (pos != posAnt)	
	; if (pos != posAnt)	{	
	load r0, posAlien3
	load r1, posAntAlien3
	cmp r0, r1
	jeq MoveAlien3_Skip
		call MoveAlien3_Apaga
		call MoveAlien3_Desenha		;}
  	MoveAlien3_Skip:
	
	pop r1
	pop r0
	rts
		
; ----------------------------
		
MoveAlien3_Apaga:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

	load r0, posAntAlien3	; r0 == posAnt
	load r1, posAntNave		; r1 = posAnt
	cmp r0, r1

  	MoveAlien3_Apaga_Skip:	
  
		; --> r2 = Tela1Linha0 + posAnt + posAnt/40  ; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
		loadn r1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add r2, r1, r0	; r2 = Tela1Linha0 + posAnt
		loadn r4, #40
		div r3, r0, r4	; r3 = posAnt/40
		add r2, r2, r3	; r2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi r5, r2	; r5 = Char (Tela(posAnt))
  
  	MoveAlien3_Apaga_Fim:	
		outchar r5, r0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

MoveAlien3_recalculaPos:
	push r0
	push r1
	push r2
	push r3

	load r0, posAlien3
	load r1, dirAlien3

 	MoveAlien3_Esquerda:
	 	loadn r2, #0	;se dir = 0
		cmp r1, r2
		jne MoveAlien3_Baixo
		loadn r1, #1
		sub r0, r0, r1
		loadn r1, #924
		cmp r0, r1
		jne MoveAlien3_FimSwitch	; Break do Switch
		loadn r1, #1
		store dirAlien3, r1
		jmp MoveAlien3_FimSwitch
	
 	MoveAlien3_Baixo:
	 	loadn r2, #1	;se dir = 1
		cmp r1, r2
		jne MoveAlien3_Direita
		loadn r1, #40
		add r0, r0, r1
		loadn r1, #1124
		cmp r0, r1
		jne MoveAlien3_FimSwitch	; Break do Switch
		loadn r1, #2
		store dirAlien3, r1
		jmp MoveAlien3_FimSwitch
	
 	MoveAlien3_Direita:
	 	loadn r2, #2	;se dir = 2
		cmp r1, r2
		jne MoveAlien3_Cima
		loadn r1, #1
		add r0, r0, r1
		loadn r1, #1151
		cmp r0, r1
		jne MoveAlien3_FimSwitch	; Break do Switch
		loadn r1, #3
		store dirAlien3, r1
		jmp MoveAlien3_FimSwitch
	
 	MoveAlien3_Cima:
	 	loadn r2, #3	;se dir = 3
		cmp r1, r2
		jne MoveAlien3_FimSwitch
		loadn r1, #40
		sub r0, r0, r1
		loadn r1, #951
		cmp r0, r1
		jne MoveAlien3_FimSwitch	; Break do Switch
		loadn r1, #0
		store dirAlien3, r1

  	MoveAlien3_FimSwitch:	
		store posAlien3, r0	; Grava a posicao alterada na memoria
		pop r3
		pop r2
		pop r1
		pop r0
		rts

;----------------------------------

MoveAlien3_Desenha:
	push r0
	push r1
	
	Loadn r1, #'*'	; Alien
	load r0, posAlien3
	outchar r1, r0
	store posAntAlien3, r0
	
	pop r1
	pop r0
	rts

;----------------------------------
;-------------ALIEN 4--------------
;----------------------------------

MoveAlien4:
	push r0
	push r1
	
	call MoveAlien4_recalculaPos
	
	; So Apaga e redesenha se (pos != posAnt)
	; if (pos != posAnt)	{	
	load r0, posAlien4
	load r1, posAntAlien4
	cmp r0, r1
	jeq MoveAlien4_Skip
		call MoveAlien4_Apaga
		call MoveAlien4_Desenha		;}
  	MoveAlien4_Skip:
	
		pop r1
		pop r0
		rts
			
; ----------------------------
		
MoveAlien4_Apaga:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

	load r0, posAntAlien4	; r0 == posAnt
	load r1, posAntNave		; r1 = posAnt
	cmp r0, r1
	jne MoveAlien4_Apaga_Skip
		loadn r5, #'X'		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		jmp MoveAlien4_Apaga_Fim

  	MoveAlien4_Apaga_Skip:	
  
		; --> r2 = Tela1Linha0 + posAnt + posAnt/40  
		; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
		loadn r1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add r2, r1, r0	; r2 = Tela1Linha0 + posAnt
		loadn r4, #40
		div r3, r0, r4	; r3 = posAnt/40
		add r2, r2, r3	; r2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi r5, r2	; r5 = Char (Tela(posAnt))
  
  	MoveAlien4_Apaga_Fim:	
		outchar r5, r0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

MoveAlien4_recalculaPos:
	push r0
	push r1
	push r2
	push r3

	load r0, posAlien4
	load r1, dirAlien4

 	MoveAlien4_Esquerda:
	 	loadn r2, #0	;se dir = 0
		cmp r1, r2
		jne MoveAlien4_Baixo
		loadn r1, #1
		sub r0, r0, r1
		loadn r1, #350
		cmp r0, r1
		jne MoveAlien4_FimSwitch	; Break do Switch
		loadn r1, #1
		store dirAlien4, r1
		jmp MoveAlien4_FimSwitch
	
 	MoveAlien4_Baixo:
	 	loadn r2, #1	;se dir = 1
		cmp r1, r2
		jne MoveAlien4_Direita
		loadn r1, #40
		add r0, r0, r1
		loadn r1, #870
		cmp r0, r1
		jne MoveAlien4_FimSwitch	; Break do Switch
		loadn r1, #2
		store dirAlien4, r1
		jmp MoveAlien4_FimSwitch
	
 	MoveAlien4_Direita:
	 	loadn r2, #2	;se dir = 2
		cmp r1, r2
		jne MoveAlien4_Cima
		loadn r1, #1
		add r0, r0, r1
		loadn r1, #877
		cmp r0, r1
		jne MoveAlien4_FimSwitch	; Break do Switch
		loadn r1, #3
		store dirAlien4, r1
		jmp MoveAlien4_FimSwitch
	
 	MoveAlien4_Cima:
	 	loadn r2, #3	;se dir = 3
		cmp r1, r2
		jne MoveAlien4_FimSwitch
		loadn r1, #40
		sub r0, r0, r1
		loadn r1, #357
		cmp r0, r1
		jne MoveAlien4_FimSwitch	; Break do Switch
		loadn r1, #0
		store dirAlien4, r1

  	MoveAlien4_FimSwitch:	
		store posAlien4, r0	; Grava a posicao alterada na memoria
		pop r3
		pop r2
		pop r1
		pop r0
		rts

;----------------------------------

MoveAlien4_Desenha:
	push r0
	push r1
	
	Loadn r1, #'*'	; Alien
	load r0, posAlien4
	outchar r1, r0
	store posAntAlien4, r0
	
	pop r1
	pop r0
	rts

;----------------------------------
;-------------ALIEN 5--------------
;----------------------------------

MoveAlien5:
	push r0
	push r1
	
	call MoveAlien5_recalculaPos
	
	; So Apaga e redezenha se (pos != posAnt)
	; if (pos != posAnt)	{	
	load r0, posAlien5
	load r1, posAntAlien5
	cmp r0, r1
	jeq MoveAlien5_Skip
		call MoveAlien5_Apaga
		call MoveAlien5_Desenha		;}
  	MoveAlien5_Skip:
	
		pop r1
		pop r0
		rts
			
; ----------------------------
		
MoveAlien5_Apaga:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5

	load r0, posAntAlien5	; r0 == posAnt
	load r1, posAntNave		; r1 = posAnt
	cmp r0, r1
	jne MoveAlien5_Apaga_Skip
		loadn r5, #'X'		; Se o Tiro passa sobre a Nave, apaga com um X, senao apaga com o cenario 
		jmp MoveAlien5_Apaga_Fim

  	MoveAlien5_Apaga_Skip:	
  
		; --> r2 = Tela1Linha0 + posAnt + posAnt/40  
		; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!
		loadn r1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
		add r2, r1, r0	; r2 = Tela1Linha0 + posAnt
		loadn r4, #40
		div r3, r0, r4	; r3 = posAnt/40
		add r2, r2, r3	; r2 = Tela1Linha0 + posAnt + posAnt/40
		
		loadi r5, r2	; r5 = Char (Tela(posAnt))
  
  	MoveAlien5_Apaga_Fim:	
		outchar r5, r0	; Apaga o Obj na tela com o Char correspondente na memoria do cenario
		
		pop r5
		pop r4
		pop r3
		pop r2
		pop r1
		pop r0
		rts

MoveAlien5_recalculaPos:
	push r0
	push r1
	push r2
	push r3

	load r0, posAlien5
	load r1, dirAlien5

 	MoveAlien5_Esquerda:
	 	loadn r2, #0	;se dir = 0
		cmp r1, r2
		jne MoveAlien5_Baixo
		loadn r1, #1
		sub r0, r0, r1
		loadn r1, #733
		cmp r0, r1
		jne MoveAlien5_FimSwitch	; Break do Switch
		loadn r1, #3
		store dirAlien5, r1
		jmp MoveAlien5_FimSwitch
	
	 MoveAlien5_Baixo:
	 	loadn r2, #1	;se dir = 1
		cmp r1, r2
		jne MoveAlien5_Direita
		loadn r1, #40
		add r0, r0, r1
		loadn r1, #746
		cmp r0, r1
		jne MoveAlien5_FimSwitch	; Break do Switch
		loadn r1, #0
		store dirAlien5, r1
		jmp MoveAlien5_FimSwitch
	
	 MoveAlien5_Direita:
	 	loadn r2, #2	;se dir = 2
		cmp r1, r2
		jne MoveAlien5_Cima
		loadn r1, #1
		add r0, r0, r1
		loadn r1, #466
		cmp r0, r1
		jne MoveAlien5_FimSwitch	; Break do Switch
		loadn r1, #1
		store dirAlien5, r1
		jmp MoveAlien5_FimSwitch
		
	 MoveAlien5_Cima:
	 	loadn r2, #3	;se dir = 3
		cmp r1, r2
		jne MoveAlien5_FimSwitch
		loadn r1, #40
		sub r0, r0, r1
		loadn r1, #453
		cmp r0, r1
		jne MoveAlien5_FimSwitch	; Break do Switch
		loadn r1, #2
		store dirAlien5, r1

	  MoveAlien5_FimSwitch:	
		store posAlien5, r0	; Grava a posicao alterada na memoria
		pop r3
		pop r2
		pop r1
		pop r0
		rts

;----------------------------------

MoveAlien5_Desenha:
	push r0
	push r1
	
	Loadn r1, #'*'	; Alien
	load r0, posAlien5
	outchar r1, r0
	store posAntAlien5, r0
	
	pop r1
	pop r0
	rts

;----------------------------------
;------------CHECA POS-------------
;----------------------------------

ChecaPos:
	push r0
	push r1
	push r2
	push r3
	push r4
	push r5
	
	load r0, posNave	; Testa se o Alien colidiu com a nave
	load r1, posAlien
	cmp r0, r1			; if posNave == posAlien  BOOM!!
	jeq ColisaoNave
	
	load r1, posAlien2
	cmp r0, r1			; if posNave == posAlien   BOOM!!
	jeq ColisaoNave
	
	load r1, posAlien3
	cmp r0, r1			; if posNave == posAlien   BOOM!!
	jeq ColisaoNave
	
	load r1, posAlien4
	cmp r0, r1			; if posNave == posAlien   BOOM!!
	jeq ColisaoNave
	
	load r1, posAlien5
	cmp r0, r1			; if posNave == posAlien   BOOM!!
	jeq ColisaoNave
	
	call ChecaParede
	
	loadn r1, #1199
	cmp r0, r1
	jeq Vitoria 
	jmp FimChecagem
	
ChecaParede:
	; --> r2 = Tela1Linha0 + posAnt + posAnt/40  
	; tem que somar posAnt/40 no ponteiro pois as linas da string terminam com /0 !!

	loadn r1, #tela4Linha0	; Endereco onde comeca a primeira linha do cenario!!
	add r2, r1, r0			; r2 = Tela1Linha0 + posAnt
	loadn r4, #40
	div r3, r0, r4			; r3 = posAnt/40
	add r2, r2, r3			; r2 = Tela1Linha0 + posAnt + posAnt/40
	
	loadi r5, r2			; r5 = Char (Tela(posAnt))
	loadn r4, #'*'
	cmp r5, r4 			; if(r5 == '*') BOOM
	jeq ColisaoNave
	rts

Vitoria:
	; Limpa a Tela !!
  	loadn r1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn r2, #0  			; cor branca!
	call ImprimeTela   		; rotina de Impresao de Cenario na Tela Inteira
  
	;imprime Voce Venceu !!!
	loadn r0, #528
	loadn r1, #Win
	loadn r2, #0
	call ImprimeStr
	
	;imprime quer jogar novamente
	loadn r0, #605
	loadn r1, #Msg
	loadn r2, #0
	call ImprimeStr
	
	call DigLetra
	loadn r0, #'s'
	load r1, Letra
	cmp r0, r1				; tecla == 's' ?
	jne FimJogo	; tecla nao e' 's'
	
	; Se quiser jogar novamente...
	call ApagaTela
	jmp main

ColisaoNave:	
	; Limpa a Tela !!
  	loadn r1, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	loadn r2, #0  			; cor branca!
	call ImprimeTela   		; rotina de Impresao de Cenario na Tela Inteira
  
	;imprime Voce Perdeu !!!
	loadn r0, #528
	loadn r1, #Dead
	loadn r2, #0
	call ImprimeStr
	
	;imprime quer jogar novamente
	loadn r0, #605
	loadn r1, #Msg
	loadn r2, #0
	call ImprimeStr
	
	call DigLetra
	loadn r0, #'s'
	load r1, Letra
	cmp r0, r1				; tecla == 's' ?
	jne FimJogo	; tecla nao e' 's'
	
	; Se quiser jogar novamente...
	call ApagaTela
	jmp main
	
FimChecagem:
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0

	rts

FimJogo:
	call ApagaTela
	halt

;-----------------------------------
;---------------DELAY---------------
;-----------------------------------

Delay:
	;Utiliza Push e Pop para nao afetar os registradores do programa principal
	push r0
	push r1
	
	loadn r1, #5  				; a
   	Delay_volta2:				;Quebrou o contador acima em duas partes (dois loops de decremento)
	loadn r0, #3000				; b
   	Delay_volta: 
	dec r0						; (4*a + 6)b = 1000000  == 1 seg  em um clock de 1MHz
	jnz Delay_volta	
	dec r1
	jnz Delay_volta2
	
	pop r1
	pop r0
	
	rts		;return

;-----------------------------------
;-----------IMPRIME TELA------------
;-----------------------------------	

ImprimeTela: 	
	;  rotina de Impresao de Cenario na Tela Inteira
	;  r1 = endereco onde comeca a primeira linha do Cenario
	;  r2 = cor do Cenario para ser impresso

	push r0	; protege o r3 na pilha para ser usado na subrotina
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r4 na pilha para ser usado na subrotina

	loadn r0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn r3, #40  	; Incremento da posicao da tela!
	loadn r4, #41  	; incremento do ponteiro das linhas da tela
	loadn r5, #1200 ; Limite da tela!
	
   ImprimeTela_Loop:
		call ImprimeStr
		add r0, r0, r3  	; incrementaposicao para a segunda linha na tela -->  r0 = r0 + 40
		add r1, r1, r4  	; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5			; Compara r0 com 1200
		jne ImprimeTela_Loop	; Enquanto r0 < 1200

	; resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r5	
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
				
;---------------------------	
;------IMPRIME STRING-------
;---------------------------
	
ImprimeStr:	
	;  rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera impresso
	;  r1 = endereco onde comeca a mensagem
	; r2 = cor da mensagem.   Obs: a mensagem sera impressa ate encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	
	loadn r3, #'\0'	; Criterio de parada

   ImprimeStr_Loop:	
		loadi r4, r1
		cmp r4, r3		; If (Char == \0)  vai Embora
		jeq ImprimeStr_Sai
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		jmp ImprimeStr_Loop
	
   ImprimeStr_Sai:	
	pop r4	; resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	
;-------------------------------------	
;-----------IMPRIME TELA 2------------	
;-------------------------------------	

ImprimeTela2: 	
	;  rotina de Impresao de Cenario na Tela Inteira
	;  r1 = endereco onde comeca a primeira linha do Cenario
	;  r2 = cor do Cenario para ser impresso

	push r0	; protege o r3 na pilha para ser usado na subrotina
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina

	loadn r0, #0  	; posicao inicial tem que ser o comeco da tela!
	loadn r3, #40  	; Incremento da posicao da tela!
	loadn r4, #41  	; incremento do ponteiro das linhas da tela
	loadn r5, #1200 ; Limite da tela!
	loadn r6, #tela0Linha0	; Endereco onde comeca a primeira linha do cenario!!
	
   ImprimeTela2_Loop:
		call ImprimeStr2
		add r0, r0, r3  		; incrementaposicao para a segunda linha na tela -->  r0 = r0 + 40
		add r1, r1, r4  		; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		add r6, r6, r4  		; incrementa o ponteiro para o comeco da proxima linha na memoria (40 + 1 porcausa do /0 !!) --> r1 = r1 + 41
		cmp r0, r5				; Compara r0 com 1200
		jne ImprimeTela2_Loop	; Enquanto r0 < 1200

	; resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r6	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
				
;---------------------------	
;-----IMPRIME STRING 2------
;---------------------------
	
ImprimeStr2:	
	;  rotina de Impresao de Mensagens:    r0 = Posicao da tela que o primeiro caractere da mensagem sera impresso
	;  r1 = endereco onde comeca a mensagem
	; r2 = cor da mensagem.   Obs: a mensagem sera impressa ate encontrar "/0"
	push r0	; protege o r0 na pilha para preservar seu valor
	push r1	; protege o r1 na pilha para preservar seu valor
	push r2	; protege o r1 na pilha para preservar seu valor
	push r3	; protege o r3 na pilha para ser usado na subrotina
	push r4	; protege o r4 na pilha para ser usado na subrotina
	push r5	; protege o r5 na pilha para ser usado na subrotina
	push r6	; protege o r6 na pilha para ser usado na subrotina
	
	
	loadn r3, #'\0'	; Criterio de parada
	loadn r5, #' '	; Espaco em Branco

   ImprimeStr2_Loop:	
		loadi r4, r1
		cmp r4, r3		; If (Char == \0)  vai Embora
		jeq ImprimeStr2_Sai
		cmp r4, r5		; If (Char == ' ')  vai Pula outchar do espaco para na apagar outros caracteres
		jeq ImprimeStr2_Skip
		add r4, r2, r4	; Soma a Cor
		outchar r4, r0	; Imprime o caractere na tela
		storei r6, r4
   ImprimeStr2_Skip:
		inc r0			; Incrementa a posicao na tela
		inc r1			; Incrementa o ponteiro da String
		inc r6			; Incrementa o ponteiro da String da Tela 0
		jmp ImprimeStr2_Loop
	
   ImprimeStr2_Sai:	
   ; resgata os valores dos registradores utilizados na Subrotina da Pilha
	pop r6	
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	pop r0
	rts
	

;-------------------------------------	
;------------DIGITE LETRA-------------	
;-------------------------------------

DigLetra:	
; Espera que uma tecla seja digitada e salva na variavel global "Letra"
	push r0
	push r1
	loadn r1, #255	; Se nao digitar nada vem 255

   DigLetra_Loop:
		inchar r0			; Le o teclado, se nada for digitado = 255
		cmp r0, r1			;compara r0 com 255
		jeq DigLetra_Loop	; Fica lendo ate' que digite uma tecla valida

	store Letra, r0			; Salva a tecla na variavel global "Letra"

	pop r1
	pop r0
	rts

;-------------------------------------	
;-------------APAGA TELA--------------
;-------------------------------------

ApagaTela:
	push r0
	push r1
	
	loadn r0, #1200		; apaga as 1200 posicoes da Tela
	loadn r1, #' '		; com "espaco"
	
	   	ApagaTela_Loop:	;;label for(r0=1200;r3>0;r3--)
			dec r0
			outchar r1, r0
			jnz ApagaTela_Loop
 
	pop r1
	pop r0
	rts	
	
;------------------------	

; Declara uma tela vazia para ser preenchida em tempo de execucao:
tela0Linha0  : string "                                        "
tela0Linha1  : string "                                        "
tela0Linha2  : string "                                        "
tela0Linha3  : string "                                        "
tela0Linha4  : string "                                        "
tela0Linha5  : string "                                        "
tela0Linha6  : string "                                        "
tela0Linha7  : string "                                        "
tela0Linha8  : string "                                        "
tela0Linha9  : string "                                        "
tela0Linha10 : string "                                        "
tela0Linha11 : string "                                        "
tela0Linha12 : string "                                        "
tela0Linha13 : string "                                        "
tela0Linha14 : string "                                        "
tela0Linha15 : string "                                        "
tela0Linha16 : string "                                        "
tela0Linha17 : string "                                        "
tela0Linha18 : string "                                        "
tela0Linha19 : string "                                        "
tela0Linha20 : string "                                        "
tela0Linha21 : string "                                        "
tela0Linha22 : string "                                        "
tela0Linha23 : string "                                        "
tela0Linha24 : string "                                        "
tela0Linha25 : string "                                        "
tela0Linha26 : string "                                        "
tela0Linha27 : string "                                        "
tela0Linha28 : string "                                        "
tela0Linha29 : string "                                        "	

; Declara e preenche tela linha por linha (40 caracteres):
tela1Linha0  : string "GO                                      "
tela1Linha1  : string "                                        "
tela1Linha2  : string "                                        "
tela1Linha3  : string "                                        "
tela1Linha4  : string "                                        "
tela1Linha5  : string "                                        "
tela1Linha6  : string "                                        "
tela1Linha7  : string "                                        "
tela1Linha8  : string "                                        "
tela1Linha9  : string "                                        "
tela1Linha10 : string "                                        "
tela1Linha11 : string "                                        "
tela1Linha12 : string "                                        "
tela1Linha13 : string "                                        "
tela1Linha14 : string "                                        "
tela1Linha15 : string "                                        "
tela1Linha16 : string "                                        "
tela1Linha17 : string "                                        "
tela1Linha18 : string "                                        "
tela1Linha19 : string "                                        "
tela1Linha20 : string "                                        "
tela1Linha21 : string "                                        "
tela1Linha22 : string "                                        "
tela1Linha23 : string "                                        "
tela1Linha24 : string "                                        "
tela1Linha25 : string "                                        "
tela1Linha26 : string "                                        "
tela1Linha27 : string "                                        "
tela1Linha28 : string "                                        "
tela1Linha29 : string "                                        "

; Declara e preenche tela linha por linha (40 caracteres):
tela2Linha0  : string "                                        "
tela2Linha1  : string "                                        "
tela2Linha2  : string "                                        "
tela2Linha3  : string "                                        "
tela2Linha4  : string "                                        "
tela2Linha5  : string "                                        "
tela2Linha6  : string "                                        "
tela2Linha7  : string "                                        "
tela2Linha8  : string "                                        "
tela2Linha9  : string "                                        "
tela2Linha10 : string "                                        "
tela2Linha11 : string "                                        "
tela2Linha12 : string "                                        "
tela2Linha13 : string "                                        "
tela2Linha14 : string "                                        "
tela2Linha15 : string "                                        "
tela2Linha16 : string "                                        "
tela2Linha17 : string "                                        "
tela2Linha18 : string "                                        "
tela2Linha19 : string "                                        "
tela2Linha20 : string "                                        "
tela2Linha21 : string "                                        "
tela2Linha22 : string "                                        "
tela2Linha23 : string "                                        "
tela2Linha24 : string "                                        "
tela2Linha25 : string "                                        "
tela2Linha26 : string "                                        "
tela2Linha27 : string "                                        "
tela2Linha28 : string "                                        "
tela2Linha29 : string "                                     END"

; Declara e preenche tela linha por linha (40 caracteres):
tela3Linha0  : string "   |                                    "
tela3Linha1  : string "   |                                    "
tela3Linha2  : string "___|                                    "
tela3Linha3  : string "                                        "
tela3Linha4  : string "                                        "
tela3Linha5  : string "                                        "
tela3Linha6  : string "                                        "
tela3Linha7  : string "                                        "
tela3Linha8  : string "                                        "
tela3Linha9  : string "                                        "
tela3Linha10 : string "                                        "
tela3Linha11 : string "                                        "
tela3Linha12 : string "                                        "
tela3Linha13 : string "                                        "
tela3Linha14 : string "                                        "
tela3Linha15 : string "                                        "
tela3Linha16 : string "                                        "
tela3Linha17 : string "                                        "
tela3Linha18 : string "                                        "
tela3Linha19 : string "                                        "
tela3Linha20 : string "                                        "
tela3Linha21 : string "                                        "
tela3Linha22 : string "                                        "
tela3Linha23 : string "                                        "
tela3Linha24 : string "                                        "
tela3Linha25 : string "                                        "
tela3Linha26 : string "                                     ___"
tela3Linha27 : string "                                    |   "
tela3Linha28 : string "                                    |   "
tela3Linha29 : string "                                    |   "

; Declara e preenche tela linha por linha (40 caracteres):
tela4Linha0  : string "      **********************************"
tela4Linha1  : string "      *                                *"
tela4Linha2  : string "      *           ****                 *"
tela4Linha3  : string "      *           ****                 *"
tela4Linha4  : string "                  ****                 *"
tela4Linha5  : string "****              ****                 *"
tela4Linha6  : string "*                                      *"
tela4Linha7  : string "*          ******************          *"
tela4Linha8  : string "*          ******************          *"
tela4Linha9  : string "*          ******************          *"
tela4Linha10 : string "*   ****                        ****   *"
tela4Linha11 : string "*   ****                        ****   *"
tela4Linha12 : string "*   ****       **********       ****   *"
tela4Linha13 : string "*   ****       **********       ****   *"
tela4Linha14 : string "*   ****       **********       ****   *"
tela4Linha15 : string "*   ****       **********       ****   *"
tela4Linha16 : string "*   ****       **********       ****   *"
tela4Linha17 : string "*   ****       **********       ****   *"
tela4Linha18 : string "*   ****                        ****   *"
tela4Linha19 : string "*   ****           **           ****   *"
tela4Linha20 : string "*          ******************          *"
tela4Linha21 : string "*          ******************          *"
tela4Linha22 : string "*          ******************          *"
tela4Linha23 : string "*                                      *"
tela4Linha24 : string "*                 ****              ****"
tela4Linha25 : string "*                 ****                  "
tela4Linha26 : string "*                 ****           *      "
tela4Linha27 : string "*                 ****           *      "
tela4Linha28 : string "*                                *      "
tela4Linha29 : string "**********************************      "