//
//  FLFacebookLoadUserPictureOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLFacebookHttpRequest.h"
#import "FLFacebookLoadUserPictureOperationInput.h"

#import "FacebookEnums.h"

#define FLFacebookLoadUserPictureOperationInputSizeNormal kFLFacebookPictureSizeFLFacebookPictureSizeNormal
#define FLFacebookLoadUserPictureOperationInputSizeLarge kFLFacebookPictureSizeFLFacebookPictureSizeLarge
#define FLFacebookLoadUserPictureOperationInputSizeSquare kFLFacebookPictureSizeFLFacebookPictureSizeSquare
#define FLFacebookLoadUserPictureOperationInputSizeSmall kFLFacebookPictureSizeFLFacebookPictureSizeSmall

// [operation.input setSize:FLFacebookLoadUserPictureOperationInputSizeSquare]

@interface FLFacebookLoadUserPictureHttpRequest : FLFacebookHttpRequest {
@private
	NSString* _pictureSize;
}
@property (readwrite, retain, nonatomic) NSString* pictureSize;
@end
