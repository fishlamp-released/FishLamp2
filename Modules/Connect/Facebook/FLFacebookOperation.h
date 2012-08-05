//
//  FLFacebookOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/14/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLHttpOperation.h"
#import "FLFacebookMgr.h"

@class FLFacebookOperation;

@interface FLFacebookOperation : FLHttpOperation {
@private
	NSString* m_userId;
	NSString* m_object;
}

+ (id) facebookOperation;

@property (readwrite, retain, nonatomic) NSString* userId;
@property (readwrite, retain, nonatomic) NSString* object;

// override points
- (void) addParametersToURLString:(NSMutableString*) url;
- (BOOL) willAddParametersToURL;

@end


