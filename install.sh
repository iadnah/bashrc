#!/bin/bash

for old in .bashrc .bash_aliases .bash_completion .bash_functions; do
	if [ -f "${HOME}/${old}" ]; then
		echo "Found existing ${old}, backing up to ${old}.bak"
		mv ${HOME}/${old} ${HOME}/${old}.bak
	fi
done

for new in bashrc bash_aliases bash_functions bash_completion; do
	if [ -f "./${new}" ]; then
		echo "Installing ${new}"
		cp -v "./${new}" "${HOME}/.${new}" 2>/dev/null | awk '{print "\t" $0}'

	fi
done

for newd in bash_aliases bash_functions bash_completion; do
	if [ ! -d "${HOME}/.${newd}.d}" ]; then
		echo "Creating ${HOME}/.${newd}.d:"

		mkdir -pv "${HOME}/.${newd}.d"
		chmod 0700 "${HOME}/.${newd}.d"
	fi

	if [ -d "${HOME}/.${newd}.d" ]; then
		cp -rv ./${newd}.d/* ${HOME}/.${newd}.d/ 2>/dev/null | awk '{print "\t" $0}'
	fi
done
