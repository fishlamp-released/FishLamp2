//
//  GtSavePhotoToUsersPhotoAlbumOperation.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GtDatabaseCacheOperation.h"
#import "GtPhoto.h"

@interface GtSaveImageToUsersPhotoAlbumOperation : GtOperation {
}

- (id) initWithImageInput:(UIImage*) image;

@end

@interface GtSavePhotoToUsersPhotoAlbumOperation : GtOperation {
}

- (id) initWithPhotoInput:(GtPhoto*) photo;

@end
