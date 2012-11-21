//
//  FLSelectorQueue.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLSelectorQueue : NSObject {
@private
    SEL* _queue;
    uint32_t _capacity;
    int32_t _last;
    int32_t _walker;
    
    NSMutableArray* _array;
}
@property (readonly, assign) SEL nextSelector;

- (id) initWithCapacity:(uint32_t) capacity;

- (void) addSelector:(SEL) sel;

@end
