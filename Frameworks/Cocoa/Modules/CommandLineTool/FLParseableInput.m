//
//  FLParseableInput.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/9/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLParseableInput.h"

@implementation FLParseableInput

@synthesize string = _string;
@synthesize history = _history;
@synthesize remainingRange = _remainingRange;

- (id) initWithString:(NSString*) string {
    self = [super init];
    if(self) {
        _string = [string copy];
        _history = [[NSMutableArray alloc] init];
        _remainingRange = NSMakeRange(0, _string.length);
    }
    return self;
}

+ (id) parseableInput:(NSString*) string {
    return FLAutorelease([[[self class] alloc] initWithString:string]);
}

#if FL_MRC
- (void) dealloc {
    [_string release];
    [_history release];
    [_commits release];
    [super dealloc];
}
#endif

static FLParseableInputBlock s_defaultParser = ^(NSString* string) {
    NSRange range = { 0, 0 };
    
    NSCharacterSet* set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    
    for(int i = 0; i < string.length; i++) {
        if([set characterIsMember:[string characterAtIndex:i]]) {
            continue;
        }
        range.location = i;
        for(int j = i; j < string.length; j++) {
            if([set characterIsMember:[string characterAtIndex:j]]) {
                goto done;
            }
            range.length++;
        }
        
        goto done;
    } 

done:    
    return range;
};  

- (NSString*) next {
    return [self nextWithBlock:s_defaultParser];
}

- (NSString*) nextWithBlock:(NSRange (^)(NSString* string)) parseNextBlock {
    NSRange range = parseNextBlock([self unparsed]);
    
    if(range.length == 0) {
        _remainingRange.location = _string.length;
        _remainingRange.length = 0;
        return nil;
    }
    
    _remainingRange.location += range.location;
    _remainingRange.length -= (range.location + range.length);
    
    NSString* token = [_string substringWithRange:range];
    [_history addObject:token];
    return token;
}

- (NSString*) last {
    return _history.lastObject;
}

- (NSString*) unparsed {
    return [_string substringWithRange:_remainingRange];
}

- (BOOL) hasMore {
    return _remainingRange.length > 0;
}

- (void) addCommitBlock:(FLParseableInputCommitBlock) commitBlock {
    if(!_commits) {
        _commits = [[NSMutableArray alloc] init];
    }

    [_commits addObject:FLCopyWithAutorelease(commitBlock)];
}

- (void) commitWithOutput:(FLStringFormatter*) output {

    for(FLParseableInputCommitBlock block in _commits) {
        block(output);
    }
    
    [_commits removeAllObjects];
}


@end
