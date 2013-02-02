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

- (void) appendLinesToPrettyString:(FLPrettyString*) prettyString {
    if(FLStringIsNotEmpty(_openScopeString)) {
        [prettyString appendLine:_openScopeString];
        [prettyString indent:^{
            [super appendLinesToPrettyString:prettyString];
        }];
        
        if(FLStringIsNotEmpty(_closeScopeString)) {
            [prettyString appendLine:_closeScopeString];
        }
    }
    else {
        [super appendLinesToPrettyString:prettyString];
    }
}

@end