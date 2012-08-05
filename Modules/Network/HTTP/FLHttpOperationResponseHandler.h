//
//	FLHttpOperationBehavior.h
//	FishLampMobileLib
//
//	Created by Mike Fullerton on 11/13/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"
#import "FLHttpOperation.h"
#import "FLHttpConnection.h"

@interface FLHttpOperationResponseHandler : NSObject<FLHttpOperationResponseHandler> {
}

- (void) setOperationOutput:(FLHttpOperation*) operation data:(NSData*) data;

@end
