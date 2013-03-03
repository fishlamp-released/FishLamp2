//
//  FLCodeBuilder.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCodeBuilder.h"

@implementation FLCodeBuilder

+ (id) codeBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) addCodeChunk:(FLCodeChunk*) codeChunk {
    [self addSection:codeChunk];
}

- (void) openCodeChunk:(FLCodeChunk*) codeChunk {
    [self openSection:codeChunk];
}

- (void) closeCodeChunk {
    [self closeSection];
}

@end

@implementation FLCodeChunk

@synthesize openScopeString = _openScopeString;
@synthesize closeScopeString = _closeScopeString;

+ (id) codeChunk {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_openScopeString release];
    [_closeScopeString release];
    [super dealloc];
}
#endif

- (void) appendLinesToStringFormatter:(id<FLStringFormatter>) stringFormatter {
    if(FLStringIsNotEmpty(_openScopeString)) {
        [stringFormatter appendLine:_openScopeString];
        [stringFormatter indent:^{
            [super appendLinesToStringFormatter:stringFormatter];
        }];
        
        if(FLStringIsNotEmpty(_closeScopeString)) {
            [stringFormatter appendLine:_closeScopeString];
        }
    }
    else {
        [super appendLinesToStringFormatter:stringFormatter];
    }
}

@end