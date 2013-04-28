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
@end

#define FLPromisedResult id 

@interface NSError (FLAsyncResult)
+ (id) failedResultError;
- (NSError*) error;
@end

@interface NSObject (FLAsyncResult)
- (NSError*) error;
@end

#define FLSuccessfullResult @"FLSuccessfullResult" 
#define FLFailedResult      [NSError failedResultError]

