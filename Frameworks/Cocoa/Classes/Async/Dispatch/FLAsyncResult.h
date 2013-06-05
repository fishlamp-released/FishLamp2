//
//  FLResults.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/27/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FishLamp.h"

@protocol FLAsyncResult <NSObject>
@property (readonly, strong, nonatomic) NSError* error;
@end

@interface NSError (FLAsyncResult)
+ (id) failedResultError;
- (NSError*) error;
@end

@interface NSObject (FLAsyncResult)
- (NSError*) error;
@end

#define FLSuccessfullResult @"FLSuccessfullResult" 
#define FLFailedResult      [NSError failedResultError]

