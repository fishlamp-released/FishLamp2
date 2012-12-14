//
//  FLCallback.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCallback.h"

@interface FLCallback()
@property (readwrite, strong, nonatomic) id target;
@property (readwrite, assign, nonatomic) SEL action;
@property (readwrite, copy, nonatomic) FLCallbackBlock callbackBlock;
@end

@implementation FLCallback

@synthesize target = _target;
@synthesize action = _action;
@synthesize callbackBlock = _block;

- (id) initWithTarget:(id) target action:(SEL) action {
    self = [super init];
    if(self) {
        self.target = target;
        self.action = action;
    }

    return self;
}

- (id) initWithBlock:(FLCallbackBlock) block {
    self = [super init];
    if(self) {
        self.callbackBlock = block;
    }
    
    return self;
}

+ (id) callbackWithTarget:(id) target action:(SEL) action {
    return FLAutorelease([[FLCallback alloc] initWithTarget:target action:action]);
}

+ (id) callbackWithBlock:(FLCallbackBlock) block {
    return FLAutorelease([[FLCallback alloc] initWithBlock:block]);
}


#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"

- (void) invoke:(id) sender {
    
    if(_target && _action) {
        [_target performSelector:_action withObject:sender];
    }
    
    if(_block) {
        _block(sender);
    }

}

#if FL_MRC
- (void) dealloc {
    [_block release];
    [_target release];
    [super dealloc];
}
#endif

#pragma clang diagnostic pop


@end
