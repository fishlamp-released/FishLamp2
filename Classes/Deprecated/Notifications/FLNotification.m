//
//  FLNotification.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLNotification.h"

@implementation FLNotification


@synthesize name = _name;
@synthesize object = _object;
@synthesize userInfo = _userInfo;

+ (id)notificationWithName:(NSString *)aName object:(id)anObject {
    FLNotification* notification = autorelease_([[[self class] alloc] init]);
    notification.name = aName;
    notification.object = anObject;
    return notification;
}

+ (id)notificationWithName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo {
    FLNotification* notification = autorelease_([[[self class] alloc] init]);
    notification.name = aName;
    notification.object = anObject;
    notification.userInfo = aUserInfo;
    return notification;
}

#if FL_MRC
- (void) dealloc {
    mrc_release_(_name);
    mrc_release_(_object);
    mrc_release_(_userInfo);
    super_dealloc_();
}
#endif


@end
