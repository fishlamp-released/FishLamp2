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

@interface FLLengthyTaskOperation : FLOperation {
}

- (id) initWithLengthyTask:(FLLengthyTask*) task;

+ (FLLengthyTaskOperation*) lengthyTaskOperation:(FLLengthyTask*) task;

@end
