//
//  FLPhotoBrowser.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/4/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLDataProviderPhotoViewController.h"
#import "FLToolbarView.h"
#import "FLAsyncThumbnailToolBar.h"

@interface FLPhotoBrowser : FLDataProviderPhotoViewController {
}

- (void) createTopToolbar;
- (void) addButtonsToTopToolbar:(FLAsyncThumbnailToolBar*) toolbar;

@end

