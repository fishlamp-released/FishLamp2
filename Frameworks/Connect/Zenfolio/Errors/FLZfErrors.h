//
//	FLZfErrors.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/25/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

extern NSString * const FLZfErrorDomain;

typedef enum {
	FLZfErrorCodeErrorIsNotZenfolioError,
	FLZfErrorCodeInvalidCredentials,
	FLZfErrorCodeAccountLocked,
	FLZfErrorCodeConnectionIsNotSecure,
	FLZfErrorCodeDuplicateEmail,
	FLZfErrorCodeDuplicateLoginName,
	FLZfErrorCodeInvalidParam,
	FLZfErrorCodeNoSuchObject,
	FLZfErrorCodeNotAuthorized, 
	FLZfErrorCodeNotAuthenticated,
	FLZfErrorCodeUnspecified,
	FLZfErrorCodeUnknownObjectId,
    
    FLZfErrorCodeUnknownCategory = 100,
    FLZfErrorCodeCategoriesNotLoaded, 
    FLZfErrorCodeUploadPhotoSetNotFound,
    FLZfErrorCodeUploadFileNameEmpty,
    FLZfErrorCodeUploadMissingImage
} FLZfErrorCode;


@interface FLZfErrors : NSObject {
	NSDictionary* _errors;
}

FLSingletonProperty(FLZfErrors);

- (FLZfErrorCode) errorCodeFromString:(NSString*) errorString;

@end

@interface NSError (ZenfolioError)
@property (readonly, assign) FLZfErrorCode zenfolioErrorCode;
@end


