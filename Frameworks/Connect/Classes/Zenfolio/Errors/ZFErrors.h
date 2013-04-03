//
//	ZFErrors.h
//	FishLamp
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


extern ZFErrorCode ZFErrorCodeFromString(NSString* errorString);

@interface NSError (ZenfolioError)
@property (readonly, assign) ZFErrorCode zenfolioErrorCode;
@end


