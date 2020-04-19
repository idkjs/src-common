#!/bin/sh

FILELIST=$(git status | grep modified: | sed -e 's/modified://' | sed -e 's/^\#'//)

git pull origin master
for FLIST in $(echo ${FILELIST}); do
  echo "${FLIST}"
  git add ${FLIST}
done

git config --global user.email "aarmand.inbox@gmail.com"
git config --global user.name "Alain Armand"
git commit -m updates
echo "git clean -fd"
git clean -fX

exit 0
