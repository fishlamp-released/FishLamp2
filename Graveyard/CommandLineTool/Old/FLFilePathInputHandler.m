//
//  FLFilePathInputHandler.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/13/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if 0

#import "FLFilePathInputHandler.h"
#import "NSFileManager+FLExtras.h"

@implementation FLFilePathInputHandler

- (FLArgumentFlagMask) defaultFlags {
    return FLArgumentIsExpectingData;
}

- (void) prepare:(NSString*) input {

    
    
    if( self.flags.itemMustAlreadyExist &&
        ![[NSFileManager defaultManager] fileExistsAtPath:input]) {
        FLThrowErrorCode_v(NSCocoaErrorDomain, NSFileNoSuchFileError, @"path does not exist: \"%@\"", input);
    }
    
    [super prepare:input];
}

@end

#endif