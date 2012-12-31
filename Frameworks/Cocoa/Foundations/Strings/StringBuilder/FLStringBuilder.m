//
//  FLPrettyString.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/29/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStringBuilder.h"
#import "FLWhitespace.h"

@implementation FLStringBuilder 

@synthesize lines = _lines;
@synthesize parent = _parent;

- (id) init {
    self = [super init];
    if(self) {
        _needsLine = YES;
        _lines = [[NSMutableArray alloc] init];
    }    
    return self;
}

+ (id) stringBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_lines release];
    [super dealloc];
}
#endif

- (void) appendString:(NSString*) string {
    if(_needsLine) {
        [self appendLine];
    }
    
    [[_lines lastObject] appendStringToLine:string];
}

- (void) addStringBuilderLine:(FLStringBuilderLine*) line {
    _needsLine = NO;
    
    [_lines addObject:line];
    line.tabIndent += self.tabIndent;
    line.parent = self;
    [line didMoveToParent:self];
}

- (void) appendLine {
    [self addStringBuilderLine:[FLStringBuilderLine stringBuilderLine:self.tabIndent]];
}

- (void) setTabIndent:(NSInteger) tabIndent {
    [super setTabIndent:tabIndent];
    [[_lines lastObject] setTabIndent:tabIndent];
}

- (id) copyWithZone:(NSZone*) zone {

    return nil;
}

- (void) appendSelfToPrettyString:(FLPrettyString*) prettyString {
    
    prettyString.tabIndent += self.tabIndent;
    
    for(id<FLStringBuilderLine> line in _lines) {
        [line appendSelfToPrettyString:prettyString];
    }
}

- (NSString*) buildStringWithWhitespace:(FLWhitespace*) whitespace {
    
    FLPrettyString* prettyString = [FLPrettyString prettyString:whitespace];
    
    [self appendSelfToPrettyString:prettyString];
    
    return [prettyString string];
}

- (NSString*) buildStringWithNoWhitespace {
    return [self buildStringWithWhitespace:nil];
}

- (NSString*) buildString {
    return [self buildStringWithWhitespace:[FLWhitespace tabbedWithSpacesWhitespace]];
}

- (NSUInteger) countLines {
    NSUInteger count = 0;
    if(!_lines) {
        return 0;
    }

    for(id<FLStringBuilderLine> line in _lines) {
        count += [line countLines];
    }

    return count;
}

- (BOOL) hasLines {
    if(_lines) {
        for(id<FLStringBuilderLine> line in _lines) {
            if([line hasLines]) {
                return YES;
            }
        }
    }
    
    return NO;
}

- (void) addStringBuilder:(FLStringBuilder*) stringBuilder {
    [_lines addObject:stringBuilder];
    _needsLine = YES;
    stringBuilder.parent = self;
    [stringBuilder didMoveToParent:self];

//    for(FLStringBuilderLine* line in prettyString.lines) {
//        FLStringBuilderLine* newLine = [line copy];
//        newLine.tabIndent += self.tabIndent;
//        [_lines addObject:newLine];
//    }
}

//- (void) insertLines:(id<FLLineBuilder>)anObject 
//             atIndex:(NSUInteger)index {
//    [_lines insertObject:anObject atIndex:index];
//}

- (void) didMoveToParent:(id) parent {
}

- (NSString*) description {
    return [self buildString];
}

@end
