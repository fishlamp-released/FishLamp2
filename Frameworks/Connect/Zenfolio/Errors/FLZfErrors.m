//
//	FLZfErrors.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLZfErrors.h"
//enum {
//	errNotZfError,
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

//typedef int32_t FLZfError;
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

NSString * const FLZfErrorDomain                  = @"FLZfErrorDomain";
NSString * const E_ACCOUNTLOCKED                = @"E_ACCOUNTLOCKED";
NSString * const E_CONNECTIONISNOTSECURE        = @"E_CONNECTIONISNOTSECURE";
NSString * const E_DUPLICATEEMAIL               = @"E_DUPLICATEEMAIL";
NSString * const E_DUPLICATELOGINNAME           = @"E_DUPLICATELOGINNAME";
NSString * const E_INVALIDCREDENTIALS           = @"E_INVALIDCREDENTIALS";
NSString * const E_INVALIDPARAM                 = @"E_INVALIDPARAM";
NSString * const E_NOSUCHOBJECT                 = @"E_NOSUCHOBJECT";
NSString * const E_NOTAUTHENTICATED             = @"E_NOTAUTHENTICATED";
NSString * const E_NOTAUTHORIZED                = @"E_NOTAUTHORIZED";
NSString * const E_UNSPECIFIEDERROR             = @"E_UNSPECIFIEDERROR";

@implementation FLZfErrors

FLSynthesizeSingleton(FLZfErrors);

- (id) init {
	if((self = [super init])) {
		_errors = [[NSDictionary alloc] initWithObjectsAndKeys:
			[NSNumber numberWithInt:FLZfErrorCodeInvalidCredentials], E_INVALIDCREDENTIALS, 
			[NSNumber numberWithInt:FLZfErrorCodeAccountLocked], E_ACCOUNTLOCKED, 
			[NSNumber numberWithInt:FLZfErrorCodeConnectionIsNotSecure], E_CONNECTIONISNOTSECURE, 
			[NSNumber numberWithInt:FLZfErrorCodeDuplicateEmail], E_DUPLICATEEMAIL, 
			[NSNumber numberWithInt:FLZfErrorCodeDuplicateLoginName], E_DUPLICATELOGINNAME, 
			[NSNumber numberWithInt:FLZfErrorCodeInvalidParam], E_INVALIDPARAM, 
			[NSNumber numberWithInt:FLZfErrorCodeNoSuchObject], E_NOSUCHOBJECT, 
			[NSNumber numberWithInt:FLZfErrorCodeNotAuthenticated], E_NOTAUTHENTICATED, 
			[NSNumber numberWithInt:FLZfErrorCodeNotAuthorized], E_NOTAUTHORIZED,
			[NSNumber numberWithInt:FLZfErrorCodeUnspecified], E_UNSPECIFIEDERROR, 
		 nil];
	}
	
	return self;
}

- (void) dealloc {
	FLRelease(_errors);
	FLSuperDealloc();
}

#define kSoapPrefix @"zf:"

- (FLZfErrorCode) errorCodeFromString:(NSString*) errorString {

    if([errorString hasPrefix:kSoapPrefix]) {
        errorString = [errorString substringFromIndex:kSoapPrefix.length];
    }

	NSNumber* num = [_errors objectForKey:errorString];
	if(!num) { 
		return FLZfErrorCodeErrorIsNotZenfolioError;
	} 
	return [num unsignedIntValue];
}

@end

@implementation NSError (ZenfolioError)

- (FLZfErrorCode) zenfolioErrorCode {
    return [self errorDomainEqualsDomain:FLZfErrorDomain] ? self.code : FLZfErrorCodeErrorIsNotZenfolioError;
}

@end
