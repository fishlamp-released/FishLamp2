//
//  FLMutableError.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLMutableError.h"

@interface FLMutableError ()
@end

@implementation FLMutableError

@synthesize mutableUserInfo = _mutableUserInfo;

@dynamic reason;
@dynamic comment;
@dynamic stackTrace;

//- (NSString*) description {
//    return _FLAssembleFailureReason(self.domain, self.reason, self.comment, self.stackTrace);
//}

#if FL_NO_ARC 
- (void) dealloc {
    FLRelease(_mutableUserInfo);
    FLSuperDealloc();
}
#endif

- (void) setUserInfo:(NSDictionary*) userInfo {
    FLAssignObject(_mutableUserInfo, FLReturnAutoreleased([userInfo mutableCopy]));
}

- (id)initWithDomain:(NSString *)domain code:(NSInteger)code userInfo:(NSDictionary *)dict {
    _mutableUserInfo = [dict mutableCopy];
    self = [super initWithDomain:domain code:code userInfo:_mutableUserInfo];
    if(self) {
    }
    
    return self;
}

- (id) initWithError:(NSError*) error {
    return [self initWithDomain:error.domain code:error.code userInfo:error.userInfo];
}

- (id) initWithError:(NSError*) error  stackTrace:(FLStackTrace*) stackTrace {
    self = [self initWithDomain:error.domain code:error.code userInfo:error.userInfo];
    if(self) {
        self.stackTrace = stackTrace;
    }
    return self;
}


+ (id) mutableErrorWithError:(NSError*) error {
    return FLReturnAutoreleased([[[self class] alloc] initWithError:error]);
}

+ (id) mutableErrorWithError:(NSError*) error stackTrace:(FLStackTrace*) stackTrace {
    return FLReturnAutoreleased([[[self class] alloc] initWithError:error stackTrace:stackTrace]);

}

- (void) setComment:(NSString*) comment {
    FLAssert_v(self.userInfo == self.mutableUserInfo, @"user info was changed");

    [self.mutableUserInfo setObject: [comment stringWithRemovingQuotes] forKey:FLErrorCommentKey];
}

- (void) setReason:(NSString*) reason {
    FLAssert_v(self.userInfo == self.mutableUserInfo, @"user info was changed");
    [self.mutableUserInfo setObject: [reason stringWithRemovingQuotes] forKey:FLErrorReasonKey];
}

- (void) setCodeLocation:(FLStackTrace*) stackTrace {
    FLAssert_v(self.userInfo == self.mutableUserInfo, @"user info was changed");
    [self.mutableUserInfo setObject:stackTrace forKey:FLErrorCodeLocationKey];
}

- (void) setErrorDomain:(FLErrorDomain*) domain {
    FLAssert_v(self.userInfo == self.mutableUserInfo, @"user info was changed");
    [self.mutableUserInfo setObject:domain forKey:FLErrorDomainKey];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [[FLMutableError alloc] initWithError:self];
}

- (BOOL) isEqual:(NSError*) error {
    return self.code == error.code && FLStringsAreEqual(self.domain, error.domain);
}

@end


