//
//  FLDataProviderPhotoViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/21/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLPhotoViewController.h"
#import "FLGalleryDataProvider.h"

@protocol FLPhotoViewControllerDataProvider <FLPhotoViewControllerDelegate>
@property (readwrite, retain, nonatomic) id galleryContainer; // FLGalleryObjectContainer
@property (readwrite, retain, nonatomic) id galleryDataProvider;
@property (readwrite, retain, nonatomic) id userDataProvider;
@property (readwrite, retain, nonatomic) FLOrderedCollection* cellCollection;
@end

@class FLPhotoViewControllerGalleryDataProvider;

@interface FLDataProviderPhotoViewController : FLPhotoViewController {
@private
    id<FLPhotoViewControllerDataProvider> m_dataProvider;
}

@property (readwrite, retain, nonatomic) id<FLPhotoViewControllerDataProvider> dataProvider;

- (id) initWithDataProvider:(id<FLPhotoViewControllerDataProvider>) dataProvider;

- (void) closeSelf:(id) sender;

@end
