# Where the magic happens.
export DOTFILES=~/.dotfiles
# Source all files in "source"
function src() {
  local file
  if [[ "$1" ]]; then
    source "$DOTFILES/source/$1.sh"
  else
    for file in $DOTFILES/source/*; do
      source "$file"
    done
  fi
}

# Run dotfiles script, then source.
function dotfiles() {
  $DOTFILES/bin/dotfiles "$@" && src
}
export PATH="${PATH}:${HOME}/.local/bin/"
# Import colorscheme from 'wal' asynchronously
# &   # Run the process in the background.
# ( ) # Hide shell job control messages.
(cat ~/.cache/wal/sequences &)

# Alternative (blocks terminal for 0-3ms)
(cat ~/.cache/wal/sequences)

# To add support for TTYs this line can be optionally added.
source ~/.cache/wal/colors-tty.sh
setsid wal -qi ~/Pictures/ 

alias i3config='vim /home/ryangoh/.config/i3/config'

src
