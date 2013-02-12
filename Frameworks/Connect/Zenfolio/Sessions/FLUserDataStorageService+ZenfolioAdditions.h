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
#import "FLUserDataStorageService.h"


@class FLZenfolioUploadGallery;
@class FLZenfolioAccessDescriptor;

@interface FLUserDataStorageService (Zenfolio)

- (FLZenfolioUploadGallery*) defaultUploadGallery;
- (void) saveDefaultUploadGallery:(FLZenfolioUploadGallery*) uploadGallery;

- (FLZenfolioAccessDescriptor*) defaultAccessDescriptor;
- (void) saveDefaultAccessDescriptor:(FLZenfolioAccessDescriptor*) accessDescriptor;

//- (ZFBrowserViewOptions*) defaultBrowserViewOptions;
//- (void) saveDefaultBrowserViewOptions:(ZFBrowserViewOptions*) options;

@end
