//
//  FLErrorException.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"

extern NSString* const FLErrorExceptionName;

@interface NSException (NSError)

@property (readwrite, copy, nonatomic) NSError* error;

+ (NSException *)exceptionWithName:(NSString *)name 
                            reason:(NSString *)reason 
                          userInfo:(NSDictionary *)userInfo 
                             error:(NSError*) error;
                             
- (id)initWithName:(NSString *)aName 
            reason:(NSString *)aReason 
          userInfo:(NSDictionary *)aUserInfo 
             error:(NSError*) error;

@end

@interface FLErrorException : NSException
@end
