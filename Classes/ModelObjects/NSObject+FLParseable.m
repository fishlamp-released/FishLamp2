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
        FLRetainObject_(_fileName, file);
        FLRetainObject_(_hint, hint);
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    mrc_release_(_fileName);
    mrc_release_(_hint);
    mrc_super_dealloc_();
}

#endif

+ (FLParseInfo*) parseInfo:(NSString*) hint file:(NSString*) fileName line:(NSUInteger) line column:(NSUInteger) column {
    return autorelease_([[FLParseInfo alloc] initWithHint:hint file:fileName line:line column:column]); 
}

- (NSString*) description {
    return [NSString stringWithFormat:@"Parsed in file: %@, at line: %ld, at column: %ld, hint: %@", _fileName == nil ? @"<unknown>" : _fileName, (long) _line, (long) _column, _hint ? _hint : @"<no hint>"];
}

@end

@implementation NSObject (FLParseable)
FLSynthesizeAssociatedProperty(retain_nonatomic, parseInfo, setParseInfo, FLParseInfo*);
@end
