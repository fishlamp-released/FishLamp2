//
//  FLWeaklyReferenced.h
//  FLCore
//
//  Created by Mike Fullerton on 11/4/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
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