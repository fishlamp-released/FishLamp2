//
//  FLDeletedObjectReference.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLDeletedObjectReference : NSObject {
@private
    __unsafe_unretained id _deletedObject;
    
#if DEBUG
    NSString* _debugInfo;
#endif
}

- (id) initWithObject:(id) object;
+ (FLDeletedObjectReference*) deletedObjectReference:(id) object;

/**
    do NOT, I repeat, NOT, send messages or use deletedObject in any other way than
    removing a reference to it or cleanup in a containing class (that has an __unsafed_unretained
    reference to it). If you call into it, the deletedObject is in the process of getting dealloc called on
    it so your code WILL crash and you will also crash all the interwebs. So there. You've been warned.
    
    for example, this is bad.
    
    - (void) myDeletedCallback:(FLDeletedObjectReference*) deletedObjectReference {
        [deletedObjectReference.deletedObject doSomethingThatWillCrash];
    }
    
    for example, this is ok

    - (void) myDeletedCallback:(FLDeletedObjectReference*) deletedObjectReference {
        
        if(myUnsafedUnretainedReference == deletedObjectReference.deletedObject) {
            myUnsafedUnretainedReference = nil;
        }
        
        [myListOfUnretainedObjects removeObject:
            [NSValue valueWithNonretainedObject:deletedObjectReference.deletedObject]];
 
    }
 
 */
@property (readonly, assign) id deletedObject;

@end