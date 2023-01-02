#!/usr/bin/env bash
set -eou pipefail

gh_pages_uri=${gh_pages_uri:-https://paulojeronimo.com}

cd "$(dirname "$0")"

[ -d build ] || {
  echo Directory build does not exists!
  exit 1
}

repo=$(git remote get-url --push origin)
! [[ $repo =~ ^https://github.com/ ]] || repo=${repo#https://github.com/}
! [[ $repo =~ ^git@github.com: ]] || repo=${repo#git@github.com:}
! [[ $repo =~ -private$ ]] || repo=${repo%-private}
! [[ $repo =~ -tutorial.git$ ]] || repo=${repo%-tutorial.git}
! [[ $repo =~ -tutorial$ ]] || repo=${repo%-tutorial}

# commented to not force the user to get gh installed:
# gh repo create $repo --public

bin=$(pnpm bin 2> /dev/null) || bin=$(npm bin 2> /dev/null) || {
  echo Fail on get bin directory with pnpm or npm!
  exit 1
}

gh_pages=$bin/gh-pages
[ -x $gh_pages ] || {
  echo The file \"$gh_pages\" can not be executed!
  exit 1
}

touch build/.nojekyll

cat <<EOF>build/README.adoc
$gh_pages_uri/${repo##*/}
EOF

$gh_pages -d build -t true -r git@github.com:$repo
