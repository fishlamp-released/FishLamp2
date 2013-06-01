//
//  FLStringBuilderContents.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLStringDocument.h"

@implementation FLStringDocument

@synthesize openedStringBuilders = _stack;

- (id) init {
    self = [super init];
    if(self) {
        _stack = [[NSMutableArray alloc] init];
        [_stack addObject:[FLDocumentSection stringBuilder]];
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

- (id<FLStringFormatter, FLBuildableString>) rootStringBuilder {
    FLAssertNotNil([_stack firstObject]);
    return [_stack firstObject];
}

- (id<FLStringFormatter, FLBuildableString>) openedStringBuilder {
    FLAssertNotNil([_stack lastObject]);
    return [_stack lastObject];
}

- (void) appendStringFormatter:(id<FLStringFormatter, FLBuildableString>) stringBuilder {
    FLAssert(_stack.count > 0);
    
    [self.openedStringBuilder appendStringFormatter:stringBuilder];
}

- (void) openStringBuilder:(id<FLStringFormatter, FLBuildableString>) stringBuilder {
    [self appendStringFormatter:stringBuilder];
    
    FLAssert(_stack.count > 0);
    
    [_stack addObject:stringBuilder];
}

- (FLDocumentSection*) closeStringBuilder {
    FLAssert(_stack.count > 0);
    
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
    [_stack addObject:[FLDocumentSection stringBuilder]];
}

@end

//@interface FLDocumentSection (FLStringDocument)
//- (void) willMoveToStringBuilderStack:(FLStringDocument*) stack;
//- (void) didMoveToStringBuilderStack:(FLStringDocument*) stack;
//@end

//
//@implementation FLDocumentSection (FLStringDocument)
//
//- (void) willMoveToStringBuilderStack:(FLStringDocument*) stack {
//}
//
//- (void) didMoveToStringBuilderStack:(FLStringDocument*) stack {
//}
//@end
//
