//
//  FLStringBuilderContents.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStringBuilderStack.h"

@implementation FLStringBuilderStack
@synthesize stack = _stack;

- (id) init {
    self = [super init];
    if(self) {
        _stack = [[NSMutableArray alloc] init];
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

- (FLStringBuilder*) bottom {
    FLAssertNotNil_([_stack firstObject]);
    return [_stack firstObject];
}

- (FLStringBuilder*) top {
    FLAssertNotNil_([_stack lastObject]);
    return [_stack lastObject];
}

- (void) push:(FLStringBuilder*) stringBuilder {
    [stringBuilder willMoveToStringBuilderStack:self];
    
    if(_stack.count > 0) {
        [self.top addStringBuilder:stringBuilder];
    }
    
    [_stack addObject:stringBuilder];
    [stringBuilder didMoveToStringBuilderStack:self];
}

- (FLStringBuilder*) pop {
    FLAssert_(_stack.count > 0)

    id last = FLRetainWithAutorelease(self.top);
    [last willMoveToStringBuilderStack:nil];
    [_stack removeLastObject];
    [last didMoveToStringBuilderStack:nil];
    
    return last;
}

@end


@implementation FLStringBuilder (FLStringBuilderStack)

- (void) willMoveToStringBuilderStack:(FLStringBuilderStack*) stack {
}

- (void) didMoveToStringBuilderStack:(FLStringBuilderStack*) stack {
}
@end

@implementation FLScopedStringBuilder 

@synthesize stack = _stack;

- (id) init {
    self = [super init];
    if(self) {
        self.delegate = self;
        _stack = [[FLStringBuilderStack alloc] init];
        FLStringBuilder* bottom = [FLStringBuilder stringBuilder];
        [_stack push:bottom];
        bottom.parent = self;
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_stack release];
    [super dealloc];
}
#endif

- (void) stringFormatterAppendEOL:(FLStringFormatter*) stringFormatter {
    [[_stack top] endLine];
}

- (void) stringFormatter:(FLStringFormatter*) stringFormatter 
            appendString:(NSString*) string {
    [[_stack top] appendString:string];
}            

- (NSString*) stringFormatterGetString:(FLStringFormatter*) stringFormatter {
    return [[_stack top] string];
}

- (FLStringBuilder*) lines {
    return [_stack top];
}

- (void) appendLinesToPrettyString:(FLPrettyString*) prettyString {
    [_stack.bottom appendLinesToPrettyString:prettyString];
}

@end