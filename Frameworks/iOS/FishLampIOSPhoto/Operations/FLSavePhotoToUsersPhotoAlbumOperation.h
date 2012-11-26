//
//	FLSavePhotoToUsersPhotoAlbumOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/1/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLOperation.h"
#import "FLImageAsset.h"

/** output is ALAsset URL */ 

@interface FLSaveImageToUsersPhotoAlbumOperation : FLOperation {
@private
	NSConditionLock* _lock;
	BOOL _done;
	NSDictionary* _properties;
	ALAssetsLibrary* _assetsLibrary;
	
#if DEBUG
	BOOL _savedImage;
#endif

}

- (id) initWithImageInput:(UIImage*) image properties:(NSDictionary*) properties;

+ (FLSaveImageToUsersPhotoAlbumOperation*) saveImageToUserPhotoAlbumOperation:(UIImage*) image properties:(NSDictionary*) properties;

- (void) setImageInput:(UIImage*) image properties:(NSDictionary*) properties;

@end

@interface FLSavePhotoToUsersPhotoAlbumOperation : FLSaveImageToUsersPhotoAlbumOperation {
}
- (id) initWithPhotoInput:(id<FLImageAsset>) photo;
@end


