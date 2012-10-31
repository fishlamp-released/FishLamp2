//
//	NSError.h
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCoreFlags.h"
#import "FLObjc.h"
#import "FLErrorDomain.h"
#import "FLStackTrace.h"

@interface NSError (FLExtras) 

+ (NSError*) errorWithDomain:(NSString*) domain
                        code:(NSInteger) code
        localizedDescription:(NSString*) localizedDescription;

- (BOOL) isErrorCode:(NSInteger) code domain:(NSString*) domain;

- (BOOL) isDomain:(NSString*) domain;

// Network errors 
// TODO move these
@property (readonly, nonatomic) BOOL didLoseNetwork;
@property (readonly, nonatomic) BOOL isNotConnectedToInternetError;
@end

@interface NSError (FLCancel)
+ (NSError*) cancelError;
@property (readonly, nonatomic, assign) BOOL isCancelError;
@end


/** 
    To throw an error, see FLExceptions.h
    Use FLThrowErrorCode_v.
 */
@interface NSError (FLErrorDomain)

@property (readonly, strong, nonatomic) NSString* reason;
@property (readonly, strong, nonatomic) NSString* comment;
@property (readonly, strong, nonatomic) FLErrorDomain* errorDomain;
@property (readonly, strong, nonatomic) FLStackTrace* stackTrace;

- (id) initWithDomain:(id) domainStringOrObject
                       code:(NSInteger) code
                   userInfo:(NSDictionary *)dict
                     reason:(NSString*) reason
                    comment:(NSString*) comment
                 stackTrace:(FLStackTrace*) stackTrace;

+ (NSError*) errorWithDomain:(id) domainStringOrObject
                              code:(NSInteger)code
                          userInfo:(NSDictionary *)dict
                            reason:(NSString*) reasonOrNil
                           comment:(NSString*) commentOrNil
                        stackTrace:(FLStackTrace*) stackTrace;


@end