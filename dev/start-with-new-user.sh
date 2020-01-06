#!/bin/sh

old="him"
new="ymc"
# reset the code
#git reset HEAD --hard

#back up old author code some branch
git branch "$old"

#create a none commit log branch
git checkout --orphan "$new"

#file-usage
#./dev/start-with-new-user.sh
