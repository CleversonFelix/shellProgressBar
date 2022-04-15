#!/bin/bash

loading ()
{
	#Cria array com numero passado
	declare -a all_progress
	controle=$((100 * $1 + 1))
	for ((i=0;i<$1;i++))
	do
		clear
		all_progress[i]=0
		printf '\n'
	done

#	for x in "${all_progress[@]}"

#do
		while true
		do
			
			rand=$((RANDOM % $1))
		if [[ ${all_progress[rand]} -le 100  ]]
		then
			((all_progress[rand]++))
		fi
			sleep 0.01	
		printf "\u001b[1000D"
		printf "\u001b[$1A"	
		for progress in "${all_progress[@]}"
			do
				 width=$(((progress+1)/4))
				 printf "[%${width}s"| sed "s/ /#/g"
				 printf "%$((25 - width))s]\n"
				 tput el
			done
			soma=$(($(sed "s/ /+/g" <<< "${all_progress[@]}")))
			[[ $controle -eq $soma ]] && {
			       	break
			}
		done

#	done
}

loading $1
