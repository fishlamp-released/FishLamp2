//
//	GtAssetsLibraryImage.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtStorableImage.h"

#import "GtJpegFile.h"

typedef enum {
	GtAssetsLibraryImageSizeOriginal,
	GtAssetsLibraryImageSizeFullScreen,
	GtAssetsLibraryImageSizeThumbnail
} GtAssetsLibraryImageSize;

@class GtAssetsLibraryImageAsset;

@interface GtAssetsLibraryImage : NSObject<GtStorableImage> {
@private
	UIImage* m_image;
	GtAssetsLibraryImageSize m_imageSize;
	ALAsset* m_asset;
	NSDictionary* m_properties;
	NSURL* m_assetURL;
}

@property (readonly, retain, nonatomic) NSURL* assetURL; // file: or asset:
@property (readonly, retain, nonatomic) ALAsset* asset;
@property (readonly, assign, nonatomic) GtAssetsLibraryImageSize imageSize;

- (id) initWithOriginalImage:(UIImage*) image 
                    exifData:(NSDictionary*) exif;

- (id) initWithALAsset:(ALAsset*) asset 
             imageSize:(GtAssetsLibraryImageSize) imageSize;

- (id) initWithAssetURL:(NSURL*) assetURL  
              imageSize:(GtAssetsLibraryImageSize) imageSize;

- (GtJpegFile*) saveToImageFileInFolder:(GtFolder*) folder fileName:(NSString*) fileName;  

//- (void) readAssetFromLibrary; // deprecated. This is a digusting vile hack.

@end

/*
#define GtAssetsLibaryBufferSize (1024 * 48)

@interface GtAssetsLibraryInputStream : NSInputStream {
@private
	ALAssetRepresentation* m_assetRepresentation;
	unsigned long long m_bytesSent;
	unsigned long long m_assetSize;
	NSError* m_error;
	uint8_t m_buffer[GtAssetsLibaryBufferSize];
	
	NSUInteger m_dataSizeInBuffer;
	NSStreamStatus m_status;
	id m_delegate;
}

- (id) initWithAssetRepresentation:(ALAssetRepresentation*) representation;


@end
*/