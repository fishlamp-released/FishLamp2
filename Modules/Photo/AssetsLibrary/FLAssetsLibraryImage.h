//
//	FLAssetsLibraryImage.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLStorableImage.h"

#import "FLJpegFile.h"

typedef enum {
	FLAssetsLibraryImageSizeOriginal,
	FLAssetsLibraryImageSizeFullScreen,
	FLAssetsLibraryImageSizeThumbnail
} FLAssetsLibraryImageSize;

@class FLAssetsLibraryImageAsset;

@interface FLAssetsLibraryImage : NSObject<FLStorableImage> {
@private
	UIImage* m_image;
	FLAssetsLibraryImageSize m_imageSize;
	ALAsset* m_asset;
	NSDictionary* m_properties;
	NSURL* m_assetURL;
}

@property (readonly, retain, nonatomic) NSURL* assetURL; // file: or asset:
@property (readonly, retain, nonatomic) ALAsset* asset;
@property (readonly, assign, nonatomic) FLAssetsLibraryImageSize imageSize;

- (id) initWithOriginalImage:(UIImage*) image 
                    exifData:(NSDictionary*) exif;

- (id) initWithALAsset:(ALAsset*) asset 
             imageSize:(FLAssetsLibraryImageSize) imageSize;

- (id) initWithAssetURL:(NSURL*) assetURL  
              imageSize:(FLAssetsLibraryImageSize) imageSize;

- (FLJpegFile*) saveToImageFileInFolder:(FLFolder*) folder fileName:(NSString*) fileName;  

//- (void) readAssetFromLibrary; // deprecated. This is a digusting vile hack.

@end

/*
#define FLAssetsLibaryBufferSize (1024 * 48)

@interface FLAssetsLibraryInputStream : NSInputStream {
@private
	ALAssetRepresentation* m_assetRepresentation;
	unsigned long long m_bytesSent;
	unsigned long long m_assetSize;
	NSError* m_error;
	uint8_t m_buffer[FLAssetsLibaryBufferSize];
	
	NSUInteger m_dataSizeInBuffer;
	NSStreamStatus m_status;
	id m_delegate;
}

- (id) initWithAssetRepresentation:(ALAssetRepresentation*) representation;


@end
*/