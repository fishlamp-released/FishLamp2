//
//	GtErrorDescriber.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/22/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtErrorDescription.h"
#import "GtActionDescription.h"

@protocol GtErrorDescriber <NSObject>

- (BOOL) willDescribeError:(NSError*) error;

- (NSString*) describeError:(NSError*) error;

- (NSString*) domain;

@end

@interface GtErrorDescriberManager : NSObject {
@private
	NSMutableArray* m_describers;
}
GtSingletonProperty(GtErrorDescriberManager);

- (void) addErrorDescriber:(id<GtErrorDescriber>) handler;

//- (id<GtErrorDescriber>) describerForError:(NSError*) error;

//- (void) updateDescriptionInErrorDescription:(id<GtErrorDescription>) description;
//
//- (void) updateErrorDescription:(id<GtErrorDescription>) description
//				actionDescription:(GtActionDescription*) descriptionOrNil;


- (NSString*) describeError:(NSError*) error;

//- (NSString*) describeErrorWithDescribers:(NSError*) error;

@end