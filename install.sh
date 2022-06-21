#!/bin/bash
# all I see turns to brown; as the sun turns to brown
for old in .bashrc .bash_aliases .bash_completion .bash_functions; do
	if [ -f "${HOME}/${old}" ]; then
		echo "Found existing ${old}, backing up to ${old}.bak"
		mv ${HOME}/${old} ${HOME}/${old}.bak
	fi
done

for new in bashrc bash_aliases bash_functions bash_completion bash_modules; do
	if [ -f "./${new}" ]; then
		echo "Installing ${new}"
		cp -v "./${new}" "${HOME}/.${new}" 2>/dev/null | awk '{print "\t" $0}'

	fi
done

unset $new

for new in bashrc.precustom bashrc.postcustom; do
	if [ -f "./${new}" ]; then
		if [ -f "${HOME}/.${new}" ]; then
			loop=1
			while [ $loop == 1 ]; do
				read -p "Overwrite ${HOME}/.${new} [Y/n] " overwrite
				case "$overwrite" in
					'Y'|'y'|'yes')
						cp -v "./${new}" "${HOME}/.${new}" 2>/dev/null | awk '{print "\t" $0}'
						loop=0
					;;

					'N'|'n'|'no')
						echo "No"
						loop=0
					;;

					*)
						echo "Type 'yes' or 'no' (I'm lazy)"
					;;

				esac
				unset $overwrite

			done
		else 
			echo "Installing ${new}"
			cp -v "./${new}" "${HOME}/.${new}" 2>/dev/null | awk '{print "\t" $0}'
		fi
	fi
done

for newd in bash_aliases bash_functions bash_completion bash_modules; do
	if [ ! -d "${HOME}/.${newd}.d}" ]; then
		echo "Creating ${HOME}/.${newd}.d:"

		mkdir -pv "${HOME}/.${newd}.d"
		chmod 0700 "${HOME}/.${newd}.d"
	fi

	if [ -d "${HOME}/.${newd}.d" ]; then
		cp -rv ./${newd}.d/* ${HOME}/.${newd}.d/ 2>/dev/null | awk '{print "\t" $0}'
	fi
done
