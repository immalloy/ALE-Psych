@echo off
echo Updating repository on branch main
git checkout main
git fetch origin
git pull origin main

echo.
echo Latest commits
git log --oneline -n 10

echo.
echo Files changed in the last pull
git diff HEAD@{1} HEAD --name-status

echo.
pause
