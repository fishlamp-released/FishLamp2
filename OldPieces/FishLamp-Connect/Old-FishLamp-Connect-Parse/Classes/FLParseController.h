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
@class FLParseCredentials;

@interface FLParseController : NSObject {
@private
    FLParseCredentials* _credentials;
}

FLSingletonProperty(FLParseController);

- (void) deleteAllObjectsOfClass:(Class) aClass;
- (void) deleteObjectWithClassLink:(FLParseClassLink*) classLink;
- (void) deleteObjectWithClass:(Class) aClass withObjectId:(NSString*) objectId;

- (FLParseClassLink*) saveObject:(id) object;

- (id) readObject:(FLParseClassLink*) object;

- (FLPromise*) openParseController:(FLParseCredentials*) credentials
                        completion:(fl_completion_block_t) completion;

- (FLPromise*) beginLoggingInUser:(FLUserLogin*) userLogin 
                       completion:(fl_completion_block_t) completion;

- (BOOL) isAuthenticated;

@end
