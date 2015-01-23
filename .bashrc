# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
export HISTCONTROL=ignoredups
# ... and ignore same sucessive entries.
export HISTCONTROL=ignoreboth

# make the history file bigger
export HISTFILESIZE=9000
# but write each line to history after execution (SO HANDY)
export PROMPT_COMMAND='history -a'

# Add solarized color support
export TERM=xterm-256color

# Include dot (.) files in the results of expansion
shopt -s dotglob
# Case-insensitive matching for filename expansion
shopt -s nocaseglob
# Enable extended pattern matching
shopt -s extglob
# Enable options:
shopt -s cdspell # fixes typos and spelling mistakes using 'cd'
shopt -s cdable_vars # magic cd variable stuff (man bash) search for "^SHELL BUILTIN COMMANDS"
shopt -s checkhash # check a command exists before executing it
shopt -s no_empty_cmd_completion # do not search for possible completions when completion is attempted on an empty line.
shopt -s cmdhist # attempt to save all lines of a multiple-line command in the same history entry.
shopt -s histappend histreedit histverify # various history things


# make various commands pretty
alias ls='ls -GhF' #colours and useful bits
export GREP_OPTIONS='--color=auto' GREP_COLOR='1;32'
export CLICOLOR=1


# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    export PS1='\[\033[01;32m\]\u@\h\[\033[01;34m\] \w\[\033[01;33m\]$(__git_ps1)\[\033[01;34m\] \$\[\033[00m\] '
else
    export PS1='\u@\h\ \w\$(__git_ps1) \$\ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"'
    ;;
*)
    ;;
esac

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ] && [ -x /usr/bin/dircolors ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi

#drupal cvs alias
alias bsod='rdesktop -g 1280x1024 bsod'

alias grep='grep --color=auto'
alias g='grep -irn --color=auto'

#Aliases
##ls, the common ones I use a lot shortened for rapid fire usage
alias l='ls -lFh'     #size,show type,human readable
alias la='ls -lAFh'   #long list,show almost all,show type,human readable
alias lr='ls -tRFh'   #sorted by date,recursive,show type,human readable
alias lt='ls -ltFh'   #long list,sorted by date,show type,human readable
alias cpc="drush php-eval \"module_load_include('inc', 'scmp_cache', 'scmp_cache.admin'); scmp_cache_flush_cache('cache_panels');\""

function todo {
  if [ $1 ]; then
    vim ~/todo/$1
  else
    ls ~/todo
  fi
}

function ff {
  if [ ! $1 ]; then
    echo "Must provide function name as first parameter."
  else
    grep -irn --color=auto "function $1" *
  fi
}

function dmod {
  dir='./'
  while [ ! -f "${dir}index.php" ]; do dir="$dir../" ;done
  ROOT=`realpath $dir`
  array=(`find $ROOT . -name $1.info`)
  if [ ${#array[@]} -eq 0 ]; then
    echo "$1 does not exist"
    return;
  fi
  if [ ${#array[@]} -eq 1 ]; then
    MODULE_PATH=`dirname "$array"`
  else
    infoFile=${array[@]:$((${#array[@]}-1))}
    MODULE_PATH=`dirname "$infoFile"`
  fi
  if [ -d $MODULE_PATH ]; then
    pushd $MODULE_PATH
  else
    echo "$1 does not exist."
  fi
}

#export PATH=${PATH}:/home/samb/android-sdk-linux/tools:/home/samb/anroid-sdk-linux/platform-tools 
#“alias android-connect=”mtpfs -o allow_other /media/Nexus10” >> ~/.bashrc
#echo “alias android-disconnect=\”fusermount -u /media/Nexus10\”
#alias android-connect="mtpfs -o allow_other /media/GalaxyNexus"
#alias android-connect="mtpfs -o allow_other /media/Nexus10"
#alias android-disconnect="fusermount -u /media/Nexus10"
#alias android-connect="mtpfs -o allow_other /media/Nexus10"
#alias android-disconnect="fusermount -u /media/Nexus10"
#alias android-connect="mtpfs -o allow_other /media/GalaxyNexus"
#alias android-disconnect="fusermount -u /media/GalaxyNexus"
#alias android-connect="mtpfs -o allow_other /media/GalaxyNexus"
#alias android-disconnect="fusermount -u /media/GalaxyNexus"

# Function selects Drush 6 if we are in Drupal 8 folder.
drush() {
  drush5=/usr/bin/drush # Set your path to Drush 5
  drush6=/home/sam/drush6/drush # Set your path to Drush 6
   
  dir="`pwd`"
   
  until [ $dir = "/" ]
    do
# Try to find Drupal 7.
      if [ -f "$dir/includes/database/database.inc" ]; then
        command $drush5 "$@"
        return
      fi
       
# Try to find Drupal 8.
      if [ -f "$dir/core/lib/Drupal.php" ]; then
        command $drush6 "$@"
        return
      fi
     
# Go to parrent directory.
      dir="`dirname $dir`"
    done
     
# Nothing found about Drupal version. Fallback to Drush 5.
    command $drush5 "$@"
}
