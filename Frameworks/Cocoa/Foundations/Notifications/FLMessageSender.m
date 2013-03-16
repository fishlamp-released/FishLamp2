//
//  FLMessageSender.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLMessageSender.h"

@implementation FLMessageSender 

- (BOOL) sendMessage:(SEL) observationSelector 
              toListener:(id) listener {
    
    if([listener respondsToSelector:observationSelector]) {
        FLObjectMessage* message = [FLObjectMessage objectMessage:observationSelector withObject:self];
        [self sendObjectMessage:message toListener:listener];
        return YES;
    }

    return NO;
}
             
- (BOOL) sendMessage:(SEL) observationSelector 
              toListener:(id) listener
              withObject:(id) object1 {
    
    if([listener respondsToSelector:observationSelector]) {
        FLObjectMessage* message = [FLObjectMessage objectMessage:observationSelector withObject:self withObject:object1];
        [self sendObjectMessage:message toListener:listener];
        return YES;
    }
    return NO;
}

- (BOOL) sendMessage:(SEL) observationSelector  
              toListener:(id) listener
              withObject:(id) object1
              withObject:(id) object2  {

    if([listener respondsToSelector:observationSelector]) {
        FLObjectMessage* message = [FLObjectMessage objectMessage:observationSelector withObject:self withObject:object1 withObject:object2];
        [self sendObjectMessage:message toListener:listener];
        return YES;
    }

    return NO;
}             
              
@end

