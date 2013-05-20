//
//  FLUserGalleryGridViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/4/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLGalleryGridViewController.h"
#import "FLAsyncThumbnailToolBar.h"

@interface FLUserGalleryGridViewController : FLGalleryGridViewController {
@private
    FLAsyncThumbnailToolBar* _topToolbar;
}

@property (readonly, retain, nonatomic) FLAsyncThumbnailToolBar* topToolbar; 

- (void) addButtonsToTopToolbar:(FLAsyncThumbnailToolBar*) topToolbar;

- (void) closeSelf:(id) sender;

@end
