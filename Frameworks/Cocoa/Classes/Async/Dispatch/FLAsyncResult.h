//
//  FLResults.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "FLCocoaRequired.h"

@protocol FLAsyncResult <NSObject>
@property (readonly, strong, nonatomic) NSError* error;
@property (readonly, strong, nonatomic) id returnedObject;
@property (readonly, assign, nonatomic) NSInteger hint;
@property (readonly, assign, nonatomic) BOOL didFail;
@property (readonly, assign, nonatomic) BOOL didSucceed;
@end


@interface FLAsyncResult : NSObject<FLAsyncResult, NSCopying, NSMutableCopying> {
@private
    NSInteger _hint;
    id _returnedObject;
    NSError* _error;
}

- (id) initWithObject:(id) returnedObject 
                error:(NSError*) error 
                 hint:(NSInteger) hint;

// successfull results

+ (id) asyncResult;

+ (id) asyncResult:(id) returnedObject;

+ (id) asyncResult:(id) returnedObject 
              hint:(NSInteger) hint;

+ (id) asyncResultWithHint:(NSInteger) hint;

// failed results

+ (id) failedAsyncResult;

+ (id) failedAsyncResult:(NSError*) error;

+ (id) failedAsyncResult:(NSError*) error
          returnedObject:(id) returnedObject;

+ (id) failedAsyncResult:(NSError*) error
                    hint:(NSInteger) hint;

+ (id) failedAsyncResult:(NSError*) error
          returnedObject:(id) returnedObject
                    hint:(NSInteger) hint;

+ (id) failedAsyncResultWithHint:(NSInteger) hint;

@end

@interface FLMutableAsyncResult : FLAsyncResult

@property (readwrite, strong, nonatomic) NSError* error;
@property (readwrite, strong, nonatomic) id returnedObject;
@property (readwrite, assign, nonatomic) NSInteger hint;

@end

@interface NSError (FLAsyncResult)
+ (id) failedResultError;
@end

@interface NSObject (FLAsyncResult)
- (id<FLAsyncResult>) asAsyncResult;
- (id<FLAsyncResult>) asAsyncResultWithHint:(NSInteger) hint;
@end

#define FLSuccessfullResult [FLAsyncResult asyncResult] 
#define FLFailedResult      [FLAsyncResult failedAsyncResult]
