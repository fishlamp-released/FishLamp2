//
//  NSObject+FLParseable.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/23/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "NSObject+FLParseable.h"

#import <objc/runtime.h>

@implementation FLParseInfo

@synthesize hint = _hint;
@synthesize fileName = _fileName;
@synthesize line = _line;
@synthesize column = _column;

- (id) initWithHint:(NSString*) hint
    file:(NSString*) file
    line:(NSUInteger) line 
    column:(NSUInteger) column 
{
    self = [super init];
    if(self) {
        _line = line;
        _column = column;
        FLAssignObject(_fileName, file);
        FLAssignObject(_hint, hint);
    }
    
    return self;
}

#if FL_DEALLOC
- (void) dealloc {
    [_fileName release];
    [_hint release];
    [super dealloc];
}

#endif

+ (FLParseInfo*) parseInfo:(NSString*) hint file:(NSString*) fileName line:(NSUInteger) line column:(NSUInteger) column {
    return FLReturnAutoreleased([[FLParseInfo alloc] initWithHint:hint file:fileName line:line column:column]); 
}

- (NSString*) description {
    return [NSString stringWithFormat:@"Parsed in file: %@, at line: %ld, at column: %ld, hint: %@", _fileName == nil ? @"<unknown>" : _fileName, (long) _line, (long) _column, _hint ? _hint : @"<no hint>"];
}


@end

@implementation NSObject (FLParseable)

static void * const kParseableKey = (void*)&kParseableKey;

- (FLParseInfo*) parseInfo {
    return objc_getAssociatedObject(self, kParseableKey);
}

- (void) setParseInfo:(FLParseInfo*) info {
    objc_setAssociatedObject(self, kParseableKey, info, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
