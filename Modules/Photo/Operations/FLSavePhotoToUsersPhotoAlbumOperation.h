//
//	FLSavePhotoToUsersPhotoAlbumOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/1/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLDatabaseCacheOperation.h"
#import "FLImageAsset.h"

/** output is ALAsset URL */ 

@interface FLSaveImageToUsersPhotoAlbumOperation : FLOperation {
@private
	NSConditionLock* m_lock;
	BOOL m_done;
	NSDictionary* m_properties;
	ALAssetsLibrary* m_assetsLibrary;
	
#if DEBUG
	BOOL m_savedImage;
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


