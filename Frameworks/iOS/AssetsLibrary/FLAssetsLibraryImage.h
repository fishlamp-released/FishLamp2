//
//	FLAssetsLibraryImage.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
	UIImage* _image;
	FLAssetsLibraryImageSize _imageSize;
	ALAsset* _asset;
	NSDictionary* _properties;
	NSURL* _assetURL;
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
	ALAssetRepresentation* _assetRepresentation;
	unsigned long long _bytesSent;
	unsigned long long _assetSize;
	NSError* _error;
	uint8_t _buffer[FLAssetsLibaryBufferSize];
	
	NSUInteger _dataSizeInBuffer;
	NSStreamStatus _status;
	id _delegate;
}

- (id) initWithAssetRepresentation:(ALAssetRepresentation*) representation;


@end
*/