//
//  FLLengthyTaskOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLLengthyTask.h"
#import "FLOperation.h"

@protocol FLLengthyTaskOperationDelegate;

@interface FLLengthyTaskOperation : FLOperation<FLLengthyTaskDelegate> {
@private
	__unsafe_unretained id<FLLengthyTaskOperationDelegate> _lengthyTaskOperationDelegate;
	NSString* _operationName;
}

@property (readwrite, retain, nonatomic) NSString* operationName;

@property (readwrite, assign, nonatomic) id<FLLengthyTaskOperationDelegate> lengthyTaskOperationDelegate;

- (id) initWithLengthyTaskInput:(FLLengthyTask*) task operationName:(NSString*) operationName;

+ (FLLengthyTaskOperation*) lengthyTaskOperation:(FLLengthyTask*) task  operationName:(NSString*) operationName;

@end

@protocol FLLengthyTaskOperationDelegate <NSObject>
- (void) lengthyTaskOperation:(FLLengthyTaskOperation*) operation lengthyTaskWasPrepared:(FLLengthyTask*) task;
- (void) lengthyTaskOperation:(FLLengthyTaskOperation*) operation lengthyTaskWillBegin:(FLLengthyTask*) task;
- (void) lengthyTaskOperation:(FLLengthyTaskOperation*) operation lengthyTaskDidIncrementStep:(FLLengthyTask*) task;
- (void) lengthyTaskOperation:(FLLengthyTaskOperation*) operation lengthyTaskDidChangeName:(FLLengthyTask*) task;
- (void) lengthyTaskOperation:(FLLengthyTaskOperation*) operation lengthyTaskDidFinish:(FLLengthyTask*) task;
@end
