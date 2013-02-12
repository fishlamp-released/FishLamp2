//
//  ZFUserDataStoragetService.m
//  ZenLib
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUserDataStorageService+Zenfolio.h"
#import "FLZenfolioPhotoInfo.h"
#import "NSString+GUID.h"
#import "NSFileManager+FLExtras.h"
#import "FLUserDataStorageService.h"

@implementation FLUserDataStorageService (Zenfolio)

- (FLZenfolioUploadGallery*) defaultUploadGallery {
	FLZenfolioUploadGallery* input = [FLZenfolioUploadGallery uploadGallery];
	input.uid = [NSString zeroGuidString];
	FLZenfolioUploadGallery* output = [self.documentsDatabase loadObject:input];
	return output ? output : input; 
}

- (void) saveDefaultUploadGallery:(FLZenfolioUploadGallery*) uploadGallery {
	uploadGallery.uid = [NSString zeroGuidString];
	[self.documentsDatabase saveObject:uploadGallery];
}

- (FLZenfolioAccessDescriptor*) defaultAccessDescriptor {
	
    FLZenfolioAccessDescriptor* input = [FLZenfolioAccessDescriptor accessDescriptor];
	input.uid = [NSString zeroGuidString];
	FLZenfolioAccessDescriptor* output = [self.documentsDatabase loadObject:input];
	
    if(!output) {
		output = input;
		output.IsDerivedValue = YES;
		output.AccessTypeValue = FLZenfolioAccessTypePrivate; // StringFromZfAccessType(ZFAccessTypePrivate);
		output.AccessMaskValue = FLZenfolioApiAccessMaskNone; // StringFromZfApiAccessMask(FLZenfolioApiAccessMaskNone);
	}
	
	return output;
}

- (void) saveDefaultAccessDescriptor:(FLZenfolioAccessDescriptor*) accessDescriptor {
	accessDescriptor.uid = [NSString zeroGuidString];
	[self.documentsDatabase saveObject:self];
}


@end



