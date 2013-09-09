//
//  FLStorable.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLStorable.h"

@implementation FLStorable

@synthesize storageKey = _storageKey;
@synthesize storableType = _storableType;
@synthesize storableSubType = _storableSubType;

#if FL_MRC
- (void) dealloc {
    [_storableSubType release];
    [_storableType release];
    [_storageKey release];
    [super dealloc];
}
#endif


@end


