//
//  GtExecuteLengthyTaskList.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtLengthyTask.h"
#import "GtAction.h"
#import "GtLengthyTaskProgressView.h"
#import "NSError+GtExtras.h"

#import "GtViewController.h"

@implementation GtLengthyTask (Mobile)

- (void) executeLengthyTask:(GtActionContext*) actionContext 
	operationNameForProgress:(NSString*) operationName
	finishedBlock:(GtErrorCallback) finishedBlock
{
    GtAssertIsValidString(operationName);
    
	finishedBlock = GtReturnAutoreleased([finishedBlock copy]);
	
    GtAssertNotNil(actionContext);
    
	[actionContext beginAction:[GtAction action] configureAction:^(id action){
		
		GtLengthyTaskOperation* operation = [GtLengthyTaskOperation lengthyTaskOperation:self operationName:operationName];
		GtLengthyTaskProgressView* progress = [GtLengthyTaskProgressView lengthyTaskProgressView:operation];
		[action actionDescription].actionType = GtActionDescriptionTypeUpdate;
		[action setProgressView:progress];
		[action setDidCompleteCallback:^{
			finishedBlock([action error]);
		}];
		[action queueOperation:operation configureOperation:nil];
	}];
}

@end