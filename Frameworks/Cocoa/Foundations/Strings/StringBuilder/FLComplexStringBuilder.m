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
        _stringBuilders = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (id) complexStringBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_stack release];
    [_stringBuilders release];
    [super dealloc];
}
#endif

- (BOOL) isEmpty {
    return _stack.count == 0;
}

- (NSString*) buildString {
    
    
    return nil;
}

- (NSString*) description {
    return [self buildString];
}

//- (void) appendLine {
//    [[_stack lastObject] appendLine];
//}
//
//- (void) appendString:(NSString*) string {
//    [[_stack lastObject] appendString:string];
//}

//- (void) addStringBuilder:(FLStringBuilder*) builder {
////  	for(id contentItem in builder.scope.tokens) {
////        [self.scope addToken:FLAutorelease([contentItem copy])];
////    }
//}

- (FLStringBuilder*) stringBuilder {
    return [_stack lastObject];
}

- (void) openScope:(FLStringBuilder*) scope {
    [self addStringBuilder:scope];
    [_stack addObject:scope];
}

- (void) closeScope {
    [_stack removeLastObject];
}

- (void) addStringBuilder:(FLStringBuilder*) stringBuilder {
    [_stringBuilders addObject:stringBuilder];
    stringBuilder.parent = self;
    [stringBuilder didMoveToParent:self];
}

- (NSString*) buildStringWithWhitespace:(FLWhitespace*) whitespace {

    FLPrettyString* prettyString = [FLPrettyString prettyString:whitespace];
    
    for(FLStringBuilder* stringBuilder in _stringBuilders) {
        [stringBuilder appendSelfToPrettyString:prettyString];
    }

    return [prettyString string];
}

- (NSString*) buildStringWithNoWhitespace {
    return [self buildStringWithWhitespace:[FLWhitespace compressedWhitespace]];
}

- (NSString*) buildStringWithWhitespace {
    return [self buildStringWithWhitespace:[FLWhitespace tabbedWithSpacesWhitespace]];
}

- (id) complexStringBuilder {
    return self;
}

@end


@implementation FLStringBuilder (FLComplexStringBuilder)

- (id) rootParent {
    return self.parent == nil ? self : self.parent;
}

- (id) complexStringBuilder {
    return nil;
}

- (id) document {
    return [[self rootParent] complexStringBuilder];
}

@end