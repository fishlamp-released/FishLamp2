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

- (id) lastLine {
    FLAssertNotNil_([_lines lastObject]);
    return [_lines lastObject];
}

- (void) appendString:(NSString*) string {
    if(_needsLine) {
        [_lines addObject:[FLStringBuilderLine stringBuilderLine]];
        _needsLine = NO;
    }
    
    [self.lastLine appendStringToLine:string];
}

- (void) addStringBuilderLine:(FLStringBuilderLine*) line {
    [_lines addObject:line];
    line.parent = self;
    [line didMoveToParent:self];
    _needsLine = YES;
}

- (void) appendLine {
    _needsLine = YES;
}

//- (void) setTabIndent:(NSInteger) tabIndent {
//    [super setTabIndent:tabIndent];
//    [self.lastLine setTabIndent:tabIndent];
//}

- (id) copyWithZone:(NSZone*) zone {

    return nil;
}

- (void) appendSelfToPrettyString:(FLPrettyString*) prettyString {
    
    for(id<FLBuildableString> line in _lines) {
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

- (void) addLineWithObject:(id<FLStringFormatter>) object {
    [_lines addObject:object];

    id builder = object;
    if([builder conformsToProtocol:@protocol(FLStringBuilderLine)]) {
        [builder setParent:self];
        [builder didMoveToParent:self];
    }
    
    _needsLine = YES;
}

- (void) didMoveToParent:(id) parent {
}

- (NSString*) description {
    return [self buildString];
}

@end
