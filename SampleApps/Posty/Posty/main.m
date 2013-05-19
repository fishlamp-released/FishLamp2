//
//  main.m
//  Posty
//
//  Created by Mike Fullerton on 11/19/12 
//  Built with FishLamp. More info and help at http://fishlamp.com
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//  


#import "FLCommandLineTool.h"
#import "FLPosty.h"

		
int main(int argc, const char * argv[]) {
	return FLCommandLineToolMain(argc, argv, [FLPosty class], @"FLPosty");
}	
		
