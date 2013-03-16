//
//  FLMessageSender.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLObjectMessage.h"

@interface FLMessageSender : NSObject

- (BOOL) sendMessage:(SEL) messageSelector  
          toListener:(id) listener;

- (BOOL) sendMessage:(SEL) messageSelector  
          toListener:(id) listener
          withObject:(id) object;

- (BOOL) sendMessage:(SEL) messageSelector 
          toListener:(id) listener
          withObject:(id) object1
          withObject:(id) object2;

@end

