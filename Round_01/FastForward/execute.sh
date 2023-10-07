#!/bin/bash

# Remove the existing 'src' directory if it exists
rm -rf src

# Clone the repository
git clone https://github.com/sliit-foss/npm-catalogue.git src

# Navigate to the cloned repository
cd src

# Check the current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Check if the current branch is 'main'
if [ "$current_branch" != "main" ]; then
  # Switch to the 'main' branch
  git checkout main
  echo "Switched to the 'main' branch."
else
  echo "The repository is already on the 'main' branch."
fi

# Define the time offset (13 days in seconds)
offset=$((60 * 60 * 24 * 13))

# Use git filter-branch to adjust commit timestamps
git filter-branch --env-filter \
  'if [ "$GIT_COMMIT" ]; then
     commit_date=$(git show -s --format=%ci "$GIT_COMMIT")
     new_date=$(date -d "$commit_date + '"$offset"' seconds" --iso-8601=seconds)
     export GIT_COMMITTER_DATE="$new_date"
     export GIT_AUTHOR_DATE="$new_date"
   fi'

# Force push the rewritten history to the current branch
# git push --force
