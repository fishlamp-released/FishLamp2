//
//  FLUserGalleryGridViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/4/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGalleryGridViewController.h"
#import "FLAsyncThumbnailToolBar.h"

@interface FLUserGalleryGridViewController : FLGalleryGridViewController {
@private
    FLAsyncThumbnailToolBar* m_topToolbar;
}

@property (readonly, retain, nonatomic) FLAsyncThumbnailToolBar* topToolbar; 

- (void) addButtonsToTopToolbar:(FLAsyncThumbnailToolBar*) topToolbar;

- (void) closeSelf:(id) sender;

@end
