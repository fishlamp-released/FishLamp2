#!/bin/bash

if [ ! -d "/Developer" ]
	then
	mkdir "/Developer"
fi

if [ ! -d "/Developer/FishLamp" ]
	then
	mkdir "/Developer/FishLamp"
fi

cd install
echo "# installing:" 
ls
cp -f * /Developer/FishLamp/
echo "# done"