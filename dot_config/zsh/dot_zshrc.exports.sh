# Environment exports loaded after the main ~/.zshrc.
# Keep this file for env vars only (history/prompt/completion live in .zshrc).
# $BREW_PREFIX is exported by .zshrc before this file is sourced.

export HOMEBREW_NO_ANALYTICS=1
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
[ -d /usr/local/scripts ] && export PATH="$PATH:/usr/local/scripts"

# Android SDK (platform-tools already added in .zshrc; add the rest if present)
if [ -d "$HOME/Library/Android/sdk" ]; then
  export ANDROID_HOME="$HOME/Library/Android/sdk"
  [ -d "$ANDROID_HOME/tools" ] && export PATH="$PATH:$ANDROID_HOME/tools"
fi

# Less / mysql: don't write a history file (privacy)
export LESSHISTFILE=-
MYSQL_HISTFILE=-

# Ninja status for cmake builds — https://ninja-build.org/manual.html
export NINJA_STATUS="[%f/%t %o/s %p] "

# tcl-tk (only if installed via Homebrew)
if [ -n "$BREW_PREFIX" ] && [ -d "$BREW_PREFIX/opt/tcl-tk" ]; then
  export PATH="$BREW_PREFIX/opt/tcl-tk/bin:$PATH"
  export PKG_CONFIG_PATH="$BREW_PREFIX/opt/tcl-tk/lib/pkgconfig${PKG_CONFIG_PATH:+:$PKG_CONFIG_PATH}"
fi

# C / C++ colored diagnostics
export CFLAGS="${CFLAGS} -fdiagnostics-color=always"
export CXXFLAGS="${CXXFLAGS} -fdiagnostics-color=always"
export CCFLAGS="${CCFLAGS} -fdiagnostics-color=always"

# Qt5 + tcl-tk build flags (only if those kegs are installed)
_ld=""; _cpp=""
if [ -n "$BREW_PREFIX" ] && [ -d "$BREW_PREFIX/opt/qt@5" ]; then
  _ld="$_ld -L$BREW_PREFIX/opt/qt@5/lib"; _cpp="$_cpp -I$BREW_PREFIX/opt/qt@5/include"
fi
if [ -n "$BREW_PREFIX" ] && [ -d "$BREW_PREFIX/opt/tcl-tk" ]; then
  _ld="$_ld -L$BREW_PREFIX/opt/tcl-tk/lib"; _cpp="$_cpp -I$BREW_PREFIX/opt/tcl-tk/include"
fi
[ -n "$_ld" ]  && export LDFLAGS="${LDFLAGS}$_ld"
[ -n "$_cpp" ] && export CPPFLAGS="${CPPFLAGS}$_cpp"
unset _ld _cpp

# Dart pub cache
[ -d "$HOME/.pub-cache/bin" ] && export PATH="$PATH:$HOME/.pub-cache/bin"

# Golang
if [ -d /usr/local/go ]; then
  export GOROOT=/usr/local/go
  export PATH="$PATH:$GOROOT/bin"
fi
export GOPATH="$HOME/go"
[ -d "$GOPATH/bin" ] && export PATH="$PATH:$GOPATH/bin"

# rbenv — lazy load on first rbenv/ruby/gem/bundle call (no fork on every shell)
if command -v rbenv &>/dev/null; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  rbenv()  { unset -f rbenv ruby gem bundle 2>/dev/null; eval "$(command rbenv init -)"; rbenv "$@"; }
  ruby()   { unset -f rbenv ruby gem bundle 2>/dev/null; eval "$(command rbenv init -)"; ruby "$@"; }
  gem()    { unset -f rbenv ruby gem bundle 2>/dev/null; eval "$(command rbenv init -)"; gem "$@"; }
  bundle() { unset -f rbenv ruby gem bundle 2>/dev/null; eval "$(command rbenv init -)"; bundle "$@"; }
fi

# Tab title behaviour
SHELL_SESSIONS_DISABLE=1
DISABLE_AUTO_TITLE="true"
