
function addbranch() {
    
}

cd Pieces
files=`ls`
for file in $files; do
    name=`basename "$file"`

    cd "$file"
    echo "# `pwd`"

    git fetch --all
    allbranches=`git branch -a`
    branch=`git branch`

    echo "branch = $branch"

    if [[ "$branch" == "*develop" ]]; then
        
        if [ "$allbranches" == "*master*" ]; then
            echo "found master"
        else
            echo "master not found"            
        fi
    else
        echo "already on master"
    fi

    
    
    
    cd ..

#     diff "$name"
done


git config --global push.default current

