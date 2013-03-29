//
//  ZFUserDataStoragetService.h
//  ZenLib
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if REFACTOR

#import "FLService.h"
#import "FLDatabase.h"
#import "FLFolder.h"
#import "FLUserDataStorageService.h"


@class ZFUploadGallery;
@class ZFAccessDescriptor;

@interface FLUserDataStorageService (Zenfolio)

- (ZFUploadGallery*) defaultUploadGallery;
- (void) saveDefaultUploadGallery:(ZFUploadGallery*) uploadGallery;

- (ZFAccessDescriptor*) defaultAccessDescriptor;
- (void) saveDefaultAccessDescriptor:(ZFAccessDescriptor*) accessDescriptor;

//- (ZFBrowserViewOptions*) defaultBrowserViewOptions;
//- (void) saveDefaultBrowserViewOptions:(ZFBrowserViewOptions*) options;

@end

#endif