//
//	FLErrorDescriber.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/22/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLErrorDescription.h"
#import "FLActionDescription.h"

@protocol FLErrorDescriber <NSObject>

- (BOOL) willDescribeError:(NSError*) error;

- (NSString*) describeError:(NSError*) error;

- (NSString*) domain;

@end

@interface FLErrorDescriberManager : NSObject {
@private
	NSMutableArray* _describers;
}
FLSingletonProperty(FLErrorDescriberManager);

- (void) addErrorDescriber:(id<FLErrorDescriber>) handler;

//- (id<FLErrorDescriber>) describerForError:(NSError*) error;

//- (void) updateDescriptionInErrorDescription:(id<FLErrorDescription>) description;
//
//- (void) updateErrorDescription:(id<FLErrorDescription>) description
//				actionDescription:(FLActionDescription*) descriptionOrNil;


- (NSString*) describeError:(NSError*) error;

//- (NSString*) describeErrorWithDescribers:(NSError*) error;

@end