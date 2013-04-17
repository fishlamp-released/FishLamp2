//
//  FLHttpErrors.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 4/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpErrors.h"

NSString* const FLHttpServerErrorDomain = @"FLHttpServerErrorDomain";

//NSString* FLStringFromHttpServerStatusResponseCode(NSInteger responseCode) {
//
//    switch(responseCode) {
//
//        case FLHttpServerResponseCodeContinue:
//            return @"Continue";
//        break;
//        
//        case FLHttpServerResponseCodeSwitchingProtocols:
//            return @"SwitchingProtocols";
//        break;
//
//        case FLHttpServerResponseCodeCheckpoint:
//            return @"Checkpoint";
//        break;
//
//        case FLHttpServerResponseCodeSuccessful:
//            return @"Successful";
//
//        break;
//
//       case FLHttpServerResponseCodeCreated:
//            return @"Created";
//
//        break;
//
//       case FLHttpServerResponseCodeAccepted:
//            return @"Accepted";
//
//        break;
//
//       case FLHttpServerResponseCodeNonAuthoritiveInformation:
//            return @"NonAuthoritiveInformation";
//
//        break;
//
//       case FLHttpServerResponseCodeNoContent:
//            return @"NoContent";
//
//        break;
//
//       case FLHttpServerResponseCodeResetContent:
//            return @"ResetContent";
//
//        break;
//
//       case FLHttpServerResponseCodePartialContent:
//            return @"PartialContent";
//
//        break;
//
//       case FLHttpServerResponseCodeRedirectMultipleChoices:
//            return @"RedirectMultipleChoices";
//
//        break;
//
//       case FLHttpServerResponseCodeRedirectMovedPermanently:
//            return @"RedirectMovedPermanently";
//
//        break;
//
//       case FLHttpServerResponseCodeRedirectFound:
//            return @"RedirectFound";
//
//        break;
//
//       case FLHttpServerResponseCodeRedirectSeeOther:
//            return @"RedirectSeeOther";
//
//        break;
//
//       case FLHttpServerResponseCodeRedirectNotModified:
//            return @"RedirectNotModified";
//
//        break;
//
//       case FLHttpServerResponseCodeRedirectSwitchProxy:
//            return @"RedirectSwitchProxy";
//
//        break;
//
//       case FLHttpServerResponseCodeRedirectTemporary:
//            return @"RedirectTemporary";
//
//        break;
//
//       case FLHttpServerResponseCodeRedirectResumeIncomplete:
//            return @"RedirectResumeIncomplete";
//
//        break;
//
//       case FLHttpServerResponseCodeBadRequest:
//            return @"BadRequest";
//
//        break;
//
//       case FLHttpServerResponseCodeUnauthorized:
//            return @"Unauthorized";
//
//        break;
//
//       case FLHttpServerResponseCodePaymentRequired:
//            return @"PaymentRequired";
//
//        break;
//
//       case FLHttpServerResponseCodeForbidden:
//            return @"Forbidden";
//
//        break;
//
//       case FLHttpServerResponseCodeNotFound:
//            return @"NotFound";
//
//        break;
//
//       case FLHttpServerResponseCodeMethodNotAllowed:
//            return @"MethodNotAllowed";
//
//        break;
//
//       case FLHttpServerResponseCodeNotAcceptable:
//            return @"NotAcceptable";
//
//        break;
//
//       case FLHttpServerResponseCodeProxyAuthorizationRequired:
//            return @"ProxyAuthorizationRequired";
//
//        break;
//
//       case FLHttpServerResponseCodeRequestTimeout:
//            return @"RequestTimeout";
//
//        break;
//
//       case FLHttpServerResponseCodeConflict:
//            return @"Conflict";
//
//        break;
//
//       case FLHttpServerResponseCodeGone:
//            return @"Gone";
//
//        break;
//
//       case FLHttpServerResponseCodeLengthRequired:
//            return @"LengthRequired";
//
//        break;
//
//       case FLHttpServerResponseCodePreconditionFailed:
//            return @"PreconditionFailed";
//
//        break;
//
//       case FLHttpServerResponseCodeRequestEntryTooLarge:
//            return @"RequestEntryTooLarge";
//
//        break;
//
//       case FLHttpServerResponseCodeRequestURITooLong:
//            return @"RequestURITooLong";
//
//        break;
//
//       case FLHttpServerResponseCodeUnsupportedMediaType:
//            return @"UnsupportedMediaType";
//
//        break;
//
//       case FLHttpServerResponseCodeRequestRangeNotSatisfiable:
//            return @"RequestRangeNotSatisfiable";
//
//        break;
//
//       case FLHttpServerResponseCodeExpectationFailed:
//            return @"ExpectationFailed";
//
//        break;
//
//       case FLHttpServerResponseCodeInternalServerError:
//            return @"InternalServerError";
//
//        break;
//
//       case FLHttpServerResponseCodeNotImplemented:
//            return @"NotImplemented";
//
//        break;
//
//       case FLHttpServerResponseCodeBadGateway:
//            return @"BadGateway";
//
//        break;
//
//       case FLHttpServerResponseCodeServiceUnavailable:
//            return @"ServiceUnavailable";
//
//        break;
//
//       case FLHttpServerResponseCodeGatewayTimeout:
//            return @"GatewayTimeout";
//
//        break;
//
//       case FLHttpServerResponseCodeHttpVersionNotSupported:
//            return @"HttpVersionNotSupported";
//
//        break;
//
//       case FLHttpServerResponseCodeNetworkAuthenticationRequired:
//            return @"NetworkAuthenticationRequired";
//        break;
//    }
//    return nil;
//}

@implementation NSError (FLHttpServerResponseCode)

+ (NSError*) httpServerError:(NSInteger) statusCode statusLine:(NSString*) statusLine {

    NSString* errorString = [NSString stringWithFormat:
			  (NSLocalizedString(@"HTTP Server Response:%d (%@). Status line: %@",nil)),
				statusCode,
				[NSHTTPURLResponse localizedStringForStatusCode:statusCode],
                statusLine == nil ? @"" : statusLine];

#if DEBUG
    FLLog(errorString);
#endif    
    
	return [NSError errorWithDomain:FLHttpServerErrorDomain
                               code:statusCode
               localizedDescription:errorString];
}

- (BOOL) isHttpServerError {
    return [self isErrorDomain:FLHttpServerErrorDomain];
}

@end