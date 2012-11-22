//
//  FLTwitterOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLHttpOperation.h"
#import "FLTwitterMgr.h"
#import "FLOAuthAuthorizationHeader.h"

@class FLTwitterOperation;

//typedef void (^FLConfigureTwitterOperationCallback)(FLTwitterOperation* operation);

@interface FLTwitterOperation : FLHttpOperation {
@private
	FLTwitterMgr* _session;
}

@property (readwrite, retain, nonatomic) FLTwitterMgr* twitterService;

// optional override points
- (BOOL) willAddParametersToRequestContent:(FLOAuthAuthorizationHeader*) signature;
	// if adding params your self. call [signature addParameter:propName value:theValue]

@end
