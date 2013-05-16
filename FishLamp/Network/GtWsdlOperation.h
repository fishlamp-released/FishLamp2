//
//  GtWsdlOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/13/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GtObject.h"
#import "GtOperation.h"
#import "GtSoapRequest.h"

#import "GtDatabaseCacheProtocol.h"
#import "GtNetworkOperation.h"

// This is a base class for a WSDL. This represents a specific
// call to the webservice. Think of this as a c function calls
// where input are the parameters, and output is the return value.

@interface GtWsdlOperation : GtObject<GtOperationProtocol, GtNetworkOperationProtocol, GtNetworkRequestDelegate> {
@private	
	id m_userData;
	NSError* m_error;
	id<GtDatabaseCacheProtocol> m_cache;
	GtSoapRequest* m_request; 
	GtSimpleCallback* m_prepareCallback;
	GtSimpleCallback* m_completedCallback;
    GtReachability* m_reachability;

	id m_delegate;
	id m_previousOperation;
	int m_id;
	NSUInteger m_performCount;
	
	struct {
		unsigned int wasPerformed:1;
		unsigned int shouldPerform:1;
		unsigned int cancel:1;
		unsigned int canSaveToCache:1;
		unsigned int canLoadFromCache:1;
		unsigned int showNetworkActivityIndicator:1;
		unsigned int isShowingNetworkActivityIndicator:1;
		unsigned int didLoadFromCache;
		unsigned int transportSecurityOverride:2;
	} m_wsdlFlags;
}
- (id) input;
- (void) setInput:(id) input;

- (id) output;
- (void) setOutput:(id) output;


// name of operation. This is usually set by the subclass
@property (readonly, assign, nonatomic ) NSString* operationName;

@property (readwrite, assign, nonatomic) BOOL canLoadFromCache;
@property (readwrite, assign, nonatomic) BOOL canSaveToCache;
@property (readwrite, assign, nonatomic) BOOL didLoadFromCache;

@property (readwrite, assign, nonatomic) id<GtDatabaseCacheProtocol> cache;

@property (readwrite, assign, nonatomic) id<GtNetworkRequestProtocol> networkRequest; 
@property (readwrite, assign, nonatomic) GtTransportSecurityOverride transportSecurityOverride;

@end

