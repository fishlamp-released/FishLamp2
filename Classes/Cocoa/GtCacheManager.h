//
//	GtCacheManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/23/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "NSNotification+GtExtras.h"

extern NSString* const GtUserSessionEmptyCacheNotification;

@interface GtCacheManager : NSObject {

}

GtSingletonProperty(GtCacheManager);

- (void) broadcastEmptyCacheMessage:(id<GtCancellableOperation>) operation;

@end
