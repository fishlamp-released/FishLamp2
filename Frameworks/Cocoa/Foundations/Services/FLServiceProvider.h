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

@class FLSession;

@protocol FLServiceProvider <NSObject>
@property (readonly, assign) id session;
- (void) didMoveToSession:(FLSession*) session;
@optional
- (void) openService:(FLSession*) session;
- (void) closeService:(FLSession*) session;
- (void) requestCancel;
@end

#define FLPublishService(__NAME__, __TYPE__) \
    \
    @protocol __NAME__##PublishedService <NSObject> \
        - (__TYPE__) __NAME__; \
    @end

//#define FLPublishProperty(__TYPE__, __NAME__) \
//    \
//    @protocol __NAME__##PublishedProperty <NSObject> \
//        - (__TYPE__) __NAME__; \
//    @end

