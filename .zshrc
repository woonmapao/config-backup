# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew: skip duplicate shellenv when login .zprofile already ran (faster startup).
if [[ -z "${HOMEBREW_PREFIX:-}" ]]; then
  if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
  fi
fi

# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

COMPLETION_WAITING_DOTS=true

# history-substring-search before zsh-autosuggestions; zsh-syntax-highlighting must be last.
plugins=(
  golang
  git
  brew
  command-not-found
  history-substring-search
  sudo
  extract
  colored-man-pages
  copypath
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# History (see zshoptions(1); complements Oh My Zsh defaults)
HISTSIZE=50000
SAVEHIST=50000
setopt EXTENDED_HISTORY       # ': <timestamp>:<elapsed>;command' in HISTFILE
setopt HIST_EXPIRE_DUPS_FIRST # trim duplicates when HISTFILE is trimmed
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE      # omit commands prefixed with a space
setopt SHARE_HISTORY          # share history across concurrent sessions

# Dracula-style token colors (must load before oh-my-zsh so the assoc array is created correctly).
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES=(
  comment                           'fg=#6272A4'
  alias                             'fg=#50FA7B'
  suffix-alias                      'fg=#50FA7B'
  global-alias                      'fg=#50FA7B'
  function                          'fg=#50FA7B'
  command                           'fg=#50FA7B'
  precommand                        'fg=#50FA7B,italic'
  autodirectory                     'fg=#FFB86C,italic'
  single-hyphen-option              'fg=#FFB86C'
  double-hyphen-option              'fg=#FFB86C'
  back-quoted-argument              'fg=#BD93F9'
  builtin                           'fg=#8BE9FD'
  reserved-word                     'fg=#8BE9FD'
  hashed-command                    'fg=#8BE9FD'
  commandseparator                  'fg=#FF79C6'
  command-substitution-delimiter    'fg=#F8F8F2'
  back-quoted-argument-delimiter    'fg=#FF79C6'
  back-double-quoted-argument       'fg=#FF79C6'
  back-dollar-quoted-argument       'fg=#FF79C6'
  command-substitution-quoted       'fg=#F1FA8C'
  single-quoted-argument            'fg=#F1FA8C'
  double-quoted-argument            'fg=#F1FA8C'
  single-quoted-argument-unclosed   'fg=#FF5555'
  double-quoted-argument-unclosed   'fg=#FF5555'
  rc-quote                          'fg=#F1FA8C'
  dollar-quoted-argument            'fg=#F8F8F2'
  dollar-quoted-argument-unclosed   'fg=#FF5555'
  assign                            'fg=#F8F8F2'
  named-fd                          'fg=#F8F8F2'
  numeric-fd                        'fg=#F8F8F2'
  unknown-token                     'fg=#FF5555'
  path                              'fg=#F8F8F2'
  path_pathseparator                'fg=#FF79C6'
  path_prefix                       'fg=#F8F8F2'
  globbing                          'fg=#F8F8F2'
  history-expansion                 'fg=#BD93F9'
  back-quoted-argument-unclosed     'fg=#FF5555'
  redirection                       'fg=#F8F8F2'
  arg0                              'fg=#F8F8F2'
  default                           'fg=#F8F8F2'
  cursor                            'standout'
)

source $ZSH/oh-my-zsh.sh

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

if (( ${+commands[fzf]} )); then
  for _fzf_shell in "${HOMEBREW_PREFIX:-/opt/homebrew}/opt/fzf/shell" /opt/homebrew/opt/fzf/shell /usr/local/opt/fzf/shell; do
    if [[ -f $_fzf_shell/key-bindings.zsh ]]; then
      source "$_fzf_shell/key-bindings.zsh"
      [[ -f $_fzf_shell/completion.zsh ]] && source "$_fzf_shell/completion.zsh"
      break
    fi
  done
  unset _fzf_shell
fi

# Go — do not set GOROOT; the installed toolchain sets it (see `go env GOROOT`).
# Prefer the official installer: https://go.dev/doc/install
if [[ -x /usr/local/go/bin/go ]]; then
  export PATH="/usr/local/go/bin:$PATH"
fi
if command -v go >/dev/null 2>&1; then
  export GOPATH="$(go env GOPATH)"
  export PATH="$(go env GOPATH)/bin:$PATH"
  export GOPRIVATE='bitbucket.org/minor_digital/*'
fi

export EDITOR="${EDITOR:-vim}"

# User binaries
export PATH="$HOME/.local/bin:$PATH"

# Aliases
if (( ${+commands[colorls]} )); then
  alias lc='colorls -lA --sd'
fi
