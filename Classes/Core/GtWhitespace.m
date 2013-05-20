//
//  GtWhitespace.m
//  FishLampCore
//
//  Created by Mike Fullerton on 5/25/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtWhitespace.h"

@implementation GtWhitespace

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



+ (GtWhitespace*) whitespace {
    return GtReturnAutoreleased([[[self class] alloc] init]);
}

- (void) dealloc {
    for(int i = 0; i < 100; i++) {
        if(_cachedTabs[i]) {
            GtRelease(_cachedTabs[i]);
        }
    }
    GtRelease(_eolString);
    GtRelease(_tabString);
    
    GtSuperDealloc();
}

- (NSString*) tabStringForScope:(NSInteger) indent {

    GtAssert(indent < 100, @"too many indents");
        
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

+ (GtWhitespace*) tabbedFormat {
     GtReturnStaticObjectFromBlock(^{
        GtWhitespace* formatter = [GtWhitespace whitespace];
        formatter.eolString = GtWhitespaceDefaultEOL;
        formatter.tabString = GtWhitespaceDefaultTabString;
        return formatter;
     });
}

+ (GtWhitespace*) compressedFormat {
    GtReturnStaticObjectFromBlock(^{ 
        return [GtWhitespace whitespace];
    });
}

@end

