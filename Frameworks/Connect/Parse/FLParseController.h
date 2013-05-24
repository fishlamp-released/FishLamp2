//
//  FLParseController.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 5/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLamp.h"
#import "FLDispatch.h"

@class PFObject;
@class FLParseClassLink;
@class FLUserLogin;

@interface FLParseController : NSObject

FLSingletonProperty(FLParseController);

- (void) deleteAllObjectsOfClass:(Class) aClass;
- (void) deleteObjectWithClassLink:(FLParseClassLink*) classLink;
- (void) deleteObjectWithClass:(Class) aClass withObjectId:(NSString*) objectId;

- (FLParseClassLink*) saveObject:(id) object;

- (id) readObject:(FLParseClassLink*) object;

- (void) setApplicationId:(NSString*) appID clientKey:(NSString*) clientKey;

- (FLPromise*) beginLoggingInUser:(FLUserLogin*) userLogin 
                       completion:(fl_completion_block_t) completion;

- (BOOL) isAuthenticated;

@end
