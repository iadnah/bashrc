spin ()
{
	echo -ne "${RED}-"
	echo -ne "${WHITE}\b|"
	echo -ne "${BLUE}\bx"
	sleep .02
	echo -ne "${RED}\b+${NC}"
}


loadRcDir ${HOME}/.bash_functions.d
