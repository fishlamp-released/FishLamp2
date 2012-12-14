//
//  FLCodeBuilder.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCodeBuilder.h"

@implementation FLCodeBuilder

@synthesize openBracket = _openBracket;
@synthesize closeBracket = _closeBracket;

- (id) init {
    self = [super init];
    if(self) {
        self.header = [FLSingleLineToken singleLineToken:@""];
        self.footer = [FLSingleLineToken singleLineToken:@""];
    }
    return self;
}

+ (id) codeBuilder {
    return FLAutorelease([[[self class] alloc] init]);
}

- (BOOL) shouldBuildString {
    return YES;
}

- (void) willBuildString {

    if(FLStringIsEmpty([self.header string])) {
        [self.header setToken:_openBracket];
    }
    else {
        [self.header setToken:[NSString stringWithFormat:@" %@", _openBracket]];
    }

    [self.footer setToken:_closeBracket];
}

#if FL_MRC
- (void) dealloc {
    [_openBracket release];
    [_closeBracket release];
    [super dealloc];
}
#endif


@end
