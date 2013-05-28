//
//	FLCacheManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 1/23/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "NSNotification+FLExtras.h"

extern NSString* const FLCacheManagerEmptyCacheNotification;

@interface FLCacheManager : NSObject {

}

FLSingletonProperty(FLCacheManager);

- (void) broadcastEmptyCacheMessage:(id) operation;

@end
