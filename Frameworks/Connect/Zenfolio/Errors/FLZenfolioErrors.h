//
//	FLZenfolioErrors.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

extern NSString * const FLZenfolioErrorDomain;

typedef enum {
	FLZenfolioErrorCodeErrorIsNotZenfolioError,
	FLZenfolioErrorCodeInvalidCredentials,
	FLZenfolioErrorCodeAccountLocked,
	FLZenfolioErrorCodeConnectionIsNotSecure,
	FLZenfolioErrorCodeDuplicateEmail,
	FLZenfolioErrorCodeDuplicateLoginName,
	FLZenfolioErrorCodeInvalidParam,
	FLZenfolioErrorCodeNoSuchObject,
	FLZenfolioErrorCodeNotAuthorized, 
	FLZenfolioErrorCodeNotAuthenticated,
	FLZenfolioErrorCodeUnspecified,
	FLZenfolioErrorCodeUnknownObjectId,
    
    FLZenfolioErrorCodeUnknownCategory = 100,
    FLZenfolioErrorCodeCategoriesNotLoaded, 
    FLZenfolioErrorCodeUploadPhotoSetNotFound,
    FLZenfolioErrorCodeUploadFileNameEmpty,
    FLZenfolioErrorCodeUploadMissingImage
} FLZenfolioErrorCode;


@interface FLZenfolioErrors : NSObject {
	NSDictionary* _errors;
}

FLSingletonProperty(FLZenfolioErrors);

- (FLZenfolioErrorCode) errorCodeFromString:(NSString*) errorString;

@end

@interface NSError (ZenfolioError)
@property (readonly, assign) FLZenfolioErrorCode zenfolioErrorCode;
@end


