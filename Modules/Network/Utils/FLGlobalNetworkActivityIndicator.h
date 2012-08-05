//
//  FLGlobalNetworkActivityIndicator.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

@protocol FLGlobalNetworkActivityIndicator <NSObject>
- (void) showNetworkActivityIndicator:(id) startedBy;
- (void) hideNetworkActivityIndicator:(id) stoppedBy;
@property (readonly, assign, nonatomic) BOOL isVisible;
@end

@interface FLGlobalNetworkActivityIndicator : NSObject {
}

+ (void) setInstance:(id<FLGlobalNetworkActivityIndicator>) indicator;
+ (id<FLGlobalNetworkActivityIndicator>) instance;

@end