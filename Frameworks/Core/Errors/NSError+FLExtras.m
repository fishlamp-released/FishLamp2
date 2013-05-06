//
//	NSError.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "NSError+FLExtras.h"

#import "FLStringUtils.h"
#import "FLDebug.h"
#import "FLMutableError.h"
#import "FLErrorDomainInfo.h"
#import "NSDictionary+FLAdditions.h"
#import "FLErrorException.h"

NSString* const FLErrorCommentKey = @"com.fishlamp.error.comment";;
NSString* const FLErrorDomainKey = @"com.fishlamp.error.domain";

@implementation NSError (FLExtras)

FLSynthesizeDictionaryGetterProperty(underlyingError, NSError*, NSUnderlyingErrorKey, self.userInfo)
FLSynthesizeDictionaryGetterProperty(stringEncoding, NSArray*, NSStringEncodingErrorKey, self.userInfo)
FLSynthesizeDictionaryGetterProperty(URL, NSURL*, NSURLErrorKey, self.userInfo)
FLSynthesizeDictionaryGetterProperty(filePath, NSString*, NSFilePathErrorKey, self.userInfo)
FLSynthesizeDictionaryGetterProperty(comment, NSString*, FLErrorCommentKey, self.userInfo)
FLSynthesizeAssociatedProperty(FLAssociationPolicyRetainNonatomic, stackTrace, setStackTrace, FLStackTrace*);

+ (NSError*) errorWithDomain:(id) domain
                        code:(NSInteger) code
        localizedDescription:(NSString*) localizedDescription {

    return FLAutorelease([[[self class] alloc] initWithDomain:domain 
                                           code:code
                                         localizedDescription:localizedDescription
                                       userInfo:nil
                                        comment:nil]);
}

- (BOOL) isErrorCode:(NSInteger) code domain:(NSString*) domain {
	return code == self.code && FLStringsAreEqual(domain, self.domain);
}

- (BOOL) isErrorDomain:(NSString*) domain {
	return FLStringsAreEqual(domain, self.domain);
}

- (id) initWithDomain:(NSString*) domain
                 code:(NSInteger) code
 localizedDescription:(NSString*) localizedDescription
             userInfo:(NSDictionary *) userInfo
              comment:(NSString*) comment {

    NSString* errorCodeString = [[FLErrorDomainInfo instance] stringFromErrorCode:code withDomain:domain];

    NSString* commentAddOn = nil;
    if(errorCodeString) {
        commentAddOn = [NSString stringWithFormat:@"[domain:\"%@\" error code:%ld (%@)]", domain, (long) code, errorCodeString];
    }
    else {
        commentAddOn = [NSString stringWithFormat:@"[domain:\'%@\", error code:%ld]", domain, (long)code];
    }

#if DEBUG
    localizedDescription = [NSString stringWithFormat:@"%@ (%@) %@", comment, localizedDescription, commentAddOn];
#endif    

    if(comment) {
        comment = [NSString stringWithFormat:@"%@ %@", comment, commentAddOn];
    }
    else {
        comment = commentAddOn;
    }
    
    
    if(userInfo) {
        NSMutableDictionary* newUserInfo = FLMutableCopyWithAutorelease(userInfo);
    
//        [userInfo setObject:reason forKey:NSLocalizedFailureReasonErrorKey];
        [newUserInfo setObject:comment forKey:FLErrorCommentKey];
        [newUserInfo setObject:localizedDescription forKey:NSLocalizedDescriptionKey];
        
        userInfo = newUserInfo;
    }
    else {
        userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
//                                    reason, NSLocalizedFailureReasonErrorKey, 
                                    comment,  FLErrorCommentKey,
                                    localizedDescription, NSLocalizedDescriptionKey,
                                    nil];
    }
    

    return [self initWithDomain:domain code:code userInfo:userInfo];
}

+ (NSError*) errorWithDomain:(id) domain
                          code:(NSInteger)code
                        localizedDescription:localizedDescription
                      userInfo:(NSDictionary *)dict
                       comment:(NSString*) commentOrNil  {

    return FLAutorelease([[[self class] alloc] initWithDomain:domain
                                                        code:code
                                         localizedDescription:localizedDescription
                                                    userInfo:dict
                                                     comment:commentOrNil]);
}
@end


