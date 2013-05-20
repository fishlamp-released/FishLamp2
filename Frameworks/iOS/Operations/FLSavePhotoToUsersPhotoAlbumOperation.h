//
//	FLSavePhotoToUsersPhotoAlbumOperation.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/1/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLSynchronousOperation.h"
#import "FLImageAsset.h"

/** output is ALAsset URL */ 

@interface FLSaveImageToUsersPhotoAlbumOperation : FLSynchronousOperation {
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


