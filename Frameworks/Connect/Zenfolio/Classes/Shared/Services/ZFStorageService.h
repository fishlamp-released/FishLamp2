//
//  ZFUserDataStoragetService.h
//  ZenLib
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLDatabase.h"
#import "FLFolder.h"
#import "ZFUtils.h"
#import "FLUserDataStorageService.h"

@interface FLUserDataStorageService (Zenfolio)

- (ZFUploadGallery*) defaultUploadGallery;
- (void) saveDefaultUploadGallery:(ZFUploadGallery*) uploadGallery;

- (ZFAccessDescriptor*) defaultAccessDescriptor;
- (void) saveDefaultAccessDescriptor:(ZFAccessDescriptor*) accessDescriptor;

- (ZFBrowserViewOptions*) defaultBrowserViewOptions;
- (void) saveDefaultBrowserViewOptions:(ZFBrowserViewOptions*) options;

@end
