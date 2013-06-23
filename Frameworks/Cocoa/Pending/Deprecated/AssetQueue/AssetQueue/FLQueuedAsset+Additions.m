// [Generated]
//
// FLQueuedAsset.m
// Project: FishLamp Mobile
// Schema: AssetQueueObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
// [/Generated]

#import "FLQueuedAsset.h"
#import "NSString+GUID.h"

#import "FLAssetFactory.h"

@implementation FLQueuedAsset (MyCode)

- (id) initWithImageAsset:(id<FLImageAsset>) photo 	   
                assetType:(FLAssetType) assetType
{
	FLAssertIsNotNilWithComment(photo, nil);

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
	return FLAutorelease([[[self class] alloc] initWithAssetUID:assetUID]);
}

- (id<FLImageAsset>) imageAsset {
	FLAssertIsNotNilWithComment(self.assetObject, nil);

	return (id<FLImageAsset>) self.assetObject;
}

- (void) setImageAsset:(id<FLImageAsset>) imageAsset {
	self.assetObject = (FLAsset*) imageAsset;
}

- (NSString*) displayName {
	return FLStringIsNotEmpty(self.assetName) ? self.assetName : self.assetFileName;
}


@end
