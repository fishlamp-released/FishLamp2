//
//  FLSelector.m
//  FishLampCore
//
//  Created by Mike Fullerton on 3/13/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLSelector.h"
#import "FLObjcRuntime.h"

@implementation FLSelector 

@synthesize selector = _selector;

- (id) init {
    return [self initWithSelector:nil];
}

- (id) initWithSelector:(SEL) selector  {
    self = [super init];
    if(self) {
        _selector = selector;
        _argumentCount = -1;
    }
    return self;
}

- (id) initWithSelector:(SEL) selector  argCount:(NSUInteger) argCount {
    self = [self initWithSelector:selector];
    if(self) {
        _argumentCount = argCount;
    }
    return self;
}

+ (id) selector:(SEL) selector {
    return FLAutorelease([[[self class] alloc] initWithSelector:selector]);
}

+ (id) selector:(SEL) selector argCount:(NSUInteger) argCount {
    return FLAutorelease([[[self class] alloc] initWithSelector:selector argCount:argCount]);
}

#if FL_MRC
- (void) dealloc {
    [_selectorString release];
    [super dealloc];
}
#endif

- (NSString*) selectorString {
    if(!_selectorString) {
        _selectorString = FLRetain(NSStringFromSelector(_selector));
    }
    return _selectorString;
}

- (int) argumentCount {
    if(_argumentCount == -1) { 
        _argumentCount = 0;
        NSString* name = self.selectorString;
        for(int i = 0; i < name.length; i++) {
            if([name characterAtIndex:i] == ':') {
                _argumentCount++;
            }
        }
    }
    
    return _argumentCount;
}

- (id) copyWithZone:(NSZone *)zone {
    return FLRetain(self);
}

- (BOOL)isEqual:(id)object {
    return FLSelectorsAreEqual(_selector, [object selector]);
}

- (NSUInteger)hash {
    return (NSUInteger) sel_getName(_selector);
}

- (NSString*) description {
    return self.selectorString;
}

@end
