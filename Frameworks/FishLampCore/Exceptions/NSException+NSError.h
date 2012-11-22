//
//  NSException+NSError.h
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRequired.h"

@interface NSException (NSError)

@property (readonly, copy, nonatomic) NSError* error;

- (id) initWithName:(NSString*) name
             reason:(NSString*) reason
           userInfo:(NSDictionary*) userInfo
              error:(NSError*)error;
                
+ (NSException*) exceptionWithName:(NSString *)name
                            reason:(NSString *)reason
                          userInfo:(NSDictionary *)userInfo
                             error:(NSError*)error;

+ (NSException*) exceptionWithError:(NSError*)error;

@end
    

