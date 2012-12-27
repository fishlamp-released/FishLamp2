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
@property (readonly, assign) FLSession* session;
- (void) didMoveToSession:(FLSession*) session;

@optional
- (void) openService:(FLSession*) session;
- (void) closeService:(FLSession*) session;
- (void) requestCancel;
@end