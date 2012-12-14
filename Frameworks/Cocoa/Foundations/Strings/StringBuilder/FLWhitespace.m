//
//  FLWhitespace.m
//  FLCore
//
//  Created by Mike Fullerton on 5/25/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLWhitespace.h"

@implementation FLWhitespace

@synthesize eolString = _eolString;
@synthesize tabString = _tabString;

- (id) init {
    self = [super init];
    if(self) {
        self.eolString = @"";
        self.tabString = @"";
        memset(_cachedTabs, 0, sizeof(NSString*) * 100); 
    }
    return self;
}

+ (FLWhitespace*) whitespace {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) dealloc {
    for(int i = 0; i < 100; i++) {
        if(_cachedTabs[i]) {
            FLRelease(_cachedTabs[i]);
        }
    }
    FLRelease(_eolString);
    FLRelease(_tabString);
    
    super_dealloc_();
}

- (NSString*) tabStringForScope:(NSUInteger) indent {
    FLAssert_v(indent < 100, @"too many indents");
    if(indent > 0 && _tabString && _tabString.length && indent < 100) {
    
        if(!_cachedTabs[indent]) {
        
            NSString* string = [@"" stringByPaddingToLength:(indent * _tabString.length) withString:_tabString startingAtIndex:0];
            
            _cachedTabs[indent] = FLRetain(string);
        }
        return _cachedTabs[indent];
    }
    
    return @"";
}

+ (FLWhitespace*) tabbedFormat {
     FLReturnStaticObjectFromBlock(^{
        FLWhitespace* formatter = [FLWhitespace whitespace];
        formatter.eolString = FLWhitespaceDefaultEOL;
        formatter.tabString = FLWhitespaceDefaultTabString;
        return formatter;
     });
}

+ (FLWhitespace*) compressedFormat {
    FLReturnStaticObjectFromBlock(^{ 
        return [FLWhitespace whitespace];
    });
}

- (void) appendEol:(NSMutableString*) toString {
    if(FLStringIsNotEmpty(_eolString)) {
        [toString appendString:_eolString];
    }
}

- (void) appendTabs:(NSUInteger) count toString:(NSMutableString*) toString {
    
    NSString* tabs = [self tabStringForScope:count];
    if(FLStringIsNotEmpty(tabs)) {
        [toString appendString:tabs];
    }
    
}

- (void) appendEolAndTabs:(NSUInteger) tabCount toString:(NSMutableString*) toString {
    [self appendTabs:tabCount toString:toString];
    [self appendEol:toString];
}




@end

