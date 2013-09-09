
cd Pieces
files=`ls`
for file in $files; do
    name=`basename "$file"`

    cd "$file"
    echo "# `pwd`"

    git remote rm origin 
    git remote add origin https://github.com/fishlamp/$name.git
    git config user.email "mike@greentongue.com"

#     git remote show origin
    git config user.email
    git config remote.origin.url

    branch=`git branch`

    
    
#     if [ "$branch" == "develop" ]; then
#         git fetch --all
#         check=`git branch -a`
#         
#         if [ "$branch" == "*master*" ]; then
#             
#         fi
#     fi
    
    cd ..

#     diff "$name"
done


git config --global push.default current