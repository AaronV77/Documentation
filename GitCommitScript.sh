
#!/bin/bash

read -p "Repository local destionation on computer: " repoPath
read -p "Commit message: " commitMessage
read -p "GitHub Repo. URL: " repoURL

cd repoPath
git add --all
git commit -am "$commitMessage"
git remote add origin $repoURL
git push origin master
