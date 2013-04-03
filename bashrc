# bashrc 1.1.2 - 2012-01-12
#  - iadnah :: iadnah.net :: gitbrew.org
#
# This bashrc is one I made to make some of the work I do
# a little less teadious. 
#
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
################################################################################


# If not running interactively, don't do anything
[ -z "$PS1" ] && return


export BASHRC_VERSION="1.1.2"

# USER OPTIONS
################################################################################
# Edit these variables to easily change the behavior of this script. Commented
# variables are the default settings.
################################################################################

# Add ${HOME}/bin and ${HOME}/.bin to your path if they exist.
# Binaries and scripts in these folders will the be available on the command
# line without having to type their full paths
#
U_BINS=1

# Load ~/.bash_functions
# .bash_functions can contain user-defined functions.
#
# Set to 0 to disable
#
U_FUNCS=1

# Load ~/.bash_aliases
# .bash_aliases can contain user-defined aliases.
#
# Set to 0 to disable
#
U_ALIASES=1

# Enable lesspipe
# This bit makes it so less can seamlessly/transparently open
# compressed documents and (possibly) other file types
#
# This is already configured on Gentoo and some other distros. Set this to 1
# if your distro is not one of these
#
#ENABLE_LESSPIPE=0


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
ENABLE_LESSPIPE=${ENABLE_LESSPIPE:-"0"}
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
# in the prompt and shouldn't be used elsewhere
eBLACK='\[\e[0;30m\]'
eBLUE='\[\e[0;34m\]'
eGREEN='\[\e[0;32m\]'
eCYAN='\[\e[0;36m\]'
eRED='\[\e[0;31m\]'
ePURPLE='\[\e[0;35m\]'
eBROWN='\[\e[0;33m\]'
eLIGHTGRAY='\[\e[0;37m\]'
eDARKGRAY='\[\e[1;30m\]'
eLIGHTBLUE='\[\e[1;34m\]'
eLIGHTGREEN='\[\e[1;32m\]'
eLIGHTCYAN='\[\e[1;36m\]'
eLIGHTRED='\[\e[1;31m\]'
eIGHTPURPLE='\[\e[1;35m\]'
eELLOW='\[\e[1;33m\]'
eHITE='\[\e[1;37m\]'
eNC='\[\e[0m\]'

# Define colors for generic usage
BLACK='\e[0;30m'
BLUE='\e[0;34m'
GREEN='\e[0;32m'
CYAN='\e[0;36m'
RED='\e[0;31m'
PURPLE='\e[0;35m'
BROWN='\e[0;33m'
LIGHTGRAY='\e[0;37m'
DARKGRAY='\e[1;30m'
LIGHTBLUE='\e[1;34m'
LIGHTGREEN='\e[1;32m'
LIGHTCYAN='\e[1;36m'
LIGHTRED='\e[1;31m'
LIGHTPURPLE='\e[1;35m'
YELLOW='\e[1;33m'
WHITE='\e[1;37m'
NC='\e[0m'

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
fi

# PERSONAL BINARIES
################################################################################
# Binaries and scripts placed in ~/bin or ~/.bin will be added to the PATH
U_BINS=${U_BINS:-"1"}
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

U_ALIASES=${U_ALIASES:-"1"}
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
U_FUNCS=${U_FUNCS:-"1"}
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




