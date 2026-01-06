# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=$HOME/.oh-my-zsh-custom

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git z vi-mode brew jj)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Use mvim (MacVim) on macOS if available, otherwise use vim
if command -v mvim > /dev/null 2>&1 && [[ -z $SSH_CONNECTION ]]; then
  export EDITOR='mvim'
  # https://github.com/macvim-dev/macvim/wiki/FAQ#how-can-i-use-macvim-to-edit-git-commit-messages
  export GIT_EDITOR='mvim -f --nomru -c "au VimLeave * !open -a iTerm"'
  export JJ_EDITOR='mvim -f --nomru'
else
  export EDITOR='vim'
fi

if [[ -z "$TERM" || "$TERM" = "xterm" ]]; then
  export TERM=xterm-256color
fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# cd in the git root directory if called for a git subdirectory
alias v=$EDITOR' -c "cd "$(git rev-parse --show-toplevel 2> /dev/null || pwd)""'
alias m='meson'
alias t='unbuffer meson test --print-errorlogs | sed "s/FAIL:/\\x1b[1;31mFAIL\x1b[0m:/g"'

# CTRL-Y to copy the command into clipboard using pbcopy
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# LESS configuration:
# --quit-if-one-screen: automatically exit if the content fits on one screen
# --ignore-case: ignore case in searches that do not contain uppercase
# --jump-target=.3: scroll to 30% of the screen height when jumping to a target
# --tabs=8: set tab stops every 8 spaces
# -R: display raw control characters for ANSI colour
# --quit-on-intr: exit less on CTRL-C
# --long-prompt: provide a more detailed prompt
export LESS='--quit-if-one-screen --ignore-case --jump-target=.3 --tabs=8 -R --quit-on-intr --long-prompt'

# bat can be used as a colorizing pager for man, by setting the MANPAGER environment variable
if type "bat" > /dev/null; then
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# Map 'K' in vi-mode to run-help (like in Vim)
bindkey -M vicmd 'K' run-help

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if [[ -r ~/.iterm2_shell_integration.zsh ]]; then
  source ~/.iterm2_shell_integration.zsh
fi

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

#For pipx
export PATH="$PATH:$HOME/.local/bin"

if [[ "$OSTYPE" == "darwin"* ]]; then
  #For homebrew
  export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
  export PATH="/opt/homebrew/opt/python3/libexec/bin:$PATH"
  export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  # for clang-tidy
  export SDKROOT=/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk
  alias docker=podman
fi

export PYTHONSTARTUP=$HOME/.config/ptpython/startup.py
export PTPYTHON_CONFIG_HOME=$HOME/.config/ptpython
export PATH="/opt/homebrew/opt/rustup/bin:$PATH"
