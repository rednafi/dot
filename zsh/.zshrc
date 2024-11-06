# ==============================
# BASIC SETUP
# ==============================

# Set the prompt
eval "$(starship init zsh)"

# Load aliases and environment variables
source ~/.zsh_aliases
source ~/.zshenv

# Key bindings and color settings
bindkey -e
export CLICOLOR=1

# ==============================
# HISTORY SETTINGS
# ==============================

# History options
setopt SHARE_HISTORY \
    INC_APPEND_HISTORY \
    HIST_IGNORE_ALL_DUPS \
    HIST_REDUCE_BLANKS \
    HIST_IGNORE_DUPS \
    HIST_IGNORE_SPACE \
    HIST_VERIFY \
    HIST_BEEP
HISTSIZE=10000
SAVEHIST=1000000

# ==============================
# ZSH COMPLETION SETTINGS
# ==============================

# Case-insensitive and substring matching for completion
zstyle ':completion:*' matcher-list \
    'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'

# Show completion menu on second tab press
zstyle ':completion:*' menu select

# ==============================
# PLUGINS
# ==============================

# Directory for plugins
zsh_plugins_dir="$HOME/.zsh_plugins"
github_plugins=(
    zsh-users/zsh-autosuggestions
    marlonrichert/zsh-autocomplete
    zsh-users/zsh-history-substring-search
    zsh-users/zsh-syntax-highlighting  # Must be last
)

# Clone and load plugins
for plugin in $github_plugins; do
    plugin_dir="$zsh_plugins_dir/$plugin"
    if [[ ! -d $plugin_dir ]]; then
        mkdir -p "$plugin_dir"
        git clone --depth 1 "https://github.com/$plugin.git" "$plugin_dir" &> /dev/null
    fi
    source "$plugin_dir/${plugin#*/}.plugin.zsh" &> /dev/null || true
done

# ==============================
# OPTIONAL TOOLS (Deferred Background Load)
# ==============================

{
    # Load direnv
    command -v direnv &>/dev/null && eval "$(direnv hook zsh)"
} &!

# Load sdkman
export SDKMAN_DIR="$HOME/.sdkman"
alias sdk="source $SDKMAN_DIR/bin/sdkman-init.sh && sdk"

# ==============================
# PATH SETUP
# ==============================

export PATH="/opt/homebrew/bin:$HOME/.local/share/uv/python:/opt/homebrew/opt/sqlite/bin:\
/opt/homebrew/opt/coreutils/libexec/gnubin:$HOME/go/bin:$PATH"

# Editor configuration
export EDITOR="micro"
export VISUAL="code --wait"

# CD path for quick navigation
CDPATH="$CDPATH:$HOME/canvas"
