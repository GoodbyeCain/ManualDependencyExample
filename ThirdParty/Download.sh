#! /usr/bin/env bash
set -e

function current_branch {
  echo `git branch | sed -n -e "s/^\* \(.*\)/\1/p"`
}

IFS=","
while read name repo revision; do
  echo $name
  echo $repo
  echo $revision
  echo "here"
  git clone $repo $name
  pushd $name
  git pull --tags
  if [ `current_branch` != "$revision" ]; then
    if [ -z `git branch -a | grep "remotes/origin/$revision"` ]; then
      git checkout $revision -b $revision
    else
      git checkout $revision
    fi
  fi
  rm -rf .git
  popd 
done < Repositories.csv

