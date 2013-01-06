//
//	FLCachedObjectOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/27/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"
#import "FLResult.h"
#import "FLDatabase.h"
#import "FLOperation.h"

@protocol FLCacheObjectOperationSubclass <NSObject>
- (id) loadObjectFromDatabase;
- (void) saveObjectToDatabase:(id) object;
- (FLResult) runSubOperations;
@end

@interface FLCachedObjectOperation : FLOperation {
@private
	BOOL _canLoadFromCache;
	BOOL _canSaveToCache;
    BOOL _wasLoadedFromCache;
    BOOL _alwaysRunSubOperations;
}

// options
@property (readwrite, assign) BOOL canSaveToCache; // YES by default
@property (readwrite, assign) BOOL canLoadFromCache; // YES by default
@property (readwrite, assign) BOOL alwaysRunSubOperations; // NO by default

// info
@property (readonly, assign) BOOL wasLoadedFromCache;

@end

@protocol FLCachedObjectOperationObserver <NSObject>
- (void) cachedObjectOperation:(FLCachedObjectOperation*) operation didLoadObjectFromDatabase:(id) object;
@end

