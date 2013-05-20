//
//  GtStateMachine.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/18/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@protocol GtStateMachineDelegate;

@interface GtStateMachine : NSObject {
@private
	NSInteger m_state;
	id<GtStateMachineDelegate> m_delegate;
}
@property (readwrite, assign, nonatomic) id<GtStateMachineDelegate> delegate;

@property (readwrite, assign, nonatomic) NSInteger state;

- (void) didChangeState:(NSInteger) state;

@end

@protocol GtStateMachineDelegate
- (void) stateMachineDidChangeState:(GtStateMachine*) stateMachine;
@end

