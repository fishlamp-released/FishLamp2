//
//  FLFacebookUserViewController.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
