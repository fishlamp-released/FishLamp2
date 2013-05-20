//
//  GtGlobalNetworkActivityIndicator.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@protocol GtGlobalNetworkActivityIndicator <NSObject>
- (void) showNetworkActivityIndicator;
- (void) hideNetworkActivityIndicator;
@end

@interface GtGlobalNetworkActivityIndicator : NSObject {
}

+ (void) setGlobalNetworkActivityIndicator:(id<GtGlobalNetworkActivityIndicator>) indicator;
+ (id<GtGlobalNetworkActivityIndicator>) globalNetworkActivityIndicator;

@end