# Custom aliases loaded after the main ~/.zshrc.
# Modern replacements (ls/cat/grep/less) are in ~/.zshrc — don't override here.

# ── Dotfiles (chezmoi) ───────────────────────────────────────────────────────
alias dots='chezmoi'
alias dotsedit='chezmoi edit --apply'   # edit a managed file and apply on save
alias dotsync='chezmoi update'          # pull + apply  (use this on your 2nd Mac)
alias dotsadd='chezmoi re-add'          # capture local edits back into the repo
alias dotscd='chezmoi cd'               # drop into the source repo
alias dotsdiff='chezmoi diff'           # preview what apply would change

# ── Git recovery ─────────────────────────────────────────────────────────────
alias undo-git-reset-head='git reset HEAD@{1}'
alias undo-git-add='git restore --staged'

# ── Modern-CLI conveniences (each tool also works under its own name) ─────────
alias lg='lazygit'
alias repo='onefetch'                   # repo "fetch" art on demand
alias cl='clear'

# ── Global aliases (pipe fragments usable anywhere on the line) ──────────────
alias -g G='| rg'                       #  history G ssh
alias -g L='| less'
alias -g H='| head'
alias -g T='| tail'
alias -g C='| wc -l'
alias -g NE='2>/dev/null'
alias -g NUL='>/dev/null 2>&1'

# ── Suffix aliases (run a file by opening it in the right tool) ──────────────
alias -s {md,markdown}=glow
alias -s {json}=jless

# ── Pretty clock ─────────────────────────────────────────────────────────────
alias clock='tty-clock -S -s -b -c -D -n'
alias caffeinate='command caffeinate -i & tty-clock -c'

# ── Recursively delete .DS_Store + python/test caches in the current tree ─────
alias cleanup='total=$(find -E . -type d -not -path "*/Library/*" -regex ".*(\.DS_Store|__pycache__|\.mypy_cache|\.pytest_cache|\.(bak|log|swp)).*" -prune -name $HOME -prune -print0 | xargs -0 du -c | tail -1 | cut -f1); files=$(find -E . -type d -not -path "*/Library/*" -regex ".*(\.DS_Store|__pycache__|\.mypy_cache|\.pytest_cache|\.(bak|log|swp)).*" -prune -name $HOME -prune -ls -delete); if [ -z "$files" ]; then echo "Nothing to delete."; else echo "Total space freed: ${total}"; fi;'

# ── Brew ─────────────────────────────────────────────────────────────────────
alias bu='brew update && brew upgrade && brew cleanup'

# ── Docker ───────────────────────────────────────────────────────────────────
alias docker-clean-containers='docker container rm -f $(docker container ls -aq)'
alias docker-clean-images='docker image rm -f $(docker image ls -aq)'
alias dcu='docker compose up -d'
alias dcd='docker compose down'
alias dcr='docker compose restart'
alias dcl='docker compose logs -f'

# ── jq sorted keys by default ────────────────────────────────────────────────
alias jq='jq --sort-keys'
