//
//  FLMutableError.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLErrorDomain.h"
#import "NSError+FLExtras.h"

extern NSString* const FLErrorCodeLocationKey;
extern NSString* const FLErrorCommentKey;
extern NSString* const FLErrorReasonKey;
extern NSString* const FLErrorDomainKey;

@interface FLMutableError : NSError<NSMutableCopying> {
@private
    NSMutableDictionary* _mutableUserInfo;
}

@property (readwrite, strong, nonatomic) NSString* reason;
@property (readwrite, strong, nonatomic) NSString* comment;
@property (readwrite, strong, nonatomic) FLStackTrace* stackTrace;

@property (readonly, strong, nonatomic) NSMutableDictionary* mutableUserInfo;

- (id) initWithError:(NSError*) error;
- (id) initWithError:(NSError*) error  stackTrace:(FLStackTrace*) stackTrace;

+ (id) mutableErrorWithError:(NSError*) error;
+ (id) mutableErrorWithError:(NSError*) error stackTrace:(FLStackTrace*) stackTrace;

@end