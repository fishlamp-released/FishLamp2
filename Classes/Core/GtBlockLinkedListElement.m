//
//  GtBlockLinkedListElement.m
//  FishLampCore
//
//  Created by Mike Fullerton on 6/14/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtBlockLinkedListElement.h"

@implementation GtBlockLinkedListElement

@synthesize block = _block; 

+ (GtBlockLinkedListElement*) blockLinkedListElement {
    return GtReturnAutoreleased([[[self class] alloc] init]);   
}

#if GT_DEALLOC 
- (void) dealloc {
    [_block release];
    [super dealloc];
}
#endif

@end
