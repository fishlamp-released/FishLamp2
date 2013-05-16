//
//  GtWsdlSecurityHandler.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/26/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtWebRequest.h"
#import "GtOperation.h"

@interface GtWebRequestSecurityHandler : NSObject {

}

- (void) onAddSecurityToRequest:(id<GtWebRequestProtocol>) request 
					  operation:(id<GtOperationProtocol>) operation;

@end
