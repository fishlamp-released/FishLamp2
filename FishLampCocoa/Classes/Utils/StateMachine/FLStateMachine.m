//
//  FLStateMachine.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/18/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
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
