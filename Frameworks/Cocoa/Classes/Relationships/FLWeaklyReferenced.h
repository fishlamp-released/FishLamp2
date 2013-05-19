//
//  FLWeaklyReferenced.h
//  FLCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSelectorPerforming.h"
#import "FLDeallocNotifier.h"

/**
    see comment in FLWeakReference.h
 */


@protocol FLWeaklyReferenced <NSObject>
- (BOOL) willSendDeallocNotification;
// you MUST call FLSendDeallocNotification() in dealloc for NON-ARC builds for weakly reference objects.
//
@end

#define FLSendDeallocNotification() [self sendDeallocNotification]; 