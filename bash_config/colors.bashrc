# use custom color mappings if they exist, else default
# see https://unix.stackexchange.com/questions/241726/fix-ls-colors-for-directories-with-777-permission )
# use "dircolors -p > ~/.dircolors" to generate initial custom colors
[ -e ~/.dircolors ] && eval $(dircolors -b ~/.dircolors) || eval $(dircolors -b)
