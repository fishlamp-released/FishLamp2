// [Generated]
//
// FLQueuedAsset.m
// Project: FishLamp Mobile
// Schema: AssetQueueObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//
// [/Generated]

#import "__FLQueuedAsset.h"
#import "FLQueuedAsset.h"
#import "NSString+GUID.h"

#import "FLAssetFactory.h"

@implementation FLQueuedAsset (MyCode)

- (id) initWithImageAsset:(id<FLImageAsset>) photo 	   
                assetType:(FLAssetType) assetType
{
	FLAssertIsNotNil_v(photo, nil);

    self = [super init];
	if(self) {
        if(photo) {
            if(FLStringIsEmpty(photo.assetUID)) {
                photo.assetUID = [NSString guidString];
            }
        
            self.assetUID = photo.assetUID;
            self.assetURL = [photo.assetURL absoluteString];
            self.assetTypeValue = assetType;
            self.createdDate = photo.takenDate; 
            if(!self.createdDate) {
                self.createdDate = [NSDate date];
            }
            
            self.modifiedDate = self.createdDate;
            self.imageAsset = photo;
        }
	}
	return self;
}


- (void) createAssetIfNeeded {
//	if(!self.assetObject) {
//        self.assetObject = [[FLAssetFactory instance] createAssetForQueuedAsset:self];
//	}
}

- (id) initWithAssetUID:(NSString*) assetUID {
	if((self = [super init])) {
		self.assetUID = assetUID;
	}
	
	return self;
} 

+ (id) queuedAsset:(NSString*) assetUID {
	return autorelease_([[[self class] alloc] initWithAssetUID:assetUID]);
}

- (id<FLImageAsset>) imageAsset {
	FLAssertIsNotNil_v(self.assetObject, nil);

	return (id<FLImageAsset>) self.assetObject;
}

- (void) setImageAsset:(id<FLImageAsset>) imageAsset {
	self.assetObject = (FLAsset*) imageAsset;
}

- (NSString*) displayName {
	return FLStringIsNotEmpty(self.assetName) ? self.assetName : self.assetFileName;
}


@end
