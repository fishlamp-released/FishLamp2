//
//  FLLengthyTaskProgress.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLLengthyTask.h"
#import "FLProgressViewController.h"

@interface FLLengthyTaskProgressViewController : FLProgressViewController<FLLengthyTaskDelegate> {
@private
    FLLengthyTask* _lengthyTask;
}

@property (readonly, strong, nonatomic) FLLengthyTask* lengthyTask;

- (id) initWithLengthyTask:(FLLengthyTask*) task
                  progressViewClass:(Class) progressViewClass;

+ (FLLengthyTaskProgressViewController*) lengthyTaskProgressViewController:(FLLengthyTask*) task
                                                         progressViewClass:(Class) progressViewClass;


@end

