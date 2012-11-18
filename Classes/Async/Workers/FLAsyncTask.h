//
//  FLWorkerParent.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/17/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLFinisher.h"

@protocol FLAsyncTask <FLFinisher>
@end

typedef void (^FLAsyncTaskBlock)(id asyncTask);