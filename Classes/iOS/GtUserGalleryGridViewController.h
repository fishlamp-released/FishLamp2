//
//  GtUserGalleryGridViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/4/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGalleryGridViewController.h"
#import "GtAsyncThumbnailToolBar.h"

@interface GtUserGalleryGridViewController : GtGalleryGridViewController {
@private
    GtAsyncThumbnailToolBar* m_topToolbar;
}

@property (readonly, retain, nonatomic) GtAsyncThumbnailToolBar* topToolbar; 

- (void) addButtonsToTopToolbar:(GtAsyncThumbnailToolBar*) topToolbar;

- (void) closeSelf:(id) sender;

@end
