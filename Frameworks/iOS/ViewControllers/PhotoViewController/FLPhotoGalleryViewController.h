//
//  FLPhotoGalleryViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/15/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLGalleryGridViewController.h"
#import "FLDataProviderPhotoViewController.h"

#import "FLViewControllerStack.h"

@interface FLPhotoGalleryViewController : FLGalleryGridViewController

- (FLDataProviderPhotoViewController*) createPhotoViewControllerForCell:(FLGridCell*) cell;

- (id<FLViewControllerTransitionAnimation>) selectionAnimationForCell:(FLGridCell*) cell;

@end
