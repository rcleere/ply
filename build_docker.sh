#!/bin/bash -x

SHORT_COMMIT=$(echo $GIT_COMMIT | awk '{ print substr($1, 0, 10) }')

if [[ ! -z "$SHORT_COMMIT" ]]; then
    tag=$SHORT_COMMIT
elif [[ ! -z "$GIT_BRANCH" ]]; then
    tag=$GIT_BRANCH
else
    tag=$(git status -s -b | head -1 | awk '{print $2}')
fi

echo $tag
docker build -t ply:${tag} -f docker-files/Dockerfile .
