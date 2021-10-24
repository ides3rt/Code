#!/usr/bin/env bash

yes=0
force=0

Usage() {
  while read; do
    printf '%s\n' "$REPLY"
  done <<-EOF
	Usage: ec [OPTION]
	  -h, --help      - Displays help information.
	  -f, --force     - Allows root to run this script.
	  -y, --yes       - Answers yes to all questions.
EOF
}

case "$1" in
  -h|--help)
    Usage; exit 0 ;;
  -f|--force)
    force=1 ;;
  -y|--yes)
    yes=1 ;;
  '') ;;
  *) echo 'Invaild Arg(s)...\n'; exit 1 ;;
esac

[ `id -u` = 0 ] && [ $force != 1 ] && printf 'Avoid running this script as root...\n' && exit 1

[ $yes = 1 ] && rm -rf $HOME/.cache/* $HOME/.mozilla/firefox/{Crash\ Reports,Pending\ Pings} && printf 'Done...\n' && exit 0

if [ -d "$HOME/.cache" ]; then
  read -p 'Do you want to clear cache? [Y/n]: ' input
    case $input in
      [Yy][Ee][Ss]|[Yy]|'')
        rm -rf $HOME/.cache/* ;;
      [Nn][Oo]|[Nn]) ;;
      *) printf 'Invaild Arg(s)...\n'; exit 1 ;;
    esac
else
  echo 'No cache was found...'
fi

if [ -d "$HOME/.mozilla/firefox/Crash Reports" -o -d "$HOME/.mozilla/firefox/Pending Pings" ]; then
  read -p 'Do you wanna clear Firefox reports? [Y/n]: ' input
    case $input in
      [Yy][Ee][Ss]|[Yy]|'')
        rm -rf $HOME/.mozilla/firefox/{Crash\ Reports,Pending\ Pings} ;;
      [Nn][Oo]|[Nn]) ;;
      *) printf 'Invaild Arg(s)...\n'; exit 1 ;;
    esac
fi

unset input yes force
