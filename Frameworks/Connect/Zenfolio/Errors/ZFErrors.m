//
//	ZFErrors.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "ZFErrors.h"
//enum {
//	errNotZenfolioError,
//	errInvalidCredentials,
//	errAccountLocked,
//	errConnectionIsNotSecure,
//	errDuplicateEmail,
//	errDuplicateLoginName,
//	errInvalidParam,
//	errNoSuchObject,
//	errNotAuthorized, 
//	errNotAuthenticated,
//	errUnspecified,
//	errUnknownObjectId
//} ;

//typedef int32_t ZFError;
//extern NSString * const E_ACCOUNTLOCKED;
////	  This error is returned by an authentication method if a user's account is locked, for example, because of too many invalid login attempts.
//
//extern NSString * const E_CONNECTIONISNOTSECURE;
////	  The requested operation requires a secure connection. Some of the Zenfolio API methods, for example AuthenticatePlain, can only be called over a secure connection.
//
//extern NSString * const E_DUPLICATEEMAIL;
////	  The e-mail address provided is already being used.
//
//extern NSString * const E_DUPLICATELOGINNAME;
////	  The login name provided is already being used.
//
//extern NSString * const E_INVALIDCREDENTIALS;
////	  Invalid credentials were supplied to an authentication method. This is normally returned because of an incorrect password, but it can also be returned if the user name is invalid.
//
//extern NSString * const E_INVALIDPARAM;
////	  One or more method parameters were not valid.
//
//extern NSString * const E_NOSUCHOBJECT;
////	  Requested operation refers to an object that does not exist. This usually indicates that an invalid object identifier was passed to the method call. This error may also occur if the caller is not allowed to access the object or needs to authenticate to access it.
//
//extern NSString * const E_NOTAUTHENTICATED;
////	  Requested operation requires the user to be authenticated. While some operations such as searching are available to non-authenticated users, most of the Zenfolio API methods require authentication.
//
//extern NSString * const E_NOTAUTHORIZED;
////	  The calling user is not autorized to perform requested operation. This usually happens when trying to manipulate an object which is owned by a different user or which cannot be modified.
//
//extern NSString * const E_UNSPECIFIEDERROR;
//// An unspecified error has occured.

NSString * const ZFErrorDomain           = @"ZFErrorDomain";

#define  E_ACCOUNTLOCKED                 @"accountlocked"
#define E_CONNECTIONISNOTSECURE        @"connectionisnotsecure"
#define E_DUPLICATEEMAIL               @"duplicateemail"
#define E_DUPLICATELOGINNAME           @"duplicateloginname"
#define E_INVALIDCREDENTIALS           @"invalidcredentials"
#define E_INVALIDPARAM                 @"invalidparam"
#define  E_NOSUCHOBJECT                 @"nosuchobject"
#define E_NOTAUTHENTICATED             @"notauthenticated"
#define E_NOTAUTHORIZED                @"notauthorized"
#define E_UNSPECIFIEDERROR             @"unspecifiederror"

typedef struct {
    int code;
    __unsafe_unretained NSString* name;
} ZFErrorStruct;
  
ZFErrorStruct s_errors[] = {
    { ZFErrorCodeInvalidCredentials, E_INVALIDCREDENTIALS }, 
    { ZFErrorCodeAccountLocked, E_ACCOUNTLOCKED }, 
    { ZFErrorCodeConnectionIsNotSecure, E_CONNECTIONISNOTSECURE }, 
    { ZFErrorCodeDuplicateEmail, E_DUPLICATEEMAIL }, 
    { ZFErrorCodeDuplicateLoginName, E_DUPLICATELOGINNAME }, 
    { ZFErrorCodeInvalidParam, E_INVALIDPARAM }, 
    { ZFErrorCodeNoSuchObject, E_NOSUCHOBJECT }, 
    { ZFErrorCodeNotAuthenticated, E_NOTAUTHENTICATED }, 
    { ZFErrorCodeNotAuthorized, E_NOTAUTHORIZED },
    { ZFErrorCodeUnspecified, E_UNSPECIFIEDERROR },
};

ZFErrorCode ZFErrorCodeFromString(NSString* errorString) {
    
    errorString = [errorString lowercaseString];
    
    for(int i = 0; i < (sizeof(s_errors) / sizeof(ZFErrorStruct)); i++) {
        
        if([errorString rangeOfString:s_errors[i].name].length > 0) {
            return s_errors[i].code;
        }
    }

	return ZFErrorCodeErrorIsNotZenfolioError;
}


@implementation NSError (ZenfolioError)

- (ZFErrorCode) zenfolioErrorCode {
    return [self isErrorDomain:ZFErrorDomain] ? self.code : ZFErrorCodeErrorIsNotZenfolioError;
}

@end
