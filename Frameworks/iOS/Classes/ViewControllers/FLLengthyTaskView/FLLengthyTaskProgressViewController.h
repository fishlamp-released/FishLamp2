//
//  FLLengthyTaskProgress.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

