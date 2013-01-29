//
//  FLObserver.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLObserver <NSObject>
- (void) postObservation:(SEL) selector fromObject:(id) object;

- (void) postObservation:(SEL) selector 
              withObject:(id) object
               fromObject:(id) object;

- (void) postObservation:(SEL) selector 
              withObject:(id) object1 
              withObject:(id) object2
               fromObject:(id) object;
@end              

@interface FLObserver : NSObject<FLObserver> {
@private
    id _listener;
}
@property (readonly, strong) id listener

- (id) initWithListener:(id) listener;
+ (id) observer:(id) listener;

@end


//@interface FLObserver : NSObject {
//@private
//    dispatch_block_t _willStart;
//    FLFinisherResultBlock _didFinish;
//}
//
//@property (readwrite, strong) dispatch_block_t willStart;
//@property (readwrite, strong) FLFinisherResultBlock didFinish;
//
//@end

