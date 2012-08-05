//
//	FLCacheManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/23/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

#import "NSNotification+FLExtras.h"

extern NSString* const FLUserSessionEmptyCacheNotification;

@interface FLCacheManager : NSObject {

}

FLSingletonProperty(FLCacheManager);

- (void) broadcastEmptyCacheMessage:(id<FLCancellableOperation>) operation;

@end
