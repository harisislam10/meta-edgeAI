# ubuntu-base_%.bbappend

# Remove conflicting files that are also provided by ncurses
FILES:${PN}__usr_bin_tput = ""
FILES:${PN}__usr_bin_tset = ""
# You might also want to remove /usr/bin/clear if that also conflicts with ncurses-base
# FILES:${PN}__usr_bin_clear = ""

# Alternatively, if ubuntu-base provides a subpackage for these, you could use RDEPENDS:remove
# if it specifically provides these files.