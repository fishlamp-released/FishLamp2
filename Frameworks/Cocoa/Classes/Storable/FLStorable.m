//
//  FLStorable.m
//  FishLamp
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
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

- (void) copySelfTo:(FLStorable*) object {
    object.storageKey = self.storageKey;
    object.storableType = self.storableType;
    object.storableSubType = self.storableSubType;
}

- (id)copyWithZone:(NSZone *)zone {
    id<FLCopyable> object = [[[self class] alloc] init];
    [self copySelfTo:object];
    return object;
}


@end


