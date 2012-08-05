//
//  FLCodeScope.m
//  FishLampCore
//
//  Created by Mike Fullerton on 5/26/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLCodeScope.h"
#import "FLCodeScopeFormatter.h"

@interface FLCodeScope ()
@end

@implementation FLCodeScope

@synthesize openTag = _openTag;
@synthesize closeTag = _closeTag;
@synthesize formatter = _formatter;

- (id) initWithOpenTag:(NSString*) tag closeTag:(NSString*) closeTag {
    self = [super init];
    if(self) {
        self.openTag = tag;
        self.closeTag = closeTag;
    }
    return self;
}

#if FL_DEALLOC
- (void) dealloc {
    [_openTag release];
    [_closeTag release];
    [_formatter release];
	FLSuperDealloc();
}
#endif

+ (id) codeScope:(NSString*) openTag closeTag:(NSString*) closeTag {
    return FLReturnAutoreleased([[[self class] alloc] initWithOpenTag:openTag closeTag:closeTag]);
}

@end