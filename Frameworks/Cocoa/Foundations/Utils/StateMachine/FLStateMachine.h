//
//  FLStateMachine.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/18/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCore.h"

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

