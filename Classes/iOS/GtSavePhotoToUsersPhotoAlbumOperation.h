//
//	GtSavePhotoToUsersPhotoAlbumOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/1/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtDatabaseCacheOperation.h"
#import "GtImageAsset.h"

/** output is ALAsset URL */ 

@interface GtSaveImageToUsersPhotoAlbumOperation : GtOperation {
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

- (void) setImageInput:(UIImage*) image properties:(NSDictionary*) properties;

@end

@interface GtSavePhotoToUsersPhotoAlbumOperation : GtSaveImageToUsersPhotoAlbumOperation {
}
- (id) initWithPhotoInput:(id<GtImageAsset>) photo;
@end


