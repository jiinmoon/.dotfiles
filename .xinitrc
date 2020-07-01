# Remap Caps Lock to ESC.
setxkbmap -option caps:excape

# Black/White grid?
xsetroot -solid black &

# Start composite manager.
xcompmgr -c -f -D 5 &

# Bind multimedia keys.
xbindkeys

# Kill em all!
exec /usr/bin/ratpoison
