//
//  GtNetworkOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/9/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtOperation.h"
#import "GtNetworkRequest.h"
#import "GtDatabaseCacheProtocol.h"
#import "GtReachability.h"

typedef enum
{
	GtTransportSecurityDefaultValue,
	GtTransportSecuritySecure,
	GtTransportSecurityNotSecure
} GtTransportSecurityOverride;

@protocol GtNetworkOperationProtocol <NSObject>

@property (readwrite, assign, nonatomic) BOOL canLoadFromCache;
@property (readwrite, assign, nonatomic) BOOL canSaveToCache;
@property (readwrite, assign, nonatomic) BOOL didLoadFromCache;

@property (readwrite, assign, nonatomic) BOOL showNetworkActivityIndicator;
@property (readwrite, assign, nonatomic) BOOL isShowingNetworkActivityIndicator;

@property (readwrite, assign, nonatomic) id<GtDatabaseCacheProtocol> cache;
@property (readwrite, assign, nonatomic) id<GtNetworkRequestProtocol> networkRequest; 

@property (readwrite, assign, nonatomic) GtTransportSecurityOverride transportSecurityOverride;

@property (readwrite, assign, nonatomic) GtReachability* reachability;

- (void) onConvertOperationInputToCacheInput:(id*) outCacheInput;
- (void) onSetOperationOutputWithCacheOutput:(id) cacheOutput;
- (void) onConvertOperationOutputToCachedObject:(id*) outCachedObject;

- (BOOL) preLoadOperationOutputFromCache:(id<GtDatabaseCacheProtocol>) cache;
- (BOOL) loadOperationOutputFromCache:(id<GtDatabaseCacheProtocol>) cache;
- (void) saveOperationOutputToCache:(id<GtDatabaseCacheProtocol>) cache;

@end

@interface GtNetworkOperation : GtOperation<GtNetworkOperationProtocol, GtNetworkRequestDelegate> {
@private	
	id<GtNetworkRequestProtocol> m_request;
	id<GtDatabaseCacheProtocol> m_cache;
	GtReachability* m_reachability;
    
	struct networkFlags {
		unsigned int canSaveToCache:1;
		unsigned int canLoadFromCache:1;
		unsigned int showNetworkActivityIndicator:1;
		unsigned int isShowingNetworkActivityIndicator:1;
		unsigned int didLoadFromCache:1;
		GtTransportSecurityOverride transportSecurityOverride:2;
	} m_networkFlags;
}
@end

@interface GtNetworkOperation (SharedCode)
+ (BOOL) sharedPrepareOperationInMainThread:(id<GtNetworkOperationProtocol, GtOperationProtocol>) operation;
+ (BOOL) sharedWillPerformOperation:(id<GtNetworkOperationProtocol, GtOperationProtocol>) operation;
+ (void) sharedFinalizeOperation:(id<GtNetworkOperationProtocol, GtOperationProtocol>) operation;
+ (void) stopNetworkActivityIndicator:(id<GtNetworkOperationProtocol, GtOperationProtocol>) operation;
+ (BOOL) sharedLoadOperationOutputFromCache:(id<GtDatabaseCacheProtocol>) cache 
	operation:(id<GtNetworkOperationProtocol, GtOperationProtocol>) operation
	isPreLoad:(BOOL) isPreLoad;
+ (void) sharedSaveOperationOutputToCache:(id<GtDatabaseCacheProtocol>) cache 
	operation:(id<GtNetworkOperationProtocol, GtOperationProtocol>) operation;

@end
