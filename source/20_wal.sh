(wal -v >/dev/null 2>&1)
if [ $? -eq 0 ]; then
  echo "hi"
fi
