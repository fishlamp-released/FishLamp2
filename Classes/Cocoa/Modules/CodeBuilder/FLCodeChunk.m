//
//  FLCodeChunk.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 5/31/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCodeChunk.h"

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

- (void) buildStringIntoStringFormatter:(id<FLStringFormatter>) stringFormatter {
    if(FLStringIsNotEmpty(_openScopeString)) {
        [stringFormatter appendLine:_openScopeString];
        [stringFormatter indent:^{
            [super buildStringIntoStringFormatter:stringFormatter];
        }];
        
        if(FLStringIsNotEmpty(_closeScopeString)) {
            [stringFormatter appendLine:_closeScopeString];
        }
    }
    else {
        [super buildStringIntoStringFormatter:stringFormatter];
    }
}

@end