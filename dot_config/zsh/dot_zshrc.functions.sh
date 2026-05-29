# Custom functions loaded after the main ~/.zshrc.
# (hr / mkcd / extract / psg / timezsh live inline in .zshrc — not duplicated here.)

# ── Git helpers ──────────────────────────────────────────────────────────────
# Clone a repo and cd into it
gclone() { git clone "$1" && cd "$(basename "${1%.git}")"; }
# Stage all + commit
gcom() { git add -A && git commit -m "$*"; }
# Stage all + commit + push in one go
lazyg() { git add -A && git commit -m "$*" && git push; }
# Interactively switch git branches (needs gum)
gbs() {
  command -v gum &>/dev/null || { echo "needs: brew install gum"; return 1; }
  local b; b=$(git branch --all | sed 's/^[* ]*//; s#remotes/[^/]*/##' | sort -u | gum filter) && git switch "$b"
}

# ── Web helpers ──────────────────────────────────────────────────────────────
# Weather report. Usage: weather [city]
weather() { curl -s "wttr.in/${1:-}"; }
# Cheat sheet for a command (cheat.sh). Usage: cheat tar
cheat() { curl -s "cheat.sh/$1"; }
# Generate a .gitignore. Usage: gi macos,node,python
gi() { curl -sfL "https://www.toptal.com/developers/gitignore/api/$*"; }

# ── Local utilities ──────────────────────────────────────────────────────────
# Quick notes: `note` prints them, `note <text>` appends a timestamped line
note() {
  local f="$HOME/.notes.txt"
  if [ $# -eq 0 ]; then [ -f "$f" ] && cat "$f"; else echo "$(date '+%F %T') - $*" >> "$f"; fi
}
# Serve the current dir over HTTP (default :8000) and open it
server() { local p="${1:-8000}"; open "http://localhost:${p}/" 2>/dev/null; python3 -m http.server "$p"; }
# Copy the current path to the clipboard
cpwd() { pwd | tr -d '\n' | pbcopy && echo "📋 copied: $(pwd)"; }
# Timestamped backup of a file
backup() { [ -f "$1" ] && cp "$1" "$1.backup-$(date +%Y%m%d-%H%M%S)" && echo "🗂  $1.backup-…" || echo "no such file: $1"; }
# Quick calculator. Usage: calc '3 * (4 + 1)'
calc() { echo "scale=3; $*" | bc -l; }
# Local + external IP
myip() {
  local lo ex
  lo=$(ipconfig getifaddr en0 2>/dev/null || echo inactive)
  ex=$(curl -s --max-time 3 ifconfig.me 2>/dev/null || echo inactive)
  printf '%11s: %s\n%11s: %s\n' "Local IP" "$lo" "External IP" "$ex"
}

# ── Fun ──────────────────────────────────────────────────────────────────────
# figlet banner piped through lolcat (random font)
banner() {
  command -v figlet &>/dev/null || { echo "$*"; return; }
  local fonts=(slant small smslant standard) f
  f=${fonts[$((RANDOM % ${#fonts[@]} + 1))]}
  figlet -f "$f" "$*" 2>/dev/null | { command -v lolcat &>/dev/null && lolcat || cat; }
}
# Print the 256-color palette
show_colors() { local i; for i in {0..255}; do printf "\x1b[38;5;${i}m%4d\x1b[0m " "$i"; (( (i + 1) % 12 == 0 )) && echo; done; echo; }

# ── Maintenance ──────────────────────────────────────────────────────────────
# Update brew + tldr cache (and remind about dotfiles sync)
update_all() {
  echo "==> Homebrew";  brew update && brew upgrade && brew cleanup
  command -v tldr    &>/dev/null && { echo "==> tldr cache"; tldr --update; }
  command -v chezmoi &>/dev/null && echo "tip: 'chezmoi update' syncs dotfiles across machines"
  echo "✅ done"
}
