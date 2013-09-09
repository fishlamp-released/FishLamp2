//
//  FLFacebookLoadUserPictureOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
