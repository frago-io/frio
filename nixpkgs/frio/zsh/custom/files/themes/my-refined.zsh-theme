#!/usr/bin/env zsh

# ------------------------------------------------------------------------------
#
# Pure - A minimal and beautiful theme for oh-my-zsh
#
# Based on the custom Zsh-prompt of the same name by Sindre Sorhus. A huge
# thanks goes out to him for designing the fantastic Pure prompt in the first
# place! I'd also like to thank Julien Nicoulaud for his "nicoulaj" theme from
# which I've borrowed both some ideas and some actual code. You can find out
# more about both of these fantastic two people here:
#
# Sindre Sorhus
#   GitHub:   https://github.com/sindresorhus
#   Twitter:  https://twitter.com/sindresorhus
#
# Julien Nicoulaud
#   GitHub:   https://github.com/nicoulaj
#   Twitter:  https://twitter.com/nicoulaj
#
# ------------------------------------------------------------------------------

# Set required options
#
setopt prompt_subst

# Load required modules
#
autoload -Uz vcs_info

# Set vcs_info parameters
#
zstyle ':vcs_info:*' enable hg bzr git
zstyle ':vcs_info:*:*' unstagedstr '!'
zstyle ':vcs_info:*:*' stagedstr '+'
zstyle ':vcs_info:*:*' formats "$FX[bold]%r$FX[no-bold]/%S" "%s:%b" "%%u%c"
zstyle ':vcs_info:*:*' actionformats "$FX[bold]%r$FX[no-bold]/%S" "%s:%b" "%u%c (%a)"
zstyle ':vcs_info:*:*' nvcsformats "%~" "" ""

# Fastest possible way to check if repo is dirty
#
git_dirty() {
    # Check if we're in a git repo
    command git rev-parse --is-inside-work-tree &>/dev/null || return
    # Check if it's dirty
    command git diff --quiet --ignore-submodules HEAD &>/dev/null; [ $? -eq 1 ] && echo "*"
}

git_branch() {
  #local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
  echo "$vcs_info_msg_1_`git_dirty` $vcs_info_msg_2_"
}

# Display information about the current repository
#
general_information() {
    #echo "%F{blue}${vcs_info_msg_0_%%/.} %F{8}$vcs_info_msg_1_`git_dirty` $vcs_info_msg_2_%f"
    local system="${NIX_CONFIG#*=}"

    local prefix="%F{blue}${vcs_info_msg_0_%%/.} %F{8}${SSH_TTY:+%n@}%F{8}${SSH_TTY:+%m}%f"
    local sufix="%F{8}$vcs_info_msg_2_%F{blue}$hasNixShell%f"
    if [ -n "$system" ]; then
        system=`echo $system | sed -e 's/^[[:space:]]*//'`
        echo "$prefix %F{8}($system)%f $sufix"
    else
        echo "$prefix $sufix"
    fi
}

# Displays the exec time of the last command if set threshold was exceeded
#
cmd_exec_time() {
    local stop=`date +%s`
    local start=${cmd_timestamp:-$stop}
    let local elapsed=$stop-$start
    [ $elapsed -gt 5 ] && echo ${elapsed}s
}

# Get the initial timestamp for cmd_exec_time
#
preexec() {
    cmd_timestamp=`date +%s`
}

# Output additional information about paths, repos and exec time
#
precmd() {
    setopt localoptions nopromptsubst
    vcs_info # Get version control info before we start outputting stuff
    print -P "\n$(general_information) %F{yellow}$(cmd_exec_time)%f"
    unset cmd_timestamp #Reset cmd exec time.
}

# Define prompts
#
PROMPT="%(?.%F{magenta}.%F{red})❯%f " # Display a red prompt char on failure
#PROMPT="%(?.%F{red}.%F{196})❯%f " # Display a red prompt char on failure
#RPROMPT="%F{8}${SSH_TTY:+%n@%m}%f"    # Display username if connected via SSH
#display git info in right prompt
RPROMPT='%F{yellow}$(git_prompt_info)%f'

parent_pid=$(ps -o ppid= $$)
hasNixShell=""
# while non empty or not 0 and nix-shell not found
while [ -n "$parent_pid" ] && [ "$parent_pid" -ne 0 ] && [ -z "$hasNixShell" ]; do
    hasNixShell=$(ps -f -p "$parent_pid" | grep nix-shell)
    # turn hasNixShell into a boolean
    hasNixShell=${hasNixShell:+(❄️-shell)}
    parent_pid=$(ps -o ppid= "$parent_pid")
    parent_pid=`echo $parent_pid | sed -e 's/^[[:space:]]*//'`
done

# ------------------------------------------------------------------------------
#
# List of vcs_info format strings:
#
# %b => current branch
# %a => current action (rebase/merge)
# %s => current version control system
# %r => name of the root directory of the repository
# %S => current path relative to the repository root directory
# %m => in case of Git, show information about stashes
# %u => show unstaged changes in the repository
# %c => show staged changes in the repository
#
# List of prompt format strings:
#
# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)
#
# ------------------------------------------------------------------------------
