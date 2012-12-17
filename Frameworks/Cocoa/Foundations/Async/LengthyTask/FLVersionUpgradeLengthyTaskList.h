//
//  FLVersionUpgradeLengthyTaskList.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/4/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCore.h"
#import "FLAction.h"

@interface FLVersionUpgradeLengthyTaskList : FLAction {
@private 
	NSString* _fromVersion;
	NSString* _toVersion;
}

@property (readonly, retain, nonatomic) NSString* fromVersion;
@property (readonly, retain, nonatomic) NSString* toVersion;

- (id) initWithFromVersion:(NSString*) fromVersion 
                 toVersion:(NSString*) toVersion;
@end