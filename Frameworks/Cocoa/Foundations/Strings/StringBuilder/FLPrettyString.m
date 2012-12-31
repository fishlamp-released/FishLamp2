//
//  FLPrettyString.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/30/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLPrettyString.h"

@interface FLPrettyString ()
@property (readwrite, strong, nonatomic) NSString* string;
@property (readwrite, strong, nonatomic) FLWhitespace* whitespace;
@end

@implementation FLPrettyString

@synthesize string = _string;
@synthesize whitespace = _whitespace;

- (id) initWithWhitespace:(FLWhitespace*) whitespace {
    self = [super init];
    if(self) {
        _string = [[NSMutableString alloc] init];
        _whitespace = FLRetain(whitespace);
        _needsTabInset = YES;
    }
    return self;
}

+ (id) prettyString:(FLWhitespace*) whitespace {
    return FLAutorelease([[[self class] alloc] initWithWhitespace:whitespace]);
}

+ (id) prettyString {
    return FLAutorelease([[[self class] alloc] initWithWhitespace:[FLWhitespace tabbedWithSpacesWhitespace]]);
}

#if FL_DEALLOC
- (void) dealloc {
    [_whitespace release];
    [_string release];
    [super dealloc];
}
#endif

- (void) appendLine {
    if(_whitespace) {
        [self appendString:_whitespace.eolString];
        _needsTabInset = YES;
    }
}

- (void) appendString:(NSString*) string {
    if(_needsTabInset) {
        _needsTabInset = NO;
        if(_whitespace) {
            [_string appendString:[_whitespace tabStringForScope:self.tabIndent]];
        }
    }
    
    [_string appendString:string];
}

- (id) copyWithZone:(NSZone*) zone {
    FLPrettyString* str = [[FLPrettyString alloc] initWithWhitespace:self.whitespace];
    str.string = FLAutorelease([_string mutableCopy]);
    str.tabIndent = self.tabIndent;
    return str;
}

//- (void) appendLine:(NSString*) string 
//      withTabIndent:(NSInteger) tabIndent {
//        
//    if(_whitespace) {
//        [_string appendFormat:@"%@%@%@", [_whitespace tabStringForScope:self.tabIndent + tabIndent], string, _whitespace.eolString];
//    }
//    else {
//        [_string appendString:string];
//    }
//}

@end
