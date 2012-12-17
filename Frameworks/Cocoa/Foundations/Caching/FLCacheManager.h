//
//	FLCacheManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/23/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCore.h"

#import "NSNotification+FLExtras.h"

extern NSString* const FLCacheManagerEmptyCacheNotification;

@interface FLCacheManager : NSObject {

}

FLSingletonProperty(FLCacheManager);

- (void) broadcastEmptyCacheMessage:(id<FLCancellable>) operation;

@end
