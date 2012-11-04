//
//  FLFacebookOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/14/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLHttpOperation.h"

@class FLFacebookMgr;

@interface FLFacebookOperation : FLHttpOperation {
@private
	NSString* _object;
    FLFacebookMgr* _facebookService;
}

@property (readonly, strong) FLFacebookMgr* facebookService;

- (id) initWithFacebookService:(FLFacebookMgr*) facebookService;

+ (id) facebookOperation:(FLFacebookMgr*) facebookService;

@property (readwrite, strong) NSString* userId;
@property (readwrite, strong) NSString* object;

// override points
- (void) addParametersToURLString:(NSMutableString*) url;
- (BOOL) willAddParametersToURL;

@end


