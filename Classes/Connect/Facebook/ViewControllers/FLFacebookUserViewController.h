//
//  FLFacebookUserViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLEditObjectViewController.h"
#import "FLFacebookUser.h"

@interface FLFacebookUserViewController : FLEditObjectViewController {
@private
	NSString* _userId;
	FLFacebookUser* _user;
}

- (id) initWithUserId:(NSString*) userId;

@end
