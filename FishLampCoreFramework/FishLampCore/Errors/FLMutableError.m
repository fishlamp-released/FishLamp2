//
//  FLMutableError.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLMutableError.h"
#import "FLProperties.h"

@interface FLMutableError ()
@end


@implementation FLMutableError

@synthesize userInfo = _mutableUserInfo;

FLSynthesizeDictionaryProperty(reason, setReason, NSString*, FLErrorReasonKey, _mutableUserInfo)
FLSynthesizeDictionaryProperty(comment, setComment, NSString*, FLErrorCommentKey, _mutableUserInfo)
FLSynthesizeDictionaryProperty(stackTrace, setStackTrace, FLStackTrace*, FLErrorStackTraceKey, _mutableUserInfo)
FLSynthesizeDictionaryProperty(errorDomain, setErrorDomain, id<FLErrorDomain>, FLErrorDomainKey, _mutableUserInfo)

//- (NSString*) description {
//    return _FLAssembleFailureReason(self.domain, self.reason, self.comment, self.stackTrace);
//}

#if FL_MRC 
- (void) dealloc {
    release_(_mutableUserInfo);
    super_dealloc_();
}
#endif

- (void) setUserInfo:(NSDictionary*) userInfo {
    FLRetainObject_(_mutableUserInfo, autorelease_([userInfo mutableCopy]));
}

- (id)initWithDomain:(NSString *)domain code:(NSInteger)code userInfo:(NSDictionary *) userInfo {
    self = [super initWithDomain:domain code:code userInfo:nil];
    if(self) {
        self.userInfo = userInfo;
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
    return autorelease_([[[self class] alloc] initWithError:error]);
}

+ (id) mutableErrorWithError:(NSError*) error stackTrace:(FLStackTrace*) stackTrace {
    return autorelease_([[[self class] alloc] initWithError:error stackTrace:stackTrace]);
}

- (void) setObject:(id) object forKey:(id) key {
   [_mutableUserInfo setObject:object forKey:key];
}

- (id) objectForKey:(id) key {
    return [_mutableUserInfo objectForKey:key];
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return [[FLMutableError alloc] initWithError:self];
}

- (BOOL) isEqual:(NSError*) error {
    return self.code == error.code && FLStringsAreEqual(self.domain, error.domain);
}

@end


