//
//  FLPhotoBrowser.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/4/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDataProviderPhotoViewController.h"
#import "FLToolbarView.h"
#import "FLAsyncThumbnailToolBar.h"

@interface FLPhotoBrowser : FLDataProviderPhotoViewController {
}

- (void) createTopToolbar;
- (void) addButtonsToTopToolbar:(FLAsyncThumbnailToolBar*) toolbar;

@end

