//
//  FLWorkerParent.h
//  FLCore
//
//  Created by Mike Fullerton on 11/17/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFinisher.h"

typedef void (^FLAsyncTaskBlock)(id task);

@interface FLAsyncTask : NSObject {
@private
    FLAsyncTaskBlock _willRunBlock;
    FLAsyncTaskBlock _runBlock;
    FLAsyncTaskBlock _didRunBlock;
}
@end

typedef void (^FLAsyncFinisherBlock)(FLFinisher* asyncTask);