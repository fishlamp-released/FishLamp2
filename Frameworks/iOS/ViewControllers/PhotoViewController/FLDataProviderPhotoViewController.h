//
//  FLDataProviderPhotoViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/21/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLPhotoViewController.h"
#import "FLGalleryDataModel.h"
#import "FLGalleryUserDataModel.h"

@protocol FLPhotoViewControllerDataModel <FLPhotoViewControllerDelegate>
@property (readwrite, retain, nonatomic) id galleryContainer; // FLGalleryObjectContainer
@property (readwrite, retain, nonatomic) id galleryDataModel;
@property (readwrite, retain, nonatomic) id galleryUserDataModel;
@property (readwrite, retain, nonatomic) FLOrderedCollection* cellCollection;
@end

@class FLPhotoViewControllerGalleryDataProvider;

@interface FLDataProviderPhotoViewController : FLPhotoViewController {
@private
    id<FLPhotoViewControllerDataModel> _dataProvider;
}

@property (readwrite, retain, nonatomic) id<FLPhotoViewControllerDataModel> dataModel;

- (id) initWithDataModel:(id<FLPhotoViewControllerDataModel>) dataModel;

- (void) closeSelf:(id) sender;

@end
