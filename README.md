# Patarapong Limvipaveeanan
## ภัทรพงศ์ ลิ้มวิภาวีอนันต์

## New Mac setup

```
git clone https://github.com/woonmapao/config-backup.git ~/dotfiles
cd ~/dotfiles && ./install.sh
```

Symlinks shell/git/starship/docker/Cursor config into place and runs `brew bundle` off `Brewfile` to install everything (Go, gh, lazygit, direnv, mise, starship, colima, docker, DBeaver, Bruno, Cursor, etc). Finish with `gh auth login`.

| File | Target |
|---|---|
| `.zshrc` / `.zprofile` | `~/` — Oh My Zsh, history, Starship/mise/direnv hooks |
| `.gitconfig` | `~/` |
| `starship.toml` | `~/.config/starship.toml` — Catppuccin Latte prompt |
| `docker_config.json` | `~/.docker/config.json` — makes `docker compose` resolve under Colima |
| `vsc_cfg/` | Cursor's `User/settings.json` + `keybindings.json` |
| `Brewfile` | `brew bundle` manifest |
