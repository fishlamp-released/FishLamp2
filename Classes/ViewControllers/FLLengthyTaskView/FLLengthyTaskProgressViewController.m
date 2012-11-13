//
//  FLLengthyTaskProgress.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLLengthyTaskProgressViewController.h"

@interface FLLengthyTaskProgressViewController ()
@property (readwrite, strong, nonatomic) FLLengthyTask* lengthyTask;
@end

@implementation FLLengthyTaskProgressViewController 

@synthesize lengthyTask = _lengthyTask;

- (id) initWithLengthyTask:(FLLengthyTask*) task
                  progressViewClass:(Class) progressViewClass {
                  
    self = [super initWithProgressViewClass:progressViewClass];
    if(self) {
        self.lengthyTask = task;
        self.lengthyTask.delegate = self;
        self.contentMode = FLContentModeCentered;
    }
    
    return self;
}

#if FL_MRC 
- (void) dealloc {
    release_(_lengthyTask);
    super_dealloc_();
}

#endif

- (void) _updateProgress:(FLLengthyTask*) task {
   
    [self performBlockOnMainThread:^{
        self.secondaryText = task.taskName;
        [self updateProgress:task.stepCount totalAmount:task.totalStepCount];
    }];
}

- (BOOL) lengthyTaskShouldBegin:(FLLengthyTask*) task {
    return YES;
}

- (void) lengthyTaskWillBegin:(FLLengthyTask*) task {
	[self _updateProgress:task];
}

- (void) lengthyTaskDidIncrementStep:(FLLengthyTask*) task {
	[self _updateProgress:task];
}

- (void) lengthyTaskDidChangeName:(FLLengthyTask*) task {
	[self _updateProgress:task];
}

- (void) lengthyTaskDidFinish:(FLLengthyTask*) task {
	[self _updateProgress:task];
}

+ (FLLengthyTaskProgressViewController*) lengthyTaskProgressViewController:(FLLengthyTask*) task
                                                         progressViewClass:(Class) progressViewClass {
    return autorelease_([[FLLengthyTaskProgressViewController alloc] initWithLengthyTask:task  progressViewClass:progressViewClass]);
}


@end