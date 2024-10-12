# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugin configuration
plugins=(
	golang
	git
	docker
	brew
	command-not-found
	zsh-autosuggestions
	zsh-syntax-highlighting
)

# Set up highlighting styles
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES=(
  [comment]='fg=#6272A4'
  [alias]='fg=#50FA7B' 
  [suffix-alias]='fg=#50FA7B'
  [global-alias]='fg=#50FA7B'
  [function]='fg=#50FA7B'
  [command]='fg=#50FA7B'
  [precommand]='fg=#50FA7B,italic'
  [autodirectory]='fg=#FFB86C,italic'
  [single-hyphen-option]='fg=#FFB86C'
  [double-hyphen-option]='fg=#FFB86C'
  [back-quoted-argument]='fg=#BD93F9'
  [builtin]='fg=#8BE9FD'
  [reserved-word]='fg=#8BE9FD'
  [hashed-command]='fg=#8BE9FD'
  [commandseparator]='fg=#FF79C6'
  [command-substitution-delimiter]='fg=#F8F8F2'
  [back-quoted-argument-delimiter]='fg=#FF79C6'
  [back-double-quoted-argument]='fg=#FF79C6'
  [back-dollar-quoted-argument]='fg=#FF79C6'
  [command-substitution-quoted]='fg=#F1FA8C'
  [single-quoted-argument]='fg=#F1FA8C'
  [double-quoted-argument]='fg=#F1FA8C'
  [single-quoted-argument-unclosed]='fg=#FF5555'
  [double-quoted-argument-unclosed]='fg=#FF5555'
  [rc-quote]='fg=#F1FA8C'
  [dollar-quoted-argument]='fg=#F8F8F2'
  [dollar-quoted-argument-unclosed]='fg=#FF5555'
  [assign]='fg=#F8F8F2'
  [named-fd]='fg=#F8F8F2'
  [numeric-fd]='fg=#F8F8F2'
  [unknown-token]='fg=#FF5555'
  [path]='fg=#F8F8F2'
  [path_pathseparator]='fg=#FF79C6'
  [path_prefix]='fg=#F8F8F2'
  [globbing]='fg=#F8F8F2'
  [history-expansion]='fg=#BD93F9'
  [back-quoted-argument-unclosed]='fg=#FF5555'
  [redirection]='fg=#F8F8F2'
  [arg0]='fg=#F8F8F2'
  [default]='fg=#F8F8F2'
  [cursor]='standout'
)

# Source necessary files
source $ZSH/oh-my-zsh.sh
source ~/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Set environment variables
export GOPRIVATE=bitbucket.org/minor_digital/*

# Aliases
alias lc='colorls -lA --sd'

# Additional configurations
# Uncomment lines below as needed:
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
# CASE_SENSITIVE="true"
# HYPHEN_INSENSITIVE="true"
# ENABLE_CORRECTION="true"
# COMPLETION_WAITING_DOTS="true"
# DISABLE_UNTRACKED_FILES_DIRTY="true"
# HIST_STAMPS="mm/dd/yyyy"
