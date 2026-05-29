# Minimal pure-zsh prompt, inspired by gh0stzk's, in the Catppuccin Mocha palette.
# No daemon, no framework: just vcs_info. Switch back anytime with: prompt p10k
#
# Want a different prompt character? Change the ❯ below (try λ, ❀, ✦, ➜).

setopt prompt_subst
autoload -Uz vcs_info add-zsh-hook

zstyle ':vcs_info:*'     enable git
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' unstagedstr '%F{#fab387} !%f'              # peach  = unstaged changes
zstyle ':vcs_info:git:*' stagedstr   '%F{#a6e3a1} +%f'              # green  = staged changes
zstyle ':vcs_info:git:*' formats       ' %F{#cba6f7} %b%f%u%c'     # mauve branch
zstyle ':vcs_info:git:*' actionformats ' %F{#cba6f7} %b%f %F{#f38ba8}(%a)%f'

_minimal_precmd() { vcs_info }
add-zsh-hook precmd _minimal_precmd

# two lines: path (blue) + git on top, prompt char below (green ok / red on error)
PROMPT='%F{#89b4fa}%~%f${vcs_info_msg_0_}
%(?.%F{#a6e3a1}.%F{#f38ba8})❯%f '
RPROMPT=''   # ensure no leftover right-prompt from a previous p10k session
