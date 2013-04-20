//
//  FLResults.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#import "FLCocoaRequired.h"

typedef id FLResult;

@interface NSObject (FLResult) 
@property (readonly, strong) NSError* error;
@property (readonly, assign) BOOL isErrorResult;
@end

#define FLSuccessfullResult [NSNumber numberWithBool:YES] 
#define FLFailedResult      [NSError failedResultError]

@interface NSError (FLResult)
+ (id) failedResultError;
@end

