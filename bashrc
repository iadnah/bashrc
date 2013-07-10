# bashrc 1.2.4-p6 - 2013-06-18
#
# This is a full-featured and modular bashrc file for usage with the bash
# shell.
#
# COPYRIGHT
###########
# bashrc is Copyright (c) Jason Thistlethwaite 2013 (iadnah@uplinklounge.com)
#
#    bashrc is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 2 of the License, or
#    (at your option) any later version.
#
#    bashrc is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with bashrc.  If not, see <http://www.gnu.org/licenses/>.
#
##########
################################################################################

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

#ENABLE DEBUG/TRACING (FOR DEVELOPERS)
export U_DEBUG=${U_DEBUG:-"0"}
if [ "$U_DEBUG" == "1" ]; then
	set -x
fi

declare -a BASHRC_VERSIONINFO
BASHRC_VERSIONINFO[0]=1		#Major version
BASHRC_VERSIONINFO[1]=2		#Minor version
BASHRC_VERSIONINFO[2]=4		#Micro version
BASHRC_VERSIONINFO[3]=9		#Patch ID
BASHRC_VERSIONINFO[4]="beta"	#Release type

export BASHRC_VERSIONINFO
export BASHRC_VERSION="${BASHRC_VERSIONINFO[0]}.${BASHRC_VERSIONINFO[1]}.${BASHRC_VERSIONINFO[2]}"

# USER OPTIONS
################################################################################
# Edit these variables to easily change the behavior of this script. Commented
# variables are the default settings.
################################################################################

# Sets the default title for the terminal window
export U_DEFAULT_TITLE=${U_DEFAULT_TITLE:-"$BASH"}

# If U_PRECUSTOM is set to 1, the load ~/.bashrc.precustom before proceeding.
# This allows users to set custom options, functions, aliases, etc. which will
# be loaded before the rest of this bashrc. It can be used to configure the
# rest of the U_* env variables to a user's liking.
export U_PRECUSTOM=${U_PRECUSTOM:-"1"}
if [ "${U_PRECUSTOM}" == "1" ]; then
	if [ -f ~/.bashrc.precustom ]; then
		. ~/.bashrc.precustom
	fi
fi

# If set to 1 load (source) ~/.bashrc.postcustom at the very end of this bashrc.
# This can be used to tweak the config, overload settings/functions/aliases, or
# whatever.
export U_POSTCUSTOM=${U_POSTCUSTOM:-"1"}

# Add ${HOME}/bin and ${HOME}/.bin to your path if they exist.
# Binaries and scripts in these folders will the be available on the command
# line without having to type their full paths
#
export U_BINS=${U_BINS:-"1"}

# Load ~/.bash_functions
# .bash_functions can contain user-defined functions.
#
# Set to 0 to disable
#
export U_FUNCS=${U_FUNCS:-"1"}

# Load ~/.bash_aliases
# .bash_aliases can contain user-defined aliases.
#
# Set to 0 to disable
#
export U_ALIASES=${U_ALIASES:-"1"}

# Enable lesspipe
# This bit makes it so less can seamlessly/transparently open
# compressed documents and (possibly) other file types
#
# This is already configured on Gentoo and some other distros. Set this to 1
# if your distro is not one of these
#
export ENABLE_LESSPIPE=${ENABLE_LESSPIPE:-"1"}

# Set up ssh and/or gpg agents (this is not complete)
export U_AGENTS=${U_AGENTS:-"1"}

# Enable support for modules
export U_MODULES_ENABLE=${U_MODULES_ENABLE:-"0"}

# USER ENVIRONMENT
################################################################################
# Environment variables which should be set/exported at the beginning of the
# user's session.

# Default GPG key to use
#GPGKEY=

################################################################################
# END USER ENVIRONMENT

################################################################################
# BEGIN MAIN SECTION
################################################################################
# NOTICE:
# Unless you know what you are doing don't edit past this point.
################################################################################


# BASH OPTIONS
################################################################################
# Various BASH settings
 
	# don't put duplicate lines in the history. See bash(1) for more options
	# ... or force ignoredups and ignorespace
	HISTCONTROL=ignoredups:ignorespace

	# append to the history file, don't overwrite it
	shopt -s histappend

	# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
	HISTSIZE=1000
	HISTFILESIZE=2000

	# check the window size after each command and, if necessary,
	# update the values of LINES and COLUMNS.
	shopt -s checkwinsize

	#Enables advanced pathname matching
	shopt -s extglob

	#Don't do completion when the prompt is empty
	shopt -s no_empty_cmd_completion

	#Look for command in the hashtable before checking the $PATH
	shopt -s checkhash

################################################################################
# END OF BASH OPTIONS

# LESSPIPE - Open non-text input files with less
########################################################################
# This bit makes it so less can seamlessly/transparently open
# compressed documents and (possibly) other file types
#
# This is default on Gentoo and some other distros. Uncomment this if
# you think you need it.
#
# make less more friendly for non-text input files, see lesspipe(1)
if [ "$ENABLE_LESSPIPE" == "1" ]; then
	[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"
fi

# COLORS
############################################################################
# Bunch of BS about whether or not we can show colors and text properly
# This should read like this:
#
# if [ $TERM == "tectia" ]; then
# 	export FORCE_COLOR_DISABLE=9001
#	export LANG="utf8"
#
#	while [ 0 ]; do
#		sleep($RANDOM}
#		PROMPT_COMMAND="head -c $RANDOM /dev/urandom"
#	done
#
#############################################################################

# Define colors for usage in prompts. Note that these are escaped for usage
# in the prompt and shouldn't be used elsewhere. Read the bash man page to
# see why this is necessary
export eBLACK='\[\e[0;30m\]'
export eBLUE='\[\e[0;34m\]'
export eGREEN='\[\e[0;32m\]'
export eCYAN='\[\e[0;36m\]'
export eRED='\[\e[0;31m\]'
export ePURPLE='\[\e[0;35m\]'
export eBROWN='\[\e[0;33m\]'
export eLIGHTGRAY='\[\e[0;37m\]'
export eDARKGRAY='\[\e[1;30m\]'
export eLIGHTBLUE='\[\e[1;34m\]'
export eLIGHTGREEN='\[\e[1;32m\]'
export eLIGHTCYAN='\[\e[1;36m\]'
export eLIGHTRED='\[\e[1;31m\]'
export eIGHTPURPLE='\[\e[1;35m\]'
export eYELLOW='\[\e[1;33m\]'
export eWHITE='\[\e[1;37m\]'
export eNC='\[\e[0m\]'

# Define colors for generic usage
export BLACK='\e[0;30m'
export BLUE='\e[0;34m'
export GREEN='\e[0;32m'
export CYAN='\e[0;36m'
export RED='\e[0;31m'
export PURPLE='\e[0;35m'
export BROWN='\e[0;33m'
export LIGHTGRAY='\e[0;37m'
export DARKGRAY='\e[1;30m'
export LIGHTBLUE='\e[1;34m'
export LIGHTGREEN='\e[1;32m'
export LIGHTCYAN='\e[1;36m'
export LIGHTRED='\e[1;31m'
export LIGHTPURPLE='\e[1;35m'
export YELLOW='\e[1;33m'
export WHITE='\e[1;37m'
export NC='\e[0m'

FORCE_COLOR_DISABLE=${FORCE_COLOR_DISABLE:-''}
FORCE_COLOR_PROMPT=${FORCE_COLOR_PROM:-"yes"}

if [ -n $FORCE_COLOR_DISABLE ]; then
	color_prompt=yes
else
	color_prompt=no
fi

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=no
    fi
fi

if [ "$color_prompt" == "yes" ]; then
	export PS1="\n[${eLIGHTGREEN}\t${eNC}] :: [${eLIGHTBLUE}\w${eNC}]\n${eLIGHTGREEN}\u${eWHITE}@${eLIGHTGREEN}\h${eWHITE} >${eNC} "
else
	export PS1="\n[\t] :: [\w]\n\u@\h\> "
fi
unset color_prompt force_color_prompt
####################################
# End of the bullshit about colors
#

# BUT WAIT, THERE'S MORE! : LSCOLORS
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
elif [ $(CLICOLOR) = 1 ]; then
	export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
else
	export CLICOLOR=0
fi

# INTERNAL FUNCTIONS
################################################################################
# These are functions internal to this whole shabang
function loadRcDir() {
	if [ -d "$1" ]; then
	        for rcFile in ${1}/*; do
	                . ${rcFile}
			local ret=$?
	                #if [ $ret != "0" ]; then
	                #        echo "BASHRC ERROR: '$rcFile' failed to load. The last function called within returned $ret, expected 0." 1>&2
	                #fi
	        done
	fi
}

# Sets the terminal title
# TODO: Update SetTitle so it doesn't output anything if the terminal won't handle it intelligently
function SetTitle() {
	unset PROMPT_COMMAND
	PROMPT_COMMAND="echo -ne \"\033]0;\"$@\" ($USER@$HOSTNAME)\007\";\
		echo -ne \"\033]1;\"$@\" ($USER@$HOSTNAME)\007\";\
		unset PROMPT_COMMAND"

}

# Helper function to output messages to stderr
function ErrorMsg() {
	echo $@ 1>&2
}

# Reload bash
function rebash() {
	. ~/.bashrc
}

################################################################################
# END INTERNAL FUNCTIONS


# PERSONAL BINARIES
################################################################################
# Binaries and scripts placed in ~/bin or ~/.bin will be added to the PATH
export U_BINS=${U_BINS:-"1"}
if [ "${U_BINS}" == "1" ]; then
	if [ -d "${HOME}/bin" ]; then
		PATH="${PATH}:${HOME}/bin"
	fi

	if [ -d "${HOME}/.bin" ]; then
		PATH="${PATH}:${HOME}/.bin"
	fi
fi
################################################################################
# END PERSONAL BINARIES

export U_AGENTS=${U_AGENTS:-"1"}
export U_KEYCHAIN_OPTS=${U_KEYCHAIN_OPTS:-"--inherit local -Q --eval"}
if [ "${U_AGENTS}" == "1" ]; then
	# Check if keychain is installed (in path). If it is, see if it has
	# already set up our agents and try to use them. Otherwise, start it.
	KEYCHAIN=$(which keychain 2>/dev/null)
	if [ "$?" == "0" ]; then
		[ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
		if [ -f ${HOME}/.keychain/${HOSTNAME}-sh ]; then
			. ${HOME}/.keychain/${HOSTNAME}-sh
			if [ -z "$SSH_AGENT_PID" ] || [ ! -d "/proc/$SSH_AGENT_PID" ]; then
				eval `${KEYCHAIN} ${U_KEYCHAIN_OPTS}`
			fi
		fi

		eval `${KEYCHAIN} ${U_KEYCHAIN_OPTS}`
	fi
fi


export U_ALIASES=${U_ALIASES:-"1"}
#BREAK:aliases
# only load this section and user-defined aliases if 
# envvar U_ALIASES == "0"
#
if [ "${U_ALIASES}" == "1" ]; then

	# Alias definitions.
	# You may want to put all your additions into a separate file like
	# ~/.bash_aliases, instead of adding them here directly.
	# See /usr/share/doc/bash-doc/examples in the bash-doc package.

	# some more ls aliases
	alias ll='ls -alF'
	alias la='ls -A'
	alias l='ls -CF'
	alias ls-readdir='ls --color=none --format commas'
	alias l1='ls -1'
	alias la1='ls -a -1'

	if [ -f ~/.bash_aliases ]; then
	    . ~/.bash_aliases
	fi
fi


#BREAK:functions
export U_FUNCS=${U_FUNCS:-"1"}
if [ "${U_FUNCS}" == "1" ]; then

	# CUSTOM FUNCTIONS
	#######################################################################
	# Load custom bash functions for use in your shell and scripts
	#
	if [ -f ~/.bash_functions ]; then
	    . ~/.bash_functions
	fi
fi

# PROGRAMMABLE COMPLETION
if ! shopt -oq posix; then
	if [ -f /usr/share/bash-completion/bash_completion ]; then
		. /usr/share/bash-completion/bash_completion
	elif [ -f /etc/bash_completion ]; then
		. /etc/bash_completion
	fi

	if [ -f ~/.bash_completion ]; then
		. ~/.bash_completion
	fi
fi

# Set terminal title to the running command
export U_UPDATETITLE=${U_UPDATETITLE:-"1"}
if [ "${U_UPDATETITLE}" == "1" ]; then
	set -o functrace
	trap 'SetTitle "$BASH_COMMAND"' DEBUG
fi

ErrorMsg -ne "Module support: \t"
if [ "${U_MODULES_ENABLE}" == "1" ]; then
	ErrorMsg " enabled"
        source ~/.bash_modules
else
	ErrorMsg " disabled"
fi

# USER CUSTOMIZATIONS
export U_POSTCUSTOM=${U_POSTCUSTOM:-"1"}
if [ "${U_POSTCUSTOM}" == "1" ]; then
	if [ -f ~/.bashrc.postcustom ]; then
		. ~/.bashrc.postcustom
	fi

fi

SetTitle $U_DEFAULT_TITLE
