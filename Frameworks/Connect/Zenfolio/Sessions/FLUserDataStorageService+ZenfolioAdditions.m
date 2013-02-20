//
//  FLZenfolioUserDataStoragetService.m
//  ZenLib
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUserDataStorageService+ZenfolioAdditions.h"
#import "NSString+GUID.h"
#import "NSFileManager+FLExtras.h"

#import "FLZenfolioPhotoInfo.h"
#import "FLUserDataStorageService.h"
#import "FLZenfolioWebApi.h"

@implementation FLUserDataStorageService (Zenfolio)

- (FLZenfolioUploadGallery*) defaultUploadGallery {
	FLZenfolioUploadGallery* input = [FLZenfolioUploadGallery uploadGallery];
	input.uid = [NSString zeroGuidString];
	FLZenfolioUploadGallery* output = [self.documentsDatabase readObject:input];
	return output ? output : input; 
}

- (void) saveDefaultUploadGallery:(FLZenfolioUploadGallery*) uploadGallery {
	uploadGallery.uid = [NSString zeroGuidString];
	[self.documentsDatabase writeObject:uploadGallery];
}

- (FLZenfolioAccessDescriptor*) defaultAccessDescriptor {
	
    FLZenfolioAccessDescriptor* input = [FLZenfolioAccessDescriptor accessDescriptor];
	input.uid = [NSString zeroGuidString];
	FLZenfolioAccessDescriptor* output = [self.documentsDatabase readObject:input];
	
    if(!output) {
		output = input;
		output.IsDerivedValue = YES;
		output.AccessTypeValue = FLZenfolioAccessTypePrivate; // StringFromZfAccessType(FLZenfolioAccessTypePrivate);
		output.AccessMaskValue = FLZenfolioApiAccessMaskNone; // StringFromZfApiAccessMask(FLZenfolioApiAccessMaskNone);
	}
	
	return output;
}

- (void) saveDefaultAccessDescriptor:(FLZenfolioAccessDescriptor*) accessDescriptor {
	accessDescriptor.uid = [NSString zeroGuidString];
	[self.documentsDatabase writeObject:self];
}

@end



