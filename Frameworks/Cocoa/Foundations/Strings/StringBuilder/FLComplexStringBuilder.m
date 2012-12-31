//
//  FLStringBuilderContents.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLComplexStringBuilder.h"

@implementation FLComplexStringBuilder

- (id) init {
    self = [super init];
    if(self) {
        _stack = [[NSMutableArray alloc] init];
        FLStringBuilder* root = [FLStringBuilder stringBuilder];
        root.parent = self;
        [_stack addObject:root];
        
        [root didMoveToParent:self];
        
    }
    return self;
}

+ (id) complexStringBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_stack release];
    [super dealloc];
}
#endif

- (id) formatter {
    FLAssertNotNil_([_stack lastObject]);
    return [_stack lastObject];
}

- (void) openFormatter:(FLStringBuilder*) target {
    [self.formatter addLineWithObject:target];
    [_stack addObject:target];
}

- (void) closeFormatter {
    [_stack removeLastObject];
    FLAssert_(_stack.count > 0);
}

- (void) addLineWithObject:(id /*FLBuildableString*/) object {
    [self.formatter addLineWithObject:object];
}

- (NSString*) buildStringWithWhitespace:(FLWhitespace*) whitespace {

    FLPrettyString* prettyString = [FLPrettyString prettyString:whitespace];
    [[_stack objectAtIndex:0] appendSelfToPrettyString:prettyString];
    return [prettyString string];
}

- (NSString*) buildStringWithNoWhitespace {
    return [self buildStringWithWhitespace:[FLWhitespace compressedWhitespace]];
}

- (NSString*) buildStringWithWhitespace {
    return [self buildStringWithWhitespace:[FLWhitespace tabbedWithSpacesWhitespace]];
}

- (NSString*) description {
    return [self buildStringWithWhitespace];
}

- (id) complexStringBuilder {
    return self;
}

- (id) rootParent {
    return self;
}

@end


@implementation FLStringBuilder (FLComplexStringBuilder)

- (id) rootParent {

    if(self.parent != nil) {
        return [self.parent rootParent];
    }

    return self;
}

- (id) complexStringBuilder {
    return nil;
}

- (id) document {
    return [[self rootParent] complexStringBuilder];
}

@end