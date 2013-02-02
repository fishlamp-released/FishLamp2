//
//  FLStringBuilderContents.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStringDocument.h"

@implementation FLStringDocument

@synthesize openedStringBuilders = _stack;

- (id) init {
    self = [super init];
    if(self) {
        _stack = [[NSMutableArray alloc] init];
        [_stack addObject:[FLStringBuilder stringBuilder]];
    }
    return self;
}

+ (id) stringBuilderStack {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_stack release];
    [super dealloc];
}
#endif

- (FLStringBuilder*) rootStringBuilder {
    FLAssertNotNil_([_stack firstObject]);
    return [_stack firstObject];
}

- (FLStringBuilder*) openedStringBuilder {
    FLAssertNotNil_([_stack lastObject]);
    return [_stack lastObject];
}

- (void) addStringBuilder:(FLStringBuilder*) stringBuilder {
    FLAssert_(_stack.count > 0)
    [self.openedStringBuilder addStringBuilder:stringBuilder];
}

- (void) openStringBuilder:(FLStringBuilder*) stringBuilder {
    [self addStringBuilder:stringBuilder];
    
    FLAssert_(_stack.count > 0)
    [_stack addObject:stringBuilder];
}

- (FLStringBuilder*) closeStringBuilder {
    FLAssert_(_stack.count > 0)
    id last = FLRetainWithAutorelease(self.openedStringBuilder);
    [_stack removeLastObject];
    return last;
}

- (void) closeAllStringBuilders {
    while(_stack.count > 1) {
        [self closeStringBuilder];
    }
}

- (void) deleteAllStringBuilders {
    [_stack removeAllObjects];
    [_stack addObject:[FLStringBuilder stringBuilder]];
}

@end

//@interface FLStringBuilder (FLStringDocument)
//- (void) willMoveToStringBuilderStack:(FLStringDocument*) stack;
//- (void) didMoveToStringBuilderStack:(FLStringDocument*) stack;
//@end

//
//@implementation FLStringBuilder (FLStringDocument)
//
//- (void) willMoveToStringBuilderStack:(FLStringDocument*) stack {
//}
//
//- (void) didMoveToStringBuilderStack:(FLStringDocument*) stack {
//}
//@end
//
