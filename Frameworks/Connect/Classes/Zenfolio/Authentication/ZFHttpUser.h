//
//  ZFHttpUser.h
//  FishLampConnect
//
//  Created by Mike Fullerton on 3/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpUser.h"
#import "ZFWebApi.h"

#define ZFHttpAuthenticationTimeout ((60 * 60) * 12.0f)

@interface ZFHttpUser : FLHttpUser<NSCopying> {
@private
    ZFUser* _privateProfile;
    ZFUser* _publicProfile;
    ZFGroup* _rootGroup;
}
@property (readwrite, strong) ZFUser* privateProfile;
@property (readwrite, strong) ZFUser* publicProfile;
@property (readwrite, strong) ZFGroup* rootGroup;

@end
