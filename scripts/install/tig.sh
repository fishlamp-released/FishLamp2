#!/bin/bash

count=0
path=$(basename `pwd`)
# echo "# starting in $path"

git_cmd=$@

if [ "$git_cmd" == "" ]
	then
	git --help
	exit 0
fi

# echo "$git_cmd"

find_repos () { 
	count=$[$count+1]
	dir="$1"
	
	local oldpath="$path"
		
    for item in `ls -a`
    do
		if [ -d "$item" ] 
			then

			bn=$(basename $item)
			
			if [[ $bn != .* ]]
			then
				path="$oldpath/$bn"
			
			    cd "$item"
				find_repos "$item" 
				cd ..
				
				path="$oldpath"
			fi
			
		fi
    done

	found=0
		
	if [ -d ".git" ]
		then
		found=1
		echo ""
		echo "-- Entering Repo: $path"
		git $git_cmd
		echo "-- Exiting Repo: $path"
	fi

	if [ -f ".git" ]
		then
		echo ""
		echo "-- Entering Submodule: $path"
		git $git_cmd
		echo "-- Exiting Submodule: $path"
	fi
    
}

find_repos .

echo ""
echo "# searched $count directories"