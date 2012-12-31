//
//  FLStringBuilderLine.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStringBuilderLine.h"

@implementation FLStringBuilderLine 
@synthesize string = _string;
@synthesize tabIndent = _tabIndent;
@synthesize parent = _parent;

- (id) initWithTabCount:(NSInteger) tabIndent {
    self = [super init];
    if(self) {
        _tabIndent = tabIndent;
    }
    
    return self;
}

+ (id) stringBuilderLine:(NSInteger) tabIndent {
    return FLAutorelease([[[self class] alloc] initWithTabCount:tabIndent]);
}

+ (id) stringBuilderLine {
    return FLAutorelease([[[self class] alloc] init]);
}
#if FL_MRC
- (void) dealloc {
    [_string release];
    [super dealloc];
}
#endif

- (void) setString:(NSString*) string {
    FLReleaseWithNil(_string);
    [self appendString:string];
}

- (void) appendString:(NSString*) string {

    if(string && string.length) {
        if(!_string) {
            _string = [string mutableCopy];
        }
        else {
            [_string appendString:string];
        }
    }
}

- (void) appendStringToLine:(NSString*) string {
    [self appendString:string];
}


- (id) copyWithZone:(NSZone *)zone {
    FLStringBuilderLine* line = [[[self class] alloc] initWithTabCount:_tabIndent];
    [line appendStringToLine:line.string];
    return line;
}

- (void) appendSelfToPrettyString:(FLPrettyString*) prettyString {
    if(FLStringIsNotEmpty(_string)) {
        [prettyString appendLine:_string withTabIndent:_tabIndent];
    }
}

- (NSUInteger) countLines {
    return FLStringIsNotEmpty(_string) ? 1 : 0;
}

- (BOOL) hasLines {
   return FLStringIsNotEmpty(_string);
}

- (void) didMoveToParent:(id) parent {
}

@end
