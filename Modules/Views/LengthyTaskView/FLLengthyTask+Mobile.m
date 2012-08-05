//
//  FLExecuteLengthyTaskList.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLLengthyTask.h"
#import "FLAction.h"
#import "FLLengthyTaskProgressView.h"
#import "NSError+FLExtras.h"

#import "FLViewController.h"

@implementation FLLengthyTask (Mobile)

- (void) executeLengthyTask:(FLActionContext*) actionContext 
   operationNameForProgress:(NSString*) operationName
          progressViewClass:(Class) progressViewClass
              finishedBlock:(FLErrorCallback) finishedBlock {

    FLAssertStringIsNotEmpty(operationName);
    
	finishedBlock = FLReturnAutoreleased([finishedBlock copy]);
	
    FLAssertIsNotNil(actionContext);
    
    FLAction* action = [FLAction action];
    action.actionDescription.actionType = FLActionDescriptionTypeUpdate;

    FLLengthyTaskOperation* operation = [FLLengthyTaskOperation lengthyTaskOperation:self operationName:operationName];
    [action queueOperation:operation];

    action.progressController = [FLLengthyTaskProgressViewController lengthyTaskProgressViewController:operation progressViewClass:progressViewClass];
    action.onFinished = ^(id theAction){
        finishedBlock([theAction error]);
    };

    [actionContext beginAction:action];
}
@end