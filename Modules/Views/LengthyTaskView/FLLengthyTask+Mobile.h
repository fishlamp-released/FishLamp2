//
//  FLExecuteLengthyTaskList.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLLengthyTask.h"
#import "FLAction.h"
#import "NSError+FLExtras.h"

@class FLViewController;

@interface FLLengthyTask (Mobile)

- (void) executeLengthyTask:(FLActionContext*) actionContext 
   operationNameForProgress:(NSString*) operationName
          progressViewClass:(Class) progressViewClass
              finishedBlock:(FLErrorCallback) finishedBlock;

@end