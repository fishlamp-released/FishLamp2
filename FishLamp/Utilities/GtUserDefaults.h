//
//  GtUserDefaults.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GtUserLogin.h"

extern NSString* GtUserLoginErrorDomain;

enum 
{
    GtUserLoginErrorUserNotFound        = -1000,
    GtUserLoginErrorGuidNotFound        = -1001,
    GtUserLoginErrorPasswordNotFound    = -1002
};

@interface GtUserDefaults : UITableViewCell {
}

+ (BOOL) userExists:(GtUserLogin*) login;
+ (BOOL) loadUserLogin:(GtUserLogin*) login outError:(NSError**) errorOrNil;
+ (BOOL) saveUserLogin:(GtUserLogin*) login outError:(NSError**) errorOrNil;

@end

@interface GtUserLogin (More)
- (void) addGuid;
@end
