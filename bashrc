# bashrc 1.1.1 - 2012-01-12
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

# Start gpg-agent
# Uncomment and set to 1 to enable
#
# This is currently semi-broken
#U_GPGAGENT=0


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
#	export LANC="utf8"
#
#	while [ 0 ]; do
#		sleep($RANDOM}
#		PROMPT_COMMAND="head -c $RANDOM /dev/urandom"
#	done
#
#############################################################################
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
	PS1='\[\033[01;34m\]\t :: \w\n\[\033[01;32m\]\u\[\033[01;00m\]@\[\033[01;34m\]\h\[\033[01;00m\]\$ '
else
	PS1="\t :: \w\n\u@\h\$ "
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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

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


# GPG-AGENT Start
################################################################################
function u_gpgagent_start()
{
	eval $(gpg-agent --daemon --write-env-file "${HOME}/.gpg-agent-info" --log-file "${HOME}/.gnupg/gpg-agent.log")
}
alias "start-gpg-agent"=u_gpgagent_start

U_GPGAGENT=${U_GPGAGENT:-"0"}
if [ "${U_GPGAGENT}" == "1" ]; then
	u_gpgagent_start
	if [ -e "${HOME}/.gpg-agent-info" ]; then
		. ${HOME}/.gpg-agent-info
		export GPG_AGENT_INFO
	fi
fi
################################################################################
# GPG-AGENT End


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


