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
    id _outputObject;
    id _inputObject;
}

@property (readwrite, strong) id inputObject;
@property (readwrite, strong) id outputObject;

@property (readwrite, strong) NSString* object;

// override points
- (void) addParametersToURLString:(NSMutableString*) url;
- (BOOL) willAddParametersToURL;

@end


