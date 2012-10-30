//
//  FLWorkFinisher.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLResult.h"

@protocol FLFinisher <NSObject>

@property (readonly, assign) BOOL isFinished;

// this is nil until setFinished isCalled
@property (readonly, strong) FLResult result;

// send successfull result with no payload
- (void) setFinished;

// send a either successful or failed result
- (void) setFinishedWithSuccess:(BOOL) success;

// send a successfull result with object payload (nil object is ok)
- (void) setFinishedWithOutput:(id) output;

// send a failed result with an error payload (nil error is ok)
- (void) setFinishedWithError:(NSError*) error;

// send your own result object.
- (void) setFinishedWithResult:(FLResult) result;

@end

typedef id<FLFinisher> FLFinisher;

typedef void (^FLAsyncBlock)(FLFinisher finisher);
