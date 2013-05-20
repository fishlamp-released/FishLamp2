//
//  GtPhotoBrowser.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/4/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtDataProviderPhotoViewController.h"
#import "GtAsyncThumbnailToolBar.h"

@interface GtPhotoBrowser : GtDataProviderPhotoViewController {
}

- (void) createTopToolbar;
- (void) addButtonsToTopToolbar:(GtAsyncThumbnailToolBar*) topToolbar;

@end
