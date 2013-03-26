//
//  NSException.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLErrorException.h"
#import "FLErrorDomainInfo.h"

//static FLExceptionHook s_exceptionHook = nil;

NSString* const FLErrorExceptionName = @"com.fishlamp.exception.error";

@implementation NSException (NSError)

FLSynthesizeAssociatedProperty(FLAssociationPolicyRetainNonatomic, _error, setError, NSError*);

- (NSError*) error {
    NSError* error = [self _error];
    if(!error) {
    
    }
    return error;
}

- (id)initWithName:(NSString *)aName reason:(NSString *)aReason userInfo:(NSDictionary *)aUserInfo error:(NSError*) error {
    self = [self initWithName:aName reason:aReason userInfo:aUserInfo];
    if(self) {
        self.error = error;
    }
    return self;
}

+ (NSException *)exceptionWithName:(NSString *)name reason:(NSString *)reason userInfo:(NSDictionary *)userInfo error:(NSError*) error {
    return FLAutorelease([[[self class] alloc] initWithName:name reason:reason userInfo:userInfo error:error]);
}


//- (id) initWithError:(NSError*)error name:(NSString*) name reason:(NSString*) reason {
//
//    FLAssertNotNil(error);
//
//    NSString* reason = error.localizedDescription;
//    NSString* name = FLErrorException
//
//    FLErrorDomainInfo* info = [[FLErrorDomainInfo instance] infoForErrorDomain:error.domain];
//        
//        
//        
//    [self setError:error];
//    
//    
//    
//    return [self initWithName:inName
//                       reason:inReason
//                     userInfo:inUserInfo];
//}
//

//+ (NSException*) errorException:(NSError*)error userInfo:(NSDictionary*) userInfo {
//    return [error createExceptionForError:userInfo];
//}

@end

@implementation FLErrorException
@end

