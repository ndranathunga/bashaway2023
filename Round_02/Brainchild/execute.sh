#!/bin/bash

# Add the git alias to clone all repositories of a GitHub organization
setup_git_alias() {
    git config --global alias.clone-gh-org '!f() {         repos=$(curl -s "https://api.github.com/orgs/$1/repos?per_page=100" | grep -Eo "\"clone_url\": \"[^\"]+\"" | cut -d "\"" -f 4);         for repo in $repos; do             git clone $repo $("${2:2}")/$(basename $repo .git);         done;     }; f'
}

setup_git_alias