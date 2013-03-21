//
//  FLCancelError.h
//  FishLampCore
//
//  Created by Mike Fullerton on 3/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString* const FLCancelExceptionName;

@interface FLCancelError : NSError
@end

@interface FLCancelException : FLErrorException
@end

@interface NSError (FLCancelling)
+ (NSError*) cancelError;
@property (readonly, nonatomic, assign) BOOL isCancelError;
@end
