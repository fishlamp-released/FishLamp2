//
//  FLPhotoGridViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/10/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGalleryGridViewController.h"
#import "FLHorizontalGridArrangement.h"

@interface FLPhotoGridViewController : FLGalleryGridViewController {
@private

}

- (void) beginShowingGalleryItem:(id<FLGalleryObject>) galleryItem
             fromRectInSuperview:(FLRect) rect; // zoom animation

@end
