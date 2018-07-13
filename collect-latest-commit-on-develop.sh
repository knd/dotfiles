#!/bin/sh
RED='\033[0;31m';
YELLOW='\033[1;33m';
GREEN='\033[0;32m';
NC='\033[0m';

### Setup on OS X:
###
### cd /usr/local/bin; ln -s /Users/knd/Code/dotfiles/collect-latest-commit-on-develop.sh collect-latest-dependency-commit
###

if [[ -z $1 ]]; then
  echo "${RED}You need to supply at least 1 dependency man (e.g. chainz-executor)${NC}";
  echo;
  echo "Usage:";
  echo;
  echo "$(basename $0) chainz-executor";
  echo "$(basename $0) chainz-ui";
  echo "$(basename $0) chainz-ui chainz-executor";
  exit 1;
fi;

CURRENT_DIR=$(pwd);

collect_dependency_commit() {
  cd /Users/knd/Code/$1;
  git fetch upstream --prune --recurse-submodules || exit 1;
  local latestCommit=$(git log -1 --pretty=oneline upstream/develop | cut -f 1 -d ' ');
  cd $CURRENT_DIR;
  echo $latestCommit;
}

sed -i -e "s/^\($1: \)\(.*\)$/\1$(collect_dependency_commit $1)/g" dependencies.txt;
if [[ ! -z $2 ]]; then
  sed -i -e "s/^\($2: \)\(.*\)$/\1$(collect_dependency_commit $2)/g" dependencies.txt;
fi;


echo "${GREEN}******************************${NC}";
echo "${GREEN}dependencies.txt is updated with:${NC}";
echo;
echo "${GREEN}$(grep $1 dependencies.txt)${NC}";
if [[ ! -z $2  ]]; then
  echo "${GREEN}$(grep $2 dependencies.txt)${NC}";
fi;
