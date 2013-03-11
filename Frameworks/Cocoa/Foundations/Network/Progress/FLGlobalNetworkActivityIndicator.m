//
//  FLGlobalNetworkActivityIndicator.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGlobalNetworkActivityIndicator.h"

NSString* const FLGlobalNetworkActivityShow = @"FLGlobalNetworkActivityShow";
NSString* const FLGlobalNetworkActivityHide = @"FLGlobalNetworkActivityHide";

@interface FLGlobalNetworkActivityIndicator()
@property (readwrite, assign) NSInteger busyCount;
@end

#define kPostDelay 1.0f

@implementation FLGlobalNetworkActivityIndicator

@synthesize busyCount = _busyCount;

FLSynthesizeSingleton(FLGlobalNetworkActivityIndicator);

- (BOOL) isNetworkBusy {
    return self.busyCount > 0;
}

- (void) postShowMessage {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if(!_showing) {
        FLLog(@"posting show");
        [[NSNotificationCenter defaultCenter] postNotificationName:FLGlobalNetworkActivityShow object:self];
        _showing = YES;
    }
}

- (void) delayedHidePost {
    FLLog(@"posting hide");
    [[NSNotificationCenter defaultCenter] postNotificationName:FLGlobalNetworkActivityHide object:self];
}

- (void) postHideMessage {
    
    if(_showing) {
        [self performSelector:@selector(delayedHidePost) withObject:nil afterDelay:kPostDelay];
        _showing = NO;
    }
}

- (void) setNetworkBusy:(BOOL) busy {
    dispatch_async(dispatch_get_main_queue(), ^{
        if(busy) {
            if(_busyCount++ == 0) {
                [self postShowMessage];
            }
        }
        else {
            if(--_busyCount == 0) {
                [self postHideMessage];
            }
        }
    });
}

@end