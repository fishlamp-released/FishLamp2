//
//  FLLengthyTaskProgress.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLLengthyTask.h"
#import "FLLengthyTaskOperation.h"

#import "FLProgressViewController.h"

@interface FLLengthyTaskProgressViewController : FLProgressViewController<FLLengthyTaskOperationDelegate> {
@private
    FLLengthyTaskOperation* _operation;
}

@property (readonly, strong, nonatomic) FLLengthyTaskOperation* lengthyTaskOperation;

- (id) initWithLengthyTaskOperation:(FLLengthyTaskOperation*) operation
                  progressViewClass:(Class) progressViewClass;

+ (FLLengthyTaskProgressViewController*) lengthyTaskProgressViewController:(FLLengthyTaskOperation*) operation
                                                         progressViewClass:(Class) progressViewClass;


@end

