//
//  FLVersionUpgradeLengthyTaskList.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/4/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"
#import "FLSynchronousOperation.h"

@interface FLVersionUpgradeLengthyTaskList : FLSynchronousOperation {
@private 
	NSString* _fromVersion;
	NSString* _toVersion;
}

@property (readonly, retain, nonatomic) NSString* fromVersion;
@property (readonly, retain, nonatomic) NSString* toVersion;

- (id) initWithFromVersion:(NSString*) fromVersion 
                 toVersion:(NSString*) toVersion;
@end