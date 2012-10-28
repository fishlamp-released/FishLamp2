//
//  FLGalleryGridViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/1/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGridViewController.h"
#import "FLGalleryDataModel.h"

@interface FLGalleryGridViewController : FLGridViewController {
@private
   id _galleryContainer;
   id _galleryID;
}

@property (readwrite, retain, nonatomic) id galleryID;
@property (readwrite, retain, nonatomic) id galleryContainer;

- (NSUInteger) numPagesLoaded;

- (void) beginLoadingPageAtIndex:(NSInteger) pageIndex;
- (void) beginLoadingCurrentPage;
- (void) beginLoadingGalleryContainer;

- (void) setTitleWithGalleryContainer;

@end

