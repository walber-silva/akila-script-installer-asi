#!/bin/bash
#-*- coding: utf-8 -*-

NOME="Akila Script Inslaller (ASI)"
VERSION="Versao 1.0"

# Verificando root
root(){
	if [ "`whoami`" != "root" ]; then
		dialog	\
		--backtitle "$NOME - $VERSION"	\
		--title "Aviso"	\
		--msgbox "	\nDesculpe!..E preciso executar como root \nex:(sudo ./asi.sh)"	\
		9 45
		exit
	fi
}
root

# Logo
logo(){
	dialog \
	--backtitle "$NOME - $VERSION"	\
	--title "Akila Script Installer"	\
	--infobox "\n
	                          ./+o+- \n
                  yyyyy- -yyyyyy+   \n
               ://+//////-yyyyyyo     \n
           .++ .:/++++++/-.+sss/\`     \n
         .:++o:  /++++++++/:--:/-     \n
        o:+o+:++.\`..\`\`\`.-/oo+++++/   \n
       .:+o:+o/.          \`+sssoo+/   \n
  .++/+:+oo+o:\`             /sssooo.  \n
 /+++//+:\`oo+o               /::--:.  \n
 \+/+o+++\`o++o               ++////.  \n
  .++.o+++oo+:\`             /dddhhh.  \n
       .+.o+oo:.          \`oddhhhh+   \n
        \+.++o+o\`\`-\`\`\`\`.:ohdhhhhh+ \n
         \`:o+++ \`ohhhhhhhhyo++os:  \n
           .o:\`.syhhhhhhh/.oo++o\`  \n
               /osyyyyyyo++ooo+++/   \n
                   \`\`\`\`\` +oo+++o\:\n
                          \`oo++." \
    0 0 && sleep 3
}
logo

# Test da conexao
test_internet(){
dialog --backtitle "$NOME - $VERSION" --title " Informacao!" --infobox " \nVerificando conexao..." 0 0 && sleep 2
while [[ ! $(ping -c1 8.8.8.8) ]]; do
dialog	\
--title "Aviso!"	\
--msgbox "  Nao foi possivel conectar-se a internet..
  Por favor Verifique sua conexão!

  AVISO! Caso deseje continuar, algumas coisas
  poderão não funcionar corretamente!"	\
9 55
clear
break
done
clear
}
test_internet

# Menu
menu(){

opcao=$(
      dialog --backtitle "$NOME - $VERSION" \
	     --stdout               \
             --title "Menu"  \
             --menu "Selecione uma opcao:" \
            0 0 0                   \
      1  "Instalacao Codec-Multimidia" \
	    2  "Instalacao Programas para Desenvolvimento" \
	    3  "Verificar Atualizacao do Sistema" \
	    4  "Limpar Cache e arquivos temporarios" \
	    5  "Interface Grafica" \
	    6  "Desinstalar" \
	    7  "Desinstalar com dependencias" \
	    8  "Programas Extras" \
	    9  "Acessorios" \
      10 "Personalização" \
	    11 "Sobre" \
	    0 "Sair"        )

	opcao=$opcao

	[ $? -ne 0 ] && return

	if [ "$opcao" == "1" ]; then
	root
	clear
	cd src/
	sh install.sh

	menu

	elif [ "$opcao" == "2" ]; then
	noroot
	cd src/
	sh installyaourt.sh

	menu

  elif [ "$opcao" == "3" ]; then
	noroot
	clear
	yaourt -Syua --noconfirm
	echo; echo "-> Precione enter para prosseguir..."
	read
	menu

  elif [ "$opcao" == "4" ]; then
	noroot
	clear
	yaourt -Scc
	echo; echo "-> Precione enter para prosseguir..."
	read
	menu

  elif [ "$opcao" == "5" ]; then
	noroot
	clear
	programa=$(dialog --stdout \
	    --backtitle 'Instalar' \
	    --inputbox 'Informe o nome do programa para instalar: ' 10 50)
	clear
	yaourt -S --needed $programa --noconfirm
	echo; echo "-> Precione enter para continuar"; read
	menu

  elif [ "$opcao" == "6" ]; then
	noroot
	clear
	programa=$(dialog --stdout \
	    --backtitle 'Desinstalar' \
	    --inputbox 'Informe o nome do programa para desinstalar: ' 10 50)
	clear
	yaourt -R $programa --noconfirm
	echo; echo "-> Precione enter para continuar"; read
	menu

  elif [ "$opcao" == "7" ]; then
	noroot
	clear
	programa=$(dialog --stdout \
	    --backtitle 'Desinstalar com dependencias' \
	    --inputbox 'Informe o nome do programa para desinstalar com as suas dependencias: ' 10 50)
	clear
	yaourt -Rscn $programa --noconfirm
	echo; echo "-> Precione enter para continuar"; read
	menu

  elif [ "$opcao" == "8" ]; then
	noroot
	clear
	programa=$(dialog --stdout \
	    --backtitle 'Buscar' \
	    --inputbox 'Informe o nome do programa para buscar: ' 10 50)
	clear
	yaourt $programa
	echo; echo "-> Precione enter para continuar"; read
	menu

  elif [ "$opcao" == "9" ]; then
	noroot
	clear
	yaourt --stats
	echo; echo "-> Precione enter para continuar"; read
	menu

  elif [ "$opcao" == "10" ]; then
  clear
  bootloader_install
  echo; echo "-> Precione enter para continuar"; read
  menu

  elif [ "$opcao" == "11" ]; then
	dialog --yesno 'Tem certeza que deseja reinciar?' 0 0
	if [ $? = 0 ]; then
	reboot
	else
 	menu
	fi
	menu

	elif [ "$opcao" == "0" ]; then
  clear
	echo "Saindo do ASI..."
	exit

	menu
  elif [ "$opcao" == "12" ]; then
	dialog --title 'Sobre' --msgbox '\n
	\n
	  ########################################################################\n
	  #                                                                      #\n
	  #          		Akila Project - Akila Script Installer (ASI)             	#\n
	  #                                                                      #\n
	  ########################################################################\n
	\n
  		\n
																							GNU GENERAL PUBLIC LICENSE\n
					 																			Version 3, 29 June 2007\n\n

	    Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.org/>\n
	     Everyone is permitted to copy and distribute verbatim copies\n
	     of this license document, but changing it is not allowed.\n
	\n
	\n
	\n
	\n
	                    Copyright (c) 2016 Akila Project\n
' 25 80
	menu
else
echo 'Saindo do programa...'
fi
}
menu
