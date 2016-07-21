#!/usr/bin/env bash
cd "$(dirname "${BASH_SOURCE}")"
git pull origin master
function doIt() {
	rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
		--exclude "README.md" --exclude "LICENSE-GPL.txt" \
		--exclude "LICENSE-MIT.txt" --exclude "Putty_Theme.txt" \
        -av --no-perms $dir/. ~
}

function selectProfile() {
    shopt -s dotglob
    shopt -s nullglob
    array=(profile*/)
    PS3="Which profile do you want applied? "
    echo "There are ${#array[@]} profiles in the current path"; \
        select dir in "${array[@]}"; do echo "About to apply: ${dir}"; break; done
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt
else
    selectProfile
    if [ -n "$dir" ]; then
        read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
        echo
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            doIt
        fi
    fi
    unset selectProfile
    shopt -u dotglob
    shopt -u nullglob
fi
unset doIt
source ~/.bash_profile
