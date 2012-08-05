//
//  FLFacebookLoadUserPictureOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLFacebookOperation.h"
#import "FLFacebookLoadUserPictureOperationInput.h"

#define FLFacebookLoadUserPictureOperationInputSizeNormal kFLFacebookPictureSizeFLFacebookPictureSizeNormal
#define FLFacebookLoadUserPictureOperationInputSizeLarge kFLFacebookPictureSizeFLFacebookPictureSizeLarge
#define FLFacebookLoadUserPictureOperationInputSizeSquare kFLFacebookPictureSizeFLFacebookPictureSizeSquare
#define FLFacebookLoadUserPictureOperationInputSizeSmall kFLFacebookPictureSizeFLFacebookPictureSizeSmall

// [operation.input setSize:FLFacebookLoadUserPictureOperationInputSizeSquare]

@interface FLFacebookLoadUserPictureOperation : FLFacebookOperation {
@private
	NSString* m_pictureSize;
}
@property (readwrite, retain, nonatomic) NSString* pictureSize;
@end
