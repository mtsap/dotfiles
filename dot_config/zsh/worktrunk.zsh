wt_rebase() {
  local current_branch default_branch
  current_branch=$(git branch --show-current) || return 1
  default_branch=$(wt config state default-branch) || return 1

  if [ "$current_branch" = "$default_branch" ]; then
    echo "Already on trunk: $default_branch"
    git pull --ff-only origin "$default_branch"
    return $?
  fi

  wt switch ^
  git pull --ff-only origin "$default_branch" || return 1
  wt switch "$current_branch" || return 1
  wt step rebase
}
