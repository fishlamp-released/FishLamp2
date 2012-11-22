//
//  FLNotification.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/5/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"


@interface FLNotification : NSNotification {
@private
    NSString* _name;
    id _object;
    NSDictionary* _userInfo;
}

@property (readwrite, strong, nonatomic) NSString* name;
@property (readwrite, strong, nonatomic) id object;
@property (readwrite, strong, nonatomic) NSDictionary* userInfo;

+ (id)notificationWithName:(NSString *)aName object:(id)anObject;
+ (id)notificationWithName:(NSString *)aName object:(id)anObject userInfo:(NSDictionary *)aUserInfo;

@end
