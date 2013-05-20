//
//  GtHttpOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/13/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtOperation.h"
#import "GtWebRequest.h"
#import "GtWebRequestSecurityHandler.h"
#import "GtNetworkOperation.h"

// This is a base class for a Http. This represents a specific
// call to the webservice. Think of this as a c function calls
// where input are the parameters, and output is the return value.

@interface GtHttpOperation : GtNetworkOperation {
}

@property (readonly, assign, nonatomic) id<GtWebRequestProtocol> webRequest;

- (void) createHttpRequest:(id<GtWebRequestProtocol>*) outRequest;

+ (void) setSecurityHandler:(GtWebRequestSecurityHandler*) handler;

@end



