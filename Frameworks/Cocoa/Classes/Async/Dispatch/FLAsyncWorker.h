//
//  FLAsyncWorker.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLFinisher;

@protocol FLAsyncWorker <NSObject>
- (void) startWorking:(FLFinisher*) finisher;
@end



//@interface FLContextWorkerQueue : NSObject<FLAsyncWorker> 
//
//+ (id) asyncWorkerQueue;
//
//- (void) addWorker:(id<FLAsyncWorker>) worker;
//
//@end

