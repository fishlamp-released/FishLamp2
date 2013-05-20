//
//  GtStateMachine.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/18/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtStateMachine.h"


@implementation GtStateMachine

@synthesize delegate = m_delegate;
@synthesize state = m_state;

- (void) setState:(NSInteger) state
{
    @synchronized(self) {
        m_state = state; 
        [self didChangeState:state]; 
        if(m_delegate)
        {
            [m_delegate stateMachineDidChangeState:self];
        }	
    }
}	

- (void) didChangeState:(NSInteger) state
{
}

@end
