//
//  GtFacebookLoadUserPictureOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtFacebookOperation.h"
#import "GtFacebookLoadUserPictureOperationInput.h"

#define GtFacebookLoadUserPictureOperationInputSizeNormal kGtFacebookPictureSizeGtFacebookPictureSizeNormal
#define GtFacebookLoadUserPictureOperationInputSizeLarge kGtFacebookPictureSizeGtFacebookPictureSizeLarge
#define GtFacebookLoadUserPictureOperationInputSizeSquare kGtFacebookPictureSizeGtFacebookPictureSizeSquare
#define GtFacebookLoadUserPictureOperationInputSizeSmall kGtFacebookPictureSizeGtFacebookPictureSizeSmall

// [operation.input setSize:GtFacebookLoadUserPictureOperationInputSizeSquare]

@interface GtFacebookLoadUserPictureOperation : GtFacebookOperation {
@private
	NSString* m_pictureSize;
}
@property (readwrite, retain, nonatomic) NSString* pictureSize;
@end
