parent_pid=$(ps -o ppid= $$)
hasNixShell=""
# while non empty or not 0 and nix-shell not found
while [ -n "$parent_pid" ] && [ "$parent_pid" -ne 0 ] && [ -z "$hasNixShell" ]; do
    hasNixShell=$(ps -f -p "$parent_pid" | grep nix-shell)
    # turn hasNixShell into a boolean
    hasNixShell=${hasNixShell:+(❄️-shell)}
    parent_pid=$(ps -o ppid= "$parent_pid")
    parent_pid=`echo $parent_pid | sed -e 's/^[[:space:]]*//'`
done
echo $hasNixShell
