param(
    [string]$comment="add comment"
)
git add -v *
git commit -m $comment
git push -u origin master
