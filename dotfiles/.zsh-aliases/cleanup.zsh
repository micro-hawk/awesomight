free -h

# clear PageCache only
# sync; echo 1 > /proc/sys/vm/drop_caches

# clear dentries and inodes.
# sync; echo 2 > /proc/sys/vm/drop_caches


# Note, we are using "echo 3", but it is not recommended in production instead use "echo 1"
# clear pagecache, dentries, and inodes
echo "running sync..."
sync;

echo "clearing memeory..."
sudo sh -c 'echo 3 > /proc/sys/vm/drop_caches'

free -h

# Need sudo user to use this
echo "Clearing pacman cache"
sudo pacman -Sc

# paccache -r

# -u for uninstalled packages only
# paccache -ru
