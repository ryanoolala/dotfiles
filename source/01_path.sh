
if [ -n "$BASH_VERSION" ]; then
paths=(
  ~/.local/bin
  /usr/local/bin
  /bin
  $DOTFILES/bin
)
echo hello
export PATH
for p in "${paths[@]}"; do
  [[ -d "$p" ]] && PATH="$p:$(path_remove "$p")"
done
unset p paths
fi
