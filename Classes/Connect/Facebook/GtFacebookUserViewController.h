//
//  GtFacebookUserViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtEditObjectViewController.h"
#import "GtFacebookUser.h"

@interface GtFacebookUserViewController : GtEditObjectViewController {
@private
	NSString* m_userId;
	GtFacebookUser* m_user;
}

- (id) initWithUserId:(NSString*) userId;

@end
