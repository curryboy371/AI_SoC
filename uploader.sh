#!/bin/bash

# .env 로드
source .env


# 환경변수
echo "REMOTE_NAME: $REMOTE_NAME"
echo "GITHUB_USERNAME: $GITHUB_USERNAME"
echo "Repo Name: $REPO_NAME"
echo "BRANCH_NAME: $BRANCH_NAME"


echo "start git uploader"

url="git@github.com"

giturl="${REMOTE_NAME} $url:${GITHUB_USERNAME}/${REPO_NAME}.git"
echo "${giturl}"

git remote remove ${REMOTE_NAME}
PID=$!
wait $PID

if [ $? -eq 0 ]; then
  echo "remove finish"
fi

git remote add ${giturl}
PID=$!
wait $PID

if [ $? -eq 0 ]; then
  echo "add url finish"
else
   exit 1
fi

git pull origin main
PID=$!
wait $PID

git add .
PID=$!
wait $PID
if [ $? -eq 0 ]; then
  echo "finish add"
else
   exit 1
fi


git commit -m $1

PID=$!
wait $PID
if [ $? -eq 0 ]; then
  echo "finish commit"
else
   exit 1
fi

git push -u origin main

PID=$!
wait $PID

if [ $? -eq 0 ]; then
  echo "finish push"
else
   exit 1
fi

echo "finish git uploader"
