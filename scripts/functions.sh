#!/usr/bin/env bash
set -euo pipefail

# check login
check_oc_login(){
  oc cluster-info | head -n1
  oc whoami || exit 1
  echo
}

get_git_basename(){
  local repo_url
  repo_url="$(git remote get-url origin | sed -E 's#(git@|https://)github.com:(.*)\.git#https://github.com/\2#')"
  echo "${repo_url}"
}
