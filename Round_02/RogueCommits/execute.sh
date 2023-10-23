
rm -rf src

git clone https://github.com/sliit-foss/bashaway-ui.git src

cd src

# Use git filter-branch to rewrite commit history
git filter-branch --env-filter '
OLD_EMAIL="github-actions[bot]"
CORRECT_NAME="github-actions"
CORRECT_EMAIL="noreply@github.com"
if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags

# Confirm that the changes have been made
git log --pretty=format:"%an %ae" | grep "github-actions"
