//
//  FLBlockLinkedListElement.m
//  FishLampCore
//
//  Created by Mike Fullerton on 6/14/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLBlockLinkedListElement.h"

@implementation FLBlockLinkedListElement

@synthesize block = _block; 

+ (FLBlockLinkedListElement*) blockLinkedListElement {
    return FLReturnAutoreleased([[[self class] alloc] init]);   
}

#if FL_DEALLOC 
- (void) dealloc {
    [_block release];
    [super dealloc];
}
#endif

@end
