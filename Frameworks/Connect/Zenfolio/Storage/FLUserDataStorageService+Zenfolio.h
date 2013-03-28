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

#import "FLObjectStorageService.h"

@interface FLObjectStorageService (Zenfolio)

- (ZFUploadGallery*) defaultUploadGallery;
- (void) saveDefaultUploadGallery:(ZFUploadGallery*) uploadGallery;

- (ZFAccessDescriptor*) defaultAccessDescriptor;
- (void) saveDefaultAccessDescriptor:(ZFAccessDescriptor*) accessDescriptor;

@end
