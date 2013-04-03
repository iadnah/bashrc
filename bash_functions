spin ()
{
	echo -ne "${RED}-"
	echo -ne "${WHITE}\b|"
	echo -ne "${BLUE}\bx"
	sleep .02
	echo -ne "${RED}\b+${NC}"
}


if [ -d ~/.bash_functions.d ]; then
	for inc in ~/.bash_functions.d/*; do
		. ${inc}
	done
fi
