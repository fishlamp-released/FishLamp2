//
//  FLCollectionIterator.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLCollectionIterator <NSFastEnumeration>
@property (readonly, strong) id object;
- (id) nextObject;
@end

@interface NSArray (FLCollectionIterator)
- (id<FLCollectionIterator>) forwardIterator;
- (id<FLCollectionIterator>) reverseIterator;
@end

