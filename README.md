# batudot

what my terminal looks like. macOS, zsh, and the cli tools i'd miss on a fresh machine.

kept in sync across my two macs with [chezmoi](https://chezmoi.io).

## install

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply batunpc
```

grabs homebrew + everything, drops the configs in place. open a new terminal after.

(set your terminal font to a nerd font, the brewfile installs MesloLGS NF, otherwise the prompt icons show up as little tofu boxes.)

## what's in here

- **zsh**: powerlevel10k by default, or a minimal pure-zsh prompt. flip with `prompt minimal` / `prompt p10k`. plus fast-syntax-highlighting, autosuggestions, fzf-tab
- **history**: atuin (fuzzy, and `↑` only shows commands from this folder)
- **moving around**: zoxide, eza, bat, fd, ripgrep, fzf
- **git**: lazygit, delta, and fzf-git (`ctrl-g` then `b` / `h` / `s` for branches / hashes / stashes)
- **odds and ends**: dust, procs, sd, jless, fx, glow, xh, doggo, tldr, onefetch, gum
- a stack of abbreviations, aliases and functions. poke around the `dot_config/zsh` files.

## notes to self

- nothing secret lives here. private stuff goes in `~/.config/zsh/local.zsh` (ignored, sourced if it's there).
- changed something? `chezmoi re-add` then push. on the other mac, `chezmoi update`.

## want it?

fork it, run the install with your username instead of mine. leave `personal = false` and you skip my flutter/android/db junk. trim the brewfiles, make it yours.

mit, take whatever's useful.
