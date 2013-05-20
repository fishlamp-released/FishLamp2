//
//  GtTwitterOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/1/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtHttpOperation.h"
#import "GtTwitterMgr.h"
#import "GtOAuthSignature.h"

@class GtTwitterOperation;

//typedef void (^GtConfigureTwitterOperationCallback)(GtTwitterOperation* operation);

@interface GtTwitterOperation : GtHttpOperation {
@private
	GtOAuthSession* m_session;
}

@property (readwrite, retain, nonatomic) GtOAuthSession* twitterSession;

// optional override points
- (BOOL) willAddParametersToRequestContent:(GtOAuthSignature*) signature;
	// if adding params your self. call [signature addParameter:propName value:theValue]

@end
