//
//  FLDeletedObjectReference.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLDeletedObjectReference.h"

@implementation FLDeletedObjectReference

@synthesize deletedObject = _deletedObject;

- (id) initWithObject:(id) object {
    self = [super init];
    if(self) {
        _deletedObject = object;
    }
    return self;
}

+ (FLDeletedObjectReference*) deletedObjectReference:(id) object {
    return FLReturnAutoreleased([[FLDeletedObjectReference alloc] initWithObject:object]);
}

@end