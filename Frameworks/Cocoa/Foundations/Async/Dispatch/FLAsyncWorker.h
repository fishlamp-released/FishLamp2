//
//  FLAsyncWorker.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLFinisher;
@class FLAsyncWorkerContext;

@protocol FLAsyncWorker <NSObject>
- (void) startWorking:(FLFinisher*) finisher;
- (void) didMoveToAsyncWorkerContext:(FLAsyncWorkerContext*) context;
@end

@interface FLAsyncWorker : NSObject<FLAsyncWorker> {
@private
    __unsafe_unretained id _context;
}

@property (readwrite, assign) id context;

@end