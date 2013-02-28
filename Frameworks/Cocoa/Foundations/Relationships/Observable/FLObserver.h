//
//  FLObserver.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FLObserving) 
- (void) postObservation:(SEL) selector 
              withObject:(id) object;

- (void) postObservation:(SEL) selector 
               withObject:(id) object1
              withObject:(id) object2;

- (void) postObservation:(SEL) selector 
              withObject:(id) object1
              withObject:(id) object2 
              withObject:(id) object3;
@end


