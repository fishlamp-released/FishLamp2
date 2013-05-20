//
//  GtFacebookOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/14/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtHttpOperation.h"
#import "GtFacebookMgr.h"

@class GtFacebookOperation;

@interface GtFacebookOperation : GtHttpOperation {
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


