if [ -d "${HOME}/.bash_aliases.d" ]; then
	. ${HOME}/.bash_aliases.d/*

#	for inc in $( ls ${HOME}/.bash_aliases.d); do
#		echo "aliases: ${inc}"
#	done
fi
