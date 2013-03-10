//
//  FLResults.h
//  Downloader
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "FLCocoaRequired.h"

typedef id FLResult;

@interface NSError (FLResult)
+ (id) failedResultError;
@end

@protocol FLResultObject <NSObject>
@property (readonly, strong) NSError* error;
@property (readonly, strong) id result;
@property (readonly, assign) BOOL succeeded;
@property (readonly, assign) BOOL failed;
@end

@interface FLResultObject : NSObject<FLResultObject> {
@private
}
@end

@interface FLSuccessfulResult : FLResultObject
+ (id) successfullResult;
@end

@interface FLMutableResult : NSObject<FLResultObject> {
@private
    id _result;
}

@property (readwrite, strong) id result;

- (id) initWithResult:(id) result;

+ (id) mutableResultWithResult:(id) result;
+ (id) mutableResult;

@end

// FLSuccessfulResult is a singleton.
#define FLSuccessfullResult [FLSuccessfulResult successfullResult] 

#define FLFailedResult      [NSError failedResultError]

#define FLConfirmResultType(__RESULT__, __EXPECTED_RESULT_TYPE__) \
            FLAssertObjectIsType(FLThrowIfError(__RESULT__), __EXPECTED_RESULT_TYPE__)

#define FLResultType(__TYPE__) FLResult