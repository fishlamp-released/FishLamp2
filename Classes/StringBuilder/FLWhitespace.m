//
//  FLWhitespace.m
//  FishLampCore
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
    return FLReturnAutoreleased([[[self class] alloc] init]);
}

- (void) dealloc {
    for(int i = 0; i < 100; i++) {
        if(_cachedTabs[i]) {
            FLRelease(_cachedTabs[i]);
        }
    }
    FLRelease(_eolString);
    FLRelease(_tabString);
    
    FLSuperDealloc();
}

- (NSString*) tabStringForScope:(NSInteger) indent {

    FLAssert(indent < 100, @"too many indents");
        
    if(_tabString && _tabString.length && indent < 100) {
        
        if(!_cachedTabs[indent]) {
            NSMutableString* tabStr = [[NSMutableString alloc] initWithCapacity:indent * _tabString.length];
            for(int i = 0; i < indent; i++) {
                [tabStr appendString:_tabString];
            }
            
            _cachedTabs[indent] = tabStr;
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

@end

