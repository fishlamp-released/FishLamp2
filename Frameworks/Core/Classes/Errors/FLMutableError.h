//
//  FLMutableError.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLRequired.h"

#import "FLErrorDomainInfo.h"
#import "NSError+FLExtras.h"

extern NSString* const FLErrorStackTraceKey;

@interface FLMutableError : NSError<NSMutableCopying> {
@private
    NSMutableDictionary* _mutableUserInfo;
}

@property (readwrite, copy, nonatomic) NSDictionary* userInfo;

// these all set properties in the userInfo

// fishlamp properties
@property (readwrite, strong, nonatomic) NSString* comment;
@property (readwrite, strong, nonatomic) FLStackTrace* stackTrace;

// sdk properties
@property (readwrite, strong, nonatomic) NSError* underlyingError;
@property (readwrite, strong, nonatomic) NSString* localizedDescription;
@property (readwrite, strong, nonatomic) NSString* recoverySuggestion;
@property (readwrite, strong, nonatomic) NSString* localizedFailureReason;
@property (readwrite, strong, nonatomic) NSArray* localizedRecoveryOptions;
@property (readwrite, strong, nonatomic) id recoveryAttempter;
@property (readwrite, strong, nonatomic) NSString* stringEncoding;
@property (readwrite, strong, nonatomic) NSURL* URL;
@property (readwrite, strong, nonatomic) NSString* filePath; 

- (void) setObject:(id) object forKey:(id) key;
- (id) objectForKey:(id) key;

- (id) initWithError:(NSError*) error;
- (id) initWithError:(NSError*) error  stackTrace:(FLStackTrace*) stackTrace;

+ (id) mutableErrorWithError:(NSError*) error;
+ (id) mutableErrorWithError:(NSError*) error stackTrace:(FLStackTrace*) stackTrace;

@end