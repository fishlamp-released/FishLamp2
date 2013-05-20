//
//  GtDataProviderPhotoViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/21/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPhotoViewController.h"
#import "GtGalleryDataProvider.h"

@protocol GtPhotoViewControllerDataProvider <GtPhotoViewControllerDelegate>
@property (readwrite, retain, nonatomic) id galleryContainer; // GtGalleryObjectContainer
@property (readwrite, retain, nonatomic) id galleryDataProvider;
@property (readwrite, retain, nonatomic) id userDataProvider;
@property (readwrite, retain, nonatomic) GtOrderedCollection* cellCollection;
@end

@class GtPhotoViewControllerGalleryDataProvider;

@interface GtDataProviderPhotoViewController : GtPhotoViewController {
@private
    id<GtPhotoViewControllerDataProvider> m_dataProvider;
}

@property (readwrite, retain, nonatomic) id<GtPhotoViewControllerDataProvider> dataProvider;

- (id) initWithDataProvider:(id<GtPhotoViewControllerDataProvider>) dataProvider;

- (void) closeSelf:(id) sender;

@end

@interface GtGridViewPhotoViewControllerSelectionHandler : NSObject<GtGridViewCellSelectionHandler> {
}

- (GtDataProviderPhotoViewController*) createPhotoViewControllerInViewController:(GtGridViewController*) controller;

@end