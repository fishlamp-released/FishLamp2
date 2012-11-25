//
//  FLMutableNotification.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/17/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLMutableNotification : NSNotification {
@private
    NSString* _name;
    id _object;
    NSDictionary* _userInfo;
}

@property (readwrite, strong, nonatomic) NSString* name;
@property (readwrite, strong, nonatomic) id object;
@property (readwrite, strong, nonatomic) NSDictionary* userInfo;

@end
