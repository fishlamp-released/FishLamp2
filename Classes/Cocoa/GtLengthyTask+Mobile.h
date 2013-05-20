//
//  GtExecuteLengthyTaskList.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtLengthyTask.h"
#import "GtAction.h"
#import "NSError+GtExtras.h"

@class GtViewController;

@interface GtLengthyTask (Mobile)

- (void) executeLengthyTask:(GtActionContext*) actionContext 
	operationNameForProgress:(NSString*) operationName
	finishedBlock:(GtErrorCallback) finishBlock;

@end