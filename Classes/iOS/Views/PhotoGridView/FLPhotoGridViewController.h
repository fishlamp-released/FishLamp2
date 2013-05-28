//
//  FLPhotoGridViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/10/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLGalleryGridViewController.h"
#import "FLHorizontalGridArrangement.h"

@interface FLPhotoGridViewController : FLGalleryGridViewController {
@private

}

- (void) beginShowingGalleryItem:(id<FLGalleryObject>) galleryItem
             fromRectInSuperview:(CGRect) rect; // zoom animation

@end
