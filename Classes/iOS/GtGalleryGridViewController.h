//
//  GtGalleryGridViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 1/1/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGridViewController.h"
#import "GtGalleryDataProvider.h"

@interface GtGalleryGridViewController : GtGridViewController {
@private
   id m_galleryContainer;
   id m_galleryID;
}

@property (readwrite, retain, nonatomic) id galleryID;
@property (readwrite, retain, nonatomic) id galleryContainer;

- (NSUInteger) numPagesLoaded;

- (void) beginLoadingPageAtIndex:(NSInteger) pageIndex;
- (void) beginLoadingCurrentPage;
- (void) beginLoadingGalleryContainer;

- (void) setTitleWithGalleryContainer;

@end

