//
//  FLMutableError.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/28/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if REFACTOR
#import "FLMutableError.h"

@interface FLMutableError ()
@end

NSString* const FLErrorStackTraceKey = @"FLErrorStackTraceKey";

@implementation FLMutableError

@synthesize userInfo = _mutableUserInfo;

FLSynthesizeDictionaryProperty(comment, setComment, NSString*, FLErrorCommentKey, _mutableUserInfo)
FLSynthesizeDictionaryProperty(stackTrace, setStackTrace, FLStackTrace*, FLErrorStackTraceKey, _mutableUserInfo)

// sdk properies
FLSynthesizeDictionaryProperty(underlyingError, setUnderlyingError, NSError*, NSUnderlyingErrorKey, _mutableUserInfo)
FLSynthesizeDictionaryProperty(localizedDescription, setLocalizedDescription, NSString*, NSLocalizedDescriptionKey, _mutableUserInfo)
FLSynthesizeDictionaryProperty(recoverySuggestion, setRecoverySuggestion, NSString*, NSLocalizedRecoverySuggestionErrorKey, _mutableUserInfo)
FLSynthesizeDictionaryProperty(localizedFailureReason, setLocalizedFailureReason, NSString*, NSLocalizedFailureReasonErrorKey, _mutableUserInfo)
FLSynthesizeDictionaryProperty(localizedRecoveryOptions, setLocalizedRecoveryOptions, NSArray*, NSLocalizedRecoveryOptionsErrorKey, _mutableUserInfo)
FLSynthesizeDictionaryProperty(recoveryAttempter, setRecoveryAttempter, id, NSRecoveryAttempterErrorKey, _mutableUserInfo)
FLSynthesizeDictionaryProperty(helpAnchor, setHelpAnchor, NSArray*, NSHelpAnchorErrorKey, _mutableUserInfo)
FLSynthesizeDictionaryProperty(stringEncoding, setStringEncoding, NSArray*, NSStringEncodingErrorKey, _mutableUserInfo)
FLSynthesizeDictionaryProperty(URL, setURL, NSURL*, NSURLErrorKey, _mutableUserInfo)
FLSynthesizeDictionaryProperty(filePath, setFilePath, NSString*, NSFilePathErrorKey, _mutableUserInfo)

//- (NSString*) description {
//    return _FLAssembleFailureReason(self.domain, self.reason, self.comment, self.stackTrace);
//}

#if FL_MRC 
- (void) dealloc {
    FLRelease(_mutableUserInfo);
    FLSuperDealloc();
}
#endif

- (void) setUserInfo:(NSDictionary*) userInfo {
    FLSetObjectWithRetain(_mutableUserInfo, FLAutorelease([userInfo mutableCopy]));
}

- (id)initWithDomain:(NSString *)domain code:(NSInteger)code userInfo:(NSDictionary *) userInfo {

    FLAssertStringIsNotEmpty(domain);

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
    return FLAutorelease([[[self class] alloc] initWithError:error]);
}

+ (id) mutableErrorWithError:(NSError*) error stackTrace:(FLStackTrace*) stackTrace {
    return FLAutorelease([[[self class] alloc] initWithError:error stackTrace:stackTrace]);
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


#endif