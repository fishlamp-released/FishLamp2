//
//  FLLengthyTaskProgress.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
        self.contentMode = FLRectLayoutCentered;
    }
    
    return self;
}

#if FL_MRC 
- (void) dealloc {
    FLRelease(_lengthyTask);
    FLSuperDealloc();
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
    return FLAutorelease([[FLLengthyTaskProgressViewController alloc] initWithLengthyTask:task  progressViewClass:progressViewClass]);
}


@end