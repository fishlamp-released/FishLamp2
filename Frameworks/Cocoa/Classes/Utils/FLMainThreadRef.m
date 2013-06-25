//
//  FLMainThreadRef.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLMainThreadRef.h"

@implementation FLMainThreadRef

+ (id) mainThreadRef:(id) object {
    return FLAutorelease([[[self class] alloc] initWithObject:object]);
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if([[self object] respondsToSelector:[anInvocation selector]]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [anInvocation invokeWithTarget:self.object];
        });
    }
    else {
        [super forwardInvocation:anInvocation];
    }
}

@end
