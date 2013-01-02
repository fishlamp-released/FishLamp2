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
    return FLAutorelease([[[self class] alloc] initWithTarget:target action:action]);
}

+ (id) callbackWithBlock:(FLCallbackBlock) block {
    return FLAutorelease([[[self class] alloc] initWithBlock:block]);
}

- (void) perform {
    FLPerformSelector(_target, _action);
    
    if(_block) {
        _block(nil);
    }
}

- (void) performWithObject:(id) object {
    
    FLPerformSelector1(_target, _action, object);
    if(_block) {
        _block([FLArgumentList argumentList:object]);
    }
}

- (void) performWithObject:(id) object1 withObject:(id) object2 {
    FLPerformSelector2(_target, _action, object1, object2);
    if(_block) {
        _block([FLArgumentList argumentList:object1 withObject:object2]);
    }
}

- (void) performWithObject:(id) object1 withObject:(id) object2 withObject:(id) object3 {
    FLPerformSelector3(_target, _action, object1, object2, object3);
    if(_block) {
        _block([FLArgumentList argumentList:object1 withObject:object2 withObject:object3]);
    }
}

#if FL_MRC
- (void) dealloc {
    [_block release];
    [_target release];
    [super dealloc];
}
#endif

@end

@interface FLStashedCallback ()
@property (readwrite, strong, nonatomic) FLArgumentList* arguments;
@end

@implementation FLStashedCallback 

@synthesize arguments = _arguments;

- (id) initWithTarget:(id) target action:(SEL) action arguments:(FLArgumentList*) arguments {
    self = [super initWithTarget:target action:action];
    if(self) {
        self.arguments = arguments;
    }
    return self;
}

- (id) initWithBlock:(FLCallbackBlock) block arguments:(FLArgumentList*) arguments {
    self = [super initWithBlock:block];
    if(self) {
        self.arguments = arguments;
    }
    return self;
}

+ (id) callbackWithTarget:(id) target action:(SEL) action arguments:(FLArgumentList*) arguments {
    return FLAutorelease([[[self class] alloc] initWithTarget:target action:action arguments:arguments]);
}

+ (id) callbackWithBlock:(FLCallbackBlock) block arguments:(FLArgumentList*) arguments {
    return FLAutorelease([[[self class] alloc] initWithBlock:block arguments:arguments]);
}

- (void) startWorking:(FLFinisher*) finisher {
    switch(_arguments.count) {
        case 0:
            [self perform];
            break;
        
        case 1:
            [self performWithObject:[_arguments argument:0]];
            break;
        
        case 2:
            [self performWithObject:[_arguments argument:0] 
                         withObject:[_arguments argument:1]];
            break;

        case 3:
            [self performWithObject:[_arguments argument:0] 
                         withObject:[_arguments argument:1]
                         withObject:[_arguments argument:2]];
            break;
    }
    
    [finisher setFinished];
}

#if FL_MRC
- (void) dealloc {
    [_arguments release];
    [super dealloc];
}
#endif

        
@end        