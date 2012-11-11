#!/bin/bash

if [ ! -d "/Developer" ]
	then
	mkdir "/Developer"
fi

if [ ! -d "/Developer/FishLamp" ]
	then
	mkdir "/Developer/FishLamp"
fi

function createLinks() {

	# echo "#!/bin/bash" >> "$uninstallfile"

	FILES=`ls`
	for i in $FILES; 
		do
		fullName="$i"
		extension=${fullName##*.}
		
		if [ "$extension" == "$fullName" -o "$extension" == "sh" ]
		then
			file=`basename "$fullName" .sh`
			srcfile="$fullName"
			
			echo "$file -> $srcfile"
			
			ln -f "/Developer/FishLamp/$srcfile" "/Developer/FishLamp/$file"
			# echo "updated link/Developer/FishLamp/$file to /Developer/FishLamp/$srcfile"
#		else
#			echo "ignored $fullName"
		fi
	done
}

function updateBashProfile() {
	# clear out everthing between ## START and ## END in profile file
	# the deelete-this is to actually remove the lines instead of addding a bunch
	# of empty lines
	sed -i -e '/## FISHLAMP-START/,/## FISHLAMP-END/ s/.*/delete-this/' "~/.bash_profile" 
	sed -i -e '/delete-this/d' "~/.bash_profile" 

	echo '## FISHLAMP-START' >> ~/.bash_profile
	echo "# written by fishlamp/scripts/install.sh on `date`" >> ~/.bash_profile
	echo 'PATH="$PATH:/Developer/FishLamp:"' >> ~/.bash_profile 
	echo 'export PATH' >> ~/.bash_profile 
	echo 'echo "We have lift off."' >> ~/.bash_profile
	echo '## FISHLAMP-END' >> ~/.bash_profile
	
	cat ~/.bash_profile
}

cd install
chmod +x *

echo "# installing:" 
ls
cp -f * /Developer/FishLamp/
createLinks
echo "??"
updateBashProfile

echo "# done"