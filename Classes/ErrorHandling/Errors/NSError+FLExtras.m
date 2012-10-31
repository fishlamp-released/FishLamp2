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
#import "FLErrorDomain.h"
NSString* const FLErrorStackTraceKey = @"com.fishlamp.error.stackTrace";
NSString* const FLErrorCommentKey = @"com.fishlamp.error.comment";;
NSString* const FLErrorReasonKey = @"com.fishlamp.error.reason";
NSString* const FLErrorDomainKey = @"com.fishlamp.error.domain";


@implementation NSError (FLExtras)

+ (NSError*) errorWithDomain:(NSString*) domain
                        code:(NSInteger) code
        localizedDescription:(NSString*) localizedDescription {

    return autorelease_([[NSError alloc] initWithDomain:domain
                                                           code:code
                                                       userInfo:[NSDictionary dictionaryWithObject:localizedDescription forKey:NSLocalizedDescriptionKey]]);
}

- (BOOL) isErrorCode:(NSInteger) code domain:(NSString*) domain {
	return code == self.code && FLStringsAreEqual(domain, self.domain);
}

- (BOOL) isDomain:(NSString*) domain {
	return FLStringsAreEqual(domain, self.domain);
}

// TODO(move these network errors into a NSError category in the network code)



- (BOOL) didLoseNetwork {
	return	FLStringsAreEqual(NSURLErrorDomain, self.domain) &&
			((self.code == NSURLErrorNetworkConnectionLost) || 
			(self.code == NSURLErrorNotConnectedToInternet));
}


- (BOOL) isNotConnectedToInternetError {
	return FLStringsAreEqual(NSURLErrorDomain, self.domain) && self.code == NSURLErrorNotConnectedToInternet;
}

@end

@implementation NSError (FLCancelError)
+ (NSError*) cancelError {
    return [NSError errorWithDomain:FLFrameworkErrorDomainName
                                   code:FLCancelErrorCode
                   localizedDescription:NSLocalizedString(@"Cancelled", @"used in cancel error localized description")];

}

- (BOOL) isCancelError {
	return	FLStringsAreEqual(FLFrameworkErrorDomainName, self.domain) &&
			self.code == FLCancelErrorCode; 
}

@end

@implementation NSError (FLErrorDomain)


- (FLStackTrace*) stackTrace {
    return [self.userInfo objectForKey:FLErrorStackTraceKey];
}

- (NSString*) reason {
    return [self.userInfo objectForKey:FLErrorReasonKey];
}

- (NSString*) comment {
    return [self.userInfo objectForKey:FLErrorCommentKey];
}

- (FLErrorDomain*) errorDomain {
    return [self.userInfo objectForKey:FLErrorDomainKey];
}

NS_INLINE
NSString* makeDescriptionString(NSString* reason, NSString* comment) {

    if(FLStringIsNotEmpty(reason) && FLStringIsNotEmpty(comment)) {
        return [NSString stringWithFormat:@"%@ (%@)", reason, comment];
    }
    
    return reason;

}

//- (id) initWithDomain:(NSString*) domain
//                 code:(NSInteger) code
//             userInfo:(NSDictionary *)dict
//               reason:(NSString*) reason
//              comment:(NSString*) comment
//         stackTrace:(FLStackTrace*) stackTrace {
//
//    const FLDictionaryEntry objects[] = {
//        { reason, NSLocalizedFailureReasonErrorKey },
//        { comment, FLErrorCommentKey },
//        { stackTrace, FLErrorStackTraceKey },
//        { makeDescriptionString(reason, comment), NSLocalizedDescriptionKey },
//        FLDictionaryEntryNil
//    };
//
//    return [self initWithDomain:domain
//                           code:code
//                           userInfo:[NSDictionary combineDictionary:dict withObjects:objects]];
//}

- (id) initWithDomain:(id) domainStringOrObject
                 code:(NSInteger) code
             userInfo:(NSDictionary *)dict
               reason:(NSString*) reason
              comment:(NSString*) comment
         stackTrace:(FLStackTrace*) stackTrace {

    FLDictionaryEntry objects[] = {
        { FLGetErrorDomain(domainStringOrObject), FLErrorDomainKey },
        { reason, NSLocalizedFailureReasonErrorKey },
        { comment, FLErrorCommentKey },
        { stackTrace, FLErrorStackTraceKey },
        { makeDescriptionString(reason, comment), NSLocalizedDescriptionKey },
         FLDictionaryEntryNil
    };

    return [self initWithDomain:[FLErrorDomain errorDomainNameFromObject:domainStringOrObject]
                           code:code
                           userInfo:[NSDictionary combineDictionary:dict withObjects:objects]];
}

+ (NSError*) errorWithDomain:(id) domain
                          code:(NSInteger)code
                      userInfo:(NSDictionary *)dict
                        reason:(NSString*) reasonOrNil
                       comment:(NSString*) commentOrNil
                  stackTrace:(FLStackTrace*) stackTrace {

    return autorelease_([[[self class] alloc] initWithDomain:domain
                                                                    code:code
                                                                 userInfo:dict
                                                                   reason:reasonOrNil
                                                                  comment:commentOrNil
                                                             stackTrace:stackTrace]);
}


//+ (FLMutableError*) errorWithDomain:(NSString*) domain
//                            code:(NSInteger) code
//                        userInfo:(NSDictionary*) dict
//                          reason:(NSString*) reason
//                         comment:(NSString*) comment
//                    stackTrace:(FLStackTrace*) stackTrace {
//    
//    return autorelease_([[[self class] alloc] initWithDomain:domain
//                                                                code:code
//                                                            userInfo:dict
//                                                              reason:reason
//                                                             comment:comment
//                                                        stackTrace:stackTrace]);
//}



@end


