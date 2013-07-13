//
//  FLMainThreadObject.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLMainThreadObject.h"

@implementation FLMainThreadObject

+ (id) mainThreadObject:(id) object {
    return FLAutorelease([[[self class] alloc] initWithObject:object]);
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    
    id object = self.object;
    
    if([object respondsToSelector:[anInvocation selector]]) {
        [anInvocation retainArguments];
        dispatch_async(dispatch_get_main_queue(), ^{
            @try {
                [anInvocation invokeWithTarget:object];
            }
            @catch(NSException* ex) {
            
            }
        });
    }
    else {
        [super forwardInvocation:anInvocation];
    }
}

@end

@implementation NSObject (FLMainThreadObject)
- (id) onMainThread {
    return [NSThread isMainThread] ? self : [FLMainThreadObject mainThreadObject:self];
}
@end