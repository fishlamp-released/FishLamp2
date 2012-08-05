//
//  FLLengthyTaskProgress.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLLengthyTaskProgressView.h"
#import "FLLegacyButton.h"
#import "FLModalProgressView.h"

@interface FLLengthyTaskProgressViewController ()
@property (readwrite, strong, nonatomic) FLLengthyTaskOperation* lengthyTaskOperation;
@end

@implementation FLLengthyTaskProgressViewController 

@synthesize lengthyTaskOperation = _operation;

- (id) initWithLengthyTaskOperation:(FLLengthyTaskOperation*) operation
                  progressViewClass:(Class) progressViewClass {
    
    self = [super initWithProgressViewClass:progressViewClass];
    if(self) {
        self.lengthyTaskOperation = operation;
        _operation.lengthyTaskOperationDelegate = self;
        self.contentMode = FLContentModeCentered;
    }
    
    return self;
}

#if FL_DEALLOC 
- (void) dealloc {
    [_operation release];
    [super dealloc];
}

#endif

- (void) viewDidLoad{
    [super viewDidLoad];
//    [self.progressView button].hidden = YES;
}

- (void) _updateProgress:(FLLengthyTaskOperation*) operation 
                    task:(FLLengthyTask*) task {
   
    [self performBlockOnMainThread:^{
        self.secondaryText = task.taskName;
        [self updateProgress:task.currentStep totalAmount:task.totalStepCount];
    }];
}

- (void) lengthyTaskOperation:(FLLengthyTaskOperation*) operation lengthyTaskWasPrepared:(FLLengthyTask*) task {
	[self _updateProgress:operation task:task];
}

- (void) lengthyTaskOperation:(FLLengthyTaskOperation*) operation lengthyTaskDidIncrementStep:(FLLengthyTask*) task {
	[self _updateProgress:operation task:task];
}

- (void) lengthyTaskOperation:(FLLengthyTaskOperation*) operation lengthyTaskWillBegin:(FLLengthyTask*) task {
	[self _updateProgress:operation task:task];
}

- (void) lengthyTaskOperation:(FLLengthyTaskOperation*) operation lengthyTaskDidChangeName:(FLLengthyTask*) task {
	[self _updateProgress:operation task:task];
}

- (void) lengthyTaskOperation:(FLLengthyTaskOperation*) operation lengthyTaskDidFinish:(FLLengthyTask*) task {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

+ (FLLengthyTaskProgressViewController*) lengthyTaskProgressViewController:(FLLengthyTaskOperation*) operation
                                                         progressViewClass:(Class) progressViewClass {
    return FLReturnAutoreleased([[FLLengthyTaskProgressViewController alloc] initWithLengthyTaskOperation:operation  progressViewClass: progressViewClass]);
}


@end