//
//  FLHttpUserContext.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLServiceManager.h"
#import "FLHttpRequest.h"
#import "FLOperation.h"
#import "FLDispatchQueue.h"
#import "FLHttpRequestAuthenticator.h"
#import "FLDispatchedObjectCollection.h"

@interface FLHttpUserContext : FLServiceManager<FLHttpRequestDispatchingContext, FLOperationDispatchingContext> {
@private
    FLHttpRequestAuthenticator* _httpRequestAuthenticator;
    FLFifoDispatchQueue* _httpRequestQueue;
    FLDispatchedObjectCollection* _objects;
}
@property (readwrite, strong) FLUserLogin* userLogin;
@property (readonly, assign) BOOL isContextAuthenticated;

@property (readwrite, strong) FLHttpRequestAuthenticator* httpRequestAuthenticator;
- (void) requestCancel;

- (void) logoutUser;

@end
