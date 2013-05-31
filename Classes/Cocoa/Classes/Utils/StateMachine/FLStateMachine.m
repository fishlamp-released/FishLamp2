//
//  FLStateMachine.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/18/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLStateMachine.h"


@implementation FLStateMachine

@synthesize delegate = _delegate;
@synthesize state = _state;

- (void) setState:(NSInteger) state
{
    @synchronized(self) {
        _state = state; 
        [self didChangeState:state]; 
        if(_delegate)
        {
            [_delegate stateMachineDidChangeState:self];
        }	
    }
}	

- (void) didChangeState:(NSInteger) state
{
}

@end
