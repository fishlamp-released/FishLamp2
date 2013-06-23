//
//  FLStateMachine.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/18/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

@protocol FLStateMachineDelegate;

@interface FLStateMachine : NSObject {
@private
	NSInteger _state;
	__unsafe_unretained id<FLStateMachineDelegate> _delegate;
}
@property (readwrite, assign, nonatomic) id<FLStateMachineDelegate> delegate;

@property (readwrite, assign, nonatomic) NSInteger state;

- (void) didChangeState:(NSInteger) state;

@end

@protocol FLStateMachineDelegate
- (void) stateMachineDidChangeState:(FLStateMachine*) stateMachine;
@end

