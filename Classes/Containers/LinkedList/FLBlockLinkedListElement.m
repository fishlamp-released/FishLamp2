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
    return autorelease_([[[self class] alloc] init]);   
}

#if FL_MRC 
- (void) dealloc {
    mrc_release_(_block);
    super_dealloc_();
}
#endif

@end
