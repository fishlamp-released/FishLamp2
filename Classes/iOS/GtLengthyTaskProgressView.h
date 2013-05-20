//
//  GtLengthyTaskProgress.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/2/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtModalProgressView.h"
#import "GtLengthyTask.h"
#import "GtLengthyTaskOperation.h"

@interface GtLengthyTaskProgressView : GtModalProgressView<GtLengthyTaskOperationDelegate> {
@private
    GtLengthyTaskOperation* m_operation;
    GtLengthyTask* m_task;
}

- (id) initWithLengthyTaskOperation:(GtLengthyTaskOperation*) operation;

+ (GtLengthyTaskProgressView*) lengthyTaskProgressView:(GtLengthyTaskOperation*) operation;

@end
