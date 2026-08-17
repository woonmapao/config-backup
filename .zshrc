# Powerlevel10k instant prompt (disabled: switched to Starship, see bottom of file)
# if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
#   source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
# fi

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
ZSH_THEME=""  # disabled: Starship renders the prompt now (Oh My Zsh plugins still load below)

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

# Catppuccin Latte token colors, matched to the editor theme (must load before oh-my-zsh
# so the assoc array is created correctly).
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES=(
  comment                           'fg=#7C7F93,italic'
  alias                             'fg=#1E66F5,italic'
  suffix-alias                      'fg=#1E66F5,italic'
  global-alias                      'fg=#1E66F5,italic'
  function                          'fg=#1E66F5,italic'
  command                           'fg=#1E66F5'
  precommand                        'fg=#1E66F5,italic'
  autodirectory                     'fg=#FE640B,italic'
  single-hyphen-option              'fg=#FE640B'
  double-hyphen-option              'fg=#FE640B'
  back-quoted-argument              'fg=#8839EF'
  builtin                           'fg=#209FB5'
  reserved-word                     'fg=#8839EF'
  hashed-command                    'fg=#1E66F5'
  commandseparator                  'fg=#179299'
  command-substitution-delimiter    'fg=#4C4F69'
  back-quoted-argument-delimiter    'fg=#EA76CB'
  back-double-quoted-argument       'fg=#EA76CB'
  back-dollar-quoted-argument       'fg=#EA76CB'
  command-substitution-quoted       'fg=#40A02B'
  single-quoted-argument            'fg=#40A02B'
  double-quoted-argument            'fg=#40A02B'
  single-quoted-argument-unclosed   'fg=#D20F39'
  double-quoted-argument-unclosed   'fg=#D20F39'
  rc-quote                          'fg=#40A02B'
  dollar-quoted-argument            'fg=#4C4F69'
  dollar-quoted-argument-unclosed   'fg=#D20F39'
  assign                            'fg=#4C4F69'
  named-fd                          'fg=#4C4F69'
  numeric-fd                        'fg=#4C4F69'
  unknown-token                     'fg=#D20F39'
  path                              'fg=#4C4F69'
  path_pathseparator                'fg=#EA76CB'
  path_prefix                       'fg=#4C4F69'
  globbing                          'fg=#4C4F69'
  history-expansion                 'fg=#8839EF'
  back-quoted-argument-unclosed     'fg=#D20F39'
  redirection                       'fg=#4C4F69'
  arg0                              'fg=#4C4F69'
  default                           'fg=#4C4F69'
  cursor                            'standout'
)

# zsh-autosuggestions: default dim grey is unreadable on a light background.
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#8C8FA1'

source $ZSH/oh-my-zsh.sh

# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh  # disabled: Starship replaces p10k

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

# >>> backend-setup >>>
eval "$(mise activate zsh)"
eval "$(direnv hook zsh)"
eval "$(starship init zsh)"
alias cat='bat'
alias rg='rg --smart-case'
# <<< backend-setup <<<
