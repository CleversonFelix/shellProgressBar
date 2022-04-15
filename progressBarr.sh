#!/bin/bash

loading () 
{
	# Cria array com numero passado
	local isComplete=0
	declare -a all_progress
	
	clear
	tput sc
	tput civis
	#Criando Linhas e criando array de zeros	
	for ((i=0;i<$1;i++))	
	do
		all_progress[i]=0
		printf '\n'
	done

	for item in ${all_progress[@]}
	do
		#Verificaçao feita no laço mais interno...
		((  $isComplete )) && {
		 break
		}
		while true
		do
			#Percorre o array randomicamente e incrementando, simulando algum tipo de progresso.
			local rand=$((RANDOM % $1))
			if [[ ${all_progress[rand]} -lt 100 ]]
			then
				((all_progress[rand]++))
			fi

			
			tput rc
			#Percorrendo os "Progressos" no array e criando barras de progresso
			for progress in "${all_progress[@]}"
			do
				#A operacao aritmetica retornara apenas o inteiro da divisao possibilitando representar por #
				width=$(((progress+1)/4))
				#Usei codificacao de escape ANSI para colorir o printf...
				printf "\u001b[$((($1%7)+30))m[%${width}s" | sed "s/ /#/g" #substituindo os espacos criados por "#"
				printf "%$((25 - width))s] -> $progress%% \u001b[0m\n" #Preenchendo com espaços o restante para o total de 25
				tput el
			done
				#Testando se todos os itens do array são 100,se for interrompe o laço
				local complete=$(grep -o "100" <<< "${all_progress[@]}" | wc -l)
				if [[ $complete -eq $1 ]]
				then
					isComplete=1
					break
				fi
		done
	done
	tput cnorm
}

loading $1
