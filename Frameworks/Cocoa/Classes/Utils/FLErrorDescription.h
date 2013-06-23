//
//	FLErrorDescription.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/22/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

@protocol FLErrorDescription <NSObject>
@property (readwrite, retain, nonatomic) NSString* title;
@property (readwrite, retain, nonatomic) NSString* description;
@property (readwrite, retain, nonatomic) NSError* error;
@end

@interface FLErrorDescription : NSObject<FLErrorDescription> {
@private
	NSError* _error;
	NSString* _title;
	NSString* _description;
}
- (id) initWithTitle:(NSString*) title description:(NSString*) description;
+ (FLErrorDescription*) errorDescription;
+ (FLErrorDescription*) errorDescriptionWithTitle:(NSString*) title description:(NSString*) description;
@end