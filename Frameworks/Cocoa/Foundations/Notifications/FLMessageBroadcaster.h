//
//  FLMessageBroadcaster.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObjectMessage.h"

@interface FLMessageBroadcaster : NSObject {
@private 
    NSMutableArray* _listeners;
}

- (void) sendMessageToListeners:(SEL) messageSelector;

- (void) sendMessageToListeners:(SEL) messageSelector  
                     withObject:(id) object;

- (void) sendMessageToListeners:(SEL) messageSelector 
                     withObject:(id) object1
                     withObject:(id) object2;

- (void) addListener:(id) listener;

- (void) removeListener:(id) listener;

- (void) sendObjectMessageToListeners:(FLObjectMessage *)message;

@end
