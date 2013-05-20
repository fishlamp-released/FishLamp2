//
//  GtLengthyTaskOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtLengthyTask.h"
#import "GtOperation.h"

@protocol GtLengthyTaskOperationDelegate;

@interface GtLengthyTaskOperation : GtOperation<GtLengthyTaskDelegate> {
@private
	id<GtLengthyTaskOperationDelegate> m_lengthyTaskOperationDelegate;
	NSString* m_operationName;
}

@property (readwrite, retain, nonatomic) NSString* operationName;

@property (readwrite, assign, nonatomic) id<GtLengthyTaskOperationDelegate> lengthyTaskOperationDelegate;

- (id) initWithLengthyTaskInput:(GtLengthyTask*) task operationName:(NSString*) operationName;

+ (GtLengthyTaskOperation*) lengthyTaskOperation:(GtLengthyTask*) task  operationName:(NSString*) operationName;

@end

@protocol GtLengthyTaskOperationDelegate <NSObject>
- (void) lengthyTaskOperation:(GtLengthyTaskOperation*) operation lengthyTaskWasPrepared:(GtLengthyTask*) task;
- (void) lengthyTaskOperation:(GtLengthyTaskOperation*) operation lengthyTaskWillBegin:(GtLengthyTask*) task;
- (void) lengthyTaskOperation:(GtLengthyTaskOperation*) operation lengthyTaskDidIncrementStep:(GtLengthyTask*) task;
- (void) lengthyTaskOperation:(GtLengthyTaskOperation*) operation lengthyTaskDidChangeName:(GtLengthyTask*) task;
@end
