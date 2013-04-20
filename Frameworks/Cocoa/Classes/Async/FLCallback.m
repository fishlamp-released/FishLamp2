//
//  FLCallback.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCallback.h"

const FLCallback_t FLCallbackZero = { nil, nil };

@implementation FLCallback

- (id) target {
    return nil;
}

- (SEL) action {
    return nil;
}

- (void) setTarget:(id) target {
}

- (void) setAction:(SEL) action {
}


- (id) initWithTarget:(id) target action:(SEL) action {
    self = [super init];
    if(self) {
    }

    return self;
}

+ (id) callbackWithTarget:(id) target action:(SEL) action {
    return FLAutorelease([[[self class] alloc] initWithTarget:target action:action]);
}

- (BOOL) perform {
    return FLPerformSelector([self target], [self action]);
}

- (BOOL) performWithObject:(id) object {
    return FLPerformSelector1([self target], [self action], object);
}

- (BOOL) performWithObject:(id) object1 withObject:(id) object2 {
    return FLPerformSelector2([self target], [self action], object1, object2);
}

- (BOOL) performWithObject:(id) object1 withObject:(id) object2 withObject:(id) object3 {
    return FLPerformSelector3([self target], [self action], object1, object2, object3);
}

//#if FL_MRC
//- (void) dealloc {
//    [_block release];
//    [_target release];
//    [super dealloc];
//}
//#endif

@end

@implementation FLCallbackWithUnretainedTarget

@synthesize target = _target;
@synthesize action = _action;

- (id) initWithTarget:(id) target action:(SEL) action {
    self = [super init];
    if(self) {
        self.target = target;
        self.action = action;
    }

    return self;
}

@end

//@interface FLStashedCallback ()
//@property (readwrite, strong, nonatomic) FLArgumentList* arguments;
//@end
//
//@implementation FLStashedCallback 
//
//@synthesize arguments = _arguments;
//
//- (id) initWithTarget:(id) target action:(SEL) action arguments:(FLArgumentList*) arguments {
//    self = [super initWithTarget:target action:action];
//    if(self) {
//        self.arguments = arguments;
//    }
//    return self;
//}
//
//- (id) initWithBlock:(FLCallbackBlock) block arguments:(FLArgumentList*) arguments {
//    self = [super initWithBlock:block];
//    if(self) {
//        self.arguments = arguments;
//    }
//    return self;
//}
//
//+ (id) callbackWithTarget:(id) target action:(SEL) action arguments:(FLArgumentList*) arguments {
//    return FLAutorelease([[[self class] alloc] initWithTarget:target action:action arguments:arguments]);
//}
//
//+ (id) callbackWithBlock:(FLCallbackBlock) block arguments:(FLArgumentList*) arguments {
//    return FLAutorelease([[[self class] alloc] initWithBlock:block arguments:arguments]);
//}
//
//- (void) runAsynchronously:(FLFinisher*) finisher {
//    switch(_arguments.count) {
//        case 0:
//            [self perform];
//            break;
//        
//        case 1:
//            [self performWithObject:[_arguments argument:0]];
//            break;
//        
//        case 2:
//            [self performWithObject:[_arguments argument:0] 
//                         withObject:[_arguments argument:1]];
//            break;
//
//        case 3:
//            [self performWithObject:[_arguments argument:0] 
//                         withObject:[_arguments argument:1]
//                         withObject:[_arguments argument:2]];
//            break;
//    }
//    
//    [finisher setFinished];
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_arguments release];
//    [super dealloc];
//}
//#endif
//
//        
//@end
        