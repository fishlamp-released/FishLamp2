//
//	NSError.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "NSError+FLExtras.h"
#import "FishLampCore.h"

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

    NSString* errorCodeString = nil; // [[FLErrorDomainInfo instance] stringFromErrorCode:code withDomain:domain];

    NSString* commentAddOn = nil;
    if(errorCodeString) {
        commentAddOn = [NSString stringWithFormat:@"[%@:%ld (%@)]", domain, (long) code, errorCodeString];
    }
    else {
        commentAddOn = [NSString stringWithFormat:@"[%@:%ld]", domain, (long)code];
    }

#if DEBUG
    if(comment) {
        localizedDescription = [NSString stringWithFormat:@"%@ (%@) %@", localizedDescription, comment, commentAddOn];
    }
    else {
        localizedDescription = [NSString stringWithFormat:@"%@ %@", localizedDescription, commentAddOn];
    }
    
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


