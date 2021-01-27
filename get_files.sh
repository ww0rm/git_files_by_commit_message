#!/bin/bash

# Load all commits by message
git log --all --grep "$1" | grep 'commit' > _commits.txt
sed -r 's/(commit )//' _commits.txt > commits.txt

# Remove temp file and create file for files
rm _commits.txt
touch _files.txt

# Get files from each commit
while read -r commit; do
  git diff-tree --no-commit-id --name-only -r "$commit" >> _files.txt
done < commits.txt

# Remove duplicates
awk '!x[$0]++' _files.txt > files.txt

# Sort and print list of files
printf "\n"
sort files.txt
printf "\n"

# Remove files
rm _files.txt
rm files.txt


