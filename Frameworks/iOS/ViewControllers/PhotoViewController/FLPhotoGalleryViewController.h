//
//  FLPhotoGalleryViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/15/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGalleryGridViewController.h"
#import "FLDataProviderPhotoViewController.h"

#import "FLViewControllerStack.h"

@interface FLPhotoGalleryViewController : FLGalleryGridViewController

- (FLDataProviderPhotoViewController*) createPhotoViewControllerForCell:(FLGridCell*) cell;

- (id<FLViewControllerTransitionAnimation>) selectionAnimationForCell:(FLGridCell*) cell;

@end
