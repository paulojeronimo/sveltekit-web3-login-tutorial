#!/usr/bin/env bash

TUT_MARK='# SVELTEKIT_WEB3_LOGIN'
TUT_DIR=$(cd "$(dirname "$BASH_SOURCE[0]")"; pwd)
PROFILE=~/.bashrc

tut() {
  case "$1" in
    add)
      shift
      (cd "$TUT_DIR"/files; rsync -R $1 $OLDPWD)
      ;;
    apply)
      shift
      git apply "$TUT_DIR"/files/$1
      ;;
    uninstall)
      sed -i "/^$TUT_MARK/,+1d" $PROFILE
      ;;
    *)
      cd "$TUT_DIR"
  esac
}

if ! grep -q -e "^$TUT_MARK" $PROFILE
then
  echo "$TUT_MARK" >> $PROFILE
  echo ". $TUT_DIR/functions.sh" >> $PROFILE
fi
