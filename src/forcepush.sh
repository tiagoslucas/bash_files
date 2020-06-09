#!/bin/bash
git add -A
git commit -C HEAD --amend
git push --force-with-lease
git status
