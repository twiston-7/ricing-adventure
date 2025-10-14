# Load Oh My Zsh and theme
export ZSH="$HOME/.oh-my-zsh"                             # Change if OMZ is elsewhere
ZSH_THEME="powerlevel10k/powerlevel10k"                   # Install p10k and set Nerd Font in terminal [web:40][web:53]

# History: large, fast, deduped, shared across sessions
HISTFILE="$HOME/.zhistory"
HISTSIZE=200000
SAVEHIST=200000
setopt INC_APPEND_HISTORY SHARE_HISTORY                   # Write immediately; share between shells [web:46]
setopt HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS             # Avoid saving duplicates [web:46]
setopt HIST_FIND_NO_DUPS HIST_IGNORE_SPACE                # Space-prefix cmds not recorded; no dup in search [web:46]
setopt EXTENDED_HISTORY HIST_REDUCE_BLANKS                # Timestamps/elapsed; trim extra spaces [web:46]

# Sensible shell behavior
setopt AUTO_CD                                            # `cd` on plain directory name [web:49]
setopt CORRECT                                            # Spell-correct simple typos for commands [web:49]
setopt NO_BEEP                                            # Disable bell [web:49]

# Completion: initialize once, cache for speed
autoload -Uz compinit
zstyle ':completion:*' menu select                        # Interactive menu completion [web:49]
zstyle ':completion:*' squeeze-slashes true               # Collapse '//' in paths [web:49]
zmodload zsh/complist
if [[ -n "$ZDOTDIR" ]]; then compdump_dir="$ZDOTDIR"; else compdump_dir="$HOME"; fi
if [[ ! -f "$compdump_dir/.zcompdump" || "$(( $(date +%s) - $(stat -c %Y "$compdump_dir/.zcompdump" 2>/dev/null || echo 0) ))" -gt 86400 ]]; then
  compinit -C                                            # Rebuild dump daily for correctness [web:47]
else
  compinit -C                                            # Use cached dump for speed [web:47]
fi

# Paths and editor
export EDITOR="nvim"
export VISUAL="$EDITOR"
export PAGER="less -R"

# Aliases: modern ls, safety, quality of life
alias ls='eza --group-directories-first --icons --color=always'  # Requires eza [web:35]
alias la='ls -la'
alias gs='git status -sb'                                        # Short git status [web:28]
alias gc='git commit'
alias gp='git push'
alias ..='cd ..'
alias ...='cd ../..'

# Prompt theme configuration
# Run `p10k configure` to interactively tweak segments, icons, and colors. [web:40][web:53]
[[ -r "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

# Plugins: useful, light, and fast
plugins=(
  git                 # Git aliases and helpers [web:28]
  z                   # Frecency-based directory jumping [web:28]
  sudo                # Press esc twice to prepend sudo [web:28]
  colored-man-pages   # Colorized man pages [web:28]
)
source "$ZSH/oh-my-zsh.sh"                                      # Initialize OMZ after setting plugins [web:27]

# Community plugins (clone into $ZSH_CUSTOM/plugins before enabling)
# zsh-autosuggestions: inline history-based suggestions [web:52]
# zsh-syntax-highlighting: live command syntax colors (must load last) [web:51]
# fast-syntax-highlighting: faster alternative to the above [web:56]
# zsh-autocomplete: rich completion UI (heavier, replace menu-select) [web:56]
# Enable if installed:
if [[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]]; then
  source "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"   # [web:52]
fi
if [[ -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]]; then
  source "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"  # Load last [web:51]
fi

# Git prompt speed-ups (optional)
export GITSTATUS_CACHE_DIR="$HOME/.cache/gitstatus"              # Reduce VCS latency in large repos [web:40]

# Fastfetch on interactive shells only
if [[ -o interactive ]]; then
  command -v fastfetch >/dev/null 2>&1 && fastfetch               # Skip in non-interactive scripts [web:47]
fi