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
        
#if DEBUG
// note that it this point the object hasn't been deleted yet.
        _debugInfo = [[NSString alloc] initWithFormat:@"%@: %@", NSStringFromClass([_deletedObject class]), [_deletedObject description]];
#endif        
    }
    return self;
}

#if DEBUG
- (NSString*) description {
    return _debugInfo;
}

#if FL_MRC
- (void) dealloc {
    [_debugInfo release];
    [super dealloc];
}

#endif
#endif

+ (FLDeletedObjectReference*) deletedObjectReference:(id) object {
    return FLReturnAutoreleased([[FLDeletedObjectReference alloc] initWithObject:object]);
}

@end