//
//  ZFUserDataStoragetService.m
//  ZenLib
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUserDataStorageService+Zenfolio.h"
#import "ZFPhotoInfo.h"
#import "NSString+GUID.h"
#import "NSFileManager+FLExtras.h"
#import "FLUserDataStorageService.h"

@implementation FLDataStoreService (Zenfolio)

- (ZFUploadGallery*) defaultUploadGallery {
	ZFUploadGallery* input = [ZFUploadGallery uploadGallery];
	input.uid = [NSString zeroGuidString];
	ZFUploadGallery* output = [self readObject:input];
	return output ? output : input; 
}

- (void) saveDefaultUploadGallery:(ZFUploadGallery*) uploadGallery {
	uploadGallery.uid = [NSString zeroGuidString];
	[self writeObject:uploadGallery];
}

- (ZFAccessDescriptor*) defaultAccessDescriptor {
	
    ZFAccessDescriptor* input = [ZFAccessDescriptor accessDescriptor];
	input.uid = [NSString zeroGuidString];
	ZFAccessDescriptor* output = [self readObject:input];
	
    if(!output) {
		output = input;
		output.IsDerivedValue = YES;
		output.AccessTypeValue = ZFAccessTypePrivate; // StringFromZfAccessType(ZFAccessTypePrivate);
		output.AccessMaskValue = ZFApiAccessMaskNone; // StringFromZfApiAccessMask(ZFApiAccessMaskNone);
	}
	
	return output;
}

- (void) saveDefaultAccessDescriptor:(ZFAccessDescriptor*) accessDescriptor {
	accessDescriptor.uid = [NSString zeroGuidString];
	[self writeObject:self];
}


@end



