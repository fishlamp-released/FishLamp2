//
//	ZFErrors.h
//	ZenLib
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

extern NSString * const ZFErrorDomain;

typedef enum {
	ZFErrorCodeErrorIsNotZenfolioError,
	ZFErrorCodeInvalidCredentials,
	ZFErrorCodeAccountLocked,
	ZFErrorCodeConnectionIsNotSecure,
	ZFErrorCodeDuplicateEmail,
	ZFErrorCodeDuplicateLoginName,
	ZFErrorCodeInvalidParam,
	ZFErrorCodeNoSuchObject,
	ZFErrorCodeNotAuthorized, 
	ZFErrorCodeNotAuthenticated,
	ZFErrorCodeUnspecified,
	ZFErrorCodeUnknownObjectId,
    
    ZFErrorCodeUnknownCategory = 100,
    ZFErrorCodeCategoriesNotLoaded, 
    ZFErrorCodeUploadPhotoSetNotFound,
    ZFErrorCodeUploadFileNameEmpty,
    ZFErrorCodeUploadMissingImage
} ZFErrorCode;


@interface ZFErrors : NSObject {
	NSDictionary* _errors;
}

FLSingletonProperty(ZFErrors);

- (ZFErrorCode) errorCodeFromString:(NSString*) errorString;

@end

@interface NSError (ZenfolioError)
@property (readonly, assign) ZFErrorCode zenfolioErrorCode;
@end


