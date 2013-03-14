//
//  FLSelector.h
//  FishLampCore
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLSelector : NSObject<NSCopying> {
@private
    SEL _selector;
    int _argumentCount;
    NSString* _selectorString;
}

@property (readonly, nonatomic) SEL selector;
@property (readonly, assign) int argumentCount;
@property (readonly, assign) NSString* selectorString;

- (id) initWithSelector:(SEL) selector;
- (id) initWithSelector:(SEL) selector argCount:(NSUInteger) argCount;
+ (id) selector:(SEL) selector;
+ (id) selector:(SEL) selector argCount:(NSUInteger) argCount;

@end