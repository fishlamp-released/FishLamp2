//
//  FLRunnable.h
//  Downloader
//
//  Created by Mike Fullerton on 11/25/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"
#import "FLDispatcher.h"
#import "FLResult.h"

@protocol FLRunnable <NSObject>
- (FLResult) runSynchronously; 

@optional
- (FLFinisher*) startInDispatcher:(id<FLDispatcher>) dispatcher;
@end


