//
//  FLResults.h
//  Downloader
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLResulting.h"
#import "FLSuccessfulResult.h"
#import "FLMutableResult.h"
#import "NSError+FLResult.h"

typedef id FLResult;

// this is a singleton.
#define FLSuccessfullResult [FLSuccessfulResult successfullResult]
#define FLFailedResult      [NSError failedResultError]

typedef void (^FLResultBlock)(FLResult result);
typedef void (^FLCompletionBlock)(FLResult result);
