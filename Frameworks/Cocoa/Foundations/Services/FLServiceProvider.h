//
//  FLServiceProvider.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLResult.h"
#import "FLFinisher.h"

@class FLServiceManager;

@protocol FLServiceProvider <NSObject>

@property (readonly, assign) id context;
- (void) didMoveToContext:(id) context;

@optional
- (void) openService:(FLServiceManager*) context;
- (void) closeService:(FLServiceManager*) context;
- (void) requestCancel;
@end

//#define FLPublishService(__NAME__, __TYPE__) \
//    \
//    @protocol __NAME__##PublishedService <NSObject> \
//        - (__TYPE__) __NAME__; \
//    @end

//#define FLPublishProperty(__TYPE__, __NAME__) \
//    \
//    @protocol __NAME__##PublishedProperty <NSObject> \
//        - (__TYPE__) __NAME__; \
//    @end

