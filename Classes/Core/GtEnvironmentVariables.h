//
//	GtEnvironmentVariables.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

extern BOOL GtTestBoolEnvironmentVariable(NSString* name);
extern void GtSetBoolEnvironmentVariable(NSString* name, BOOL value);
extern void GtSetEnvironmentVariable(NSString* name, NSString* value);
extern int GtGetEnvironmentVariableInteger(NSString* name);
