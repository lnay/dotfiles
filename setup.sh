#!/bin/sh

# Setup symlinks
mkdir -p ~/.config/nvim
for file in '.zshrc' '.bashrc'; do
	if test -h ~/${file}
	then
		echo "~/${file} is already a symlink, leaving for now"
		continue
	elif test -f "~/${file}" && diff -q ${file} "~/${file}" 2>&1 >/dev/null
	then
		echo "~/${file} differs from repo, stored in ~/${file}.original"
		mv ~/${file} ~/${file}.original
	else
		rm ~/${file}
	fi
	ln -s "${file}" "~/${file}"
done


# oh-my-zsh
#     (from ohmyz.sh/#install)
test -f '.oh-my-zsh' || sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
