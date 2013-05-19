//
//	FLAssetsLibraryImage.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAssetsLibraryImage.h"
#import "FLAssetsLibraryImageAsset.h"
#import "FLAssetsLibrary.h" 
#import "FLTempFileMgr.h"

@interface FLAssetsLibraryImage ()
@property (readwrite, retain, nonatomic) NSURL* assetURL; // file: or asset:
@property (readwrite, retain, nonatomic) ALAsset* asset;
@property (readwrite, assign, nonatomic) FLAssetsLibraryImageSize imageSize;
@property (readwrite, retain, nonatomic) NSDictionary* properties;
@property (readwrite, retain, nonatomic) UIImage* image;
@end

@implementation FLAssetsLibraryImage

@synthesize image = _image;
@synthesize imageSize = _imageSize;
@synthesize properties = _properties;
@synthesize asset = _asset;
@synthesize assetURL = _assetURL;

- (id) initWithALAsset:(ALAsset*) asset 
             imageSize:(FLAssetsLibraryImageSize) imageSize {
	FLAssertIsNotNilWithComment(asset, nil);

	if((self = [super init]))
	{
		_asset = FLRetain(asset);
		_imageSize = imageSize;
	}	 
	return self;
}

- (id) initWithAssetURL:(NSURL*) assetURL  
              imageSize:(FLAssetsLibraryImageSize) imageSize
{
	FLAssertIsNotNilWithComment(assetURL, nil);

	if((self = [super init]))
	{
		_assetURL = FLRetain(assetURL);
		_imageSize = imageSize;
	}	 
	return self;
}

- (id) initWithOriginalImage:(UIImage*) image 
                    exifData:(NSDictionary*) exif 
{
	FLAssertIsNotNilWithComment(image, nil);

	if((self = [super init]))
	{
		[self setImage:image exifData:exif];
		_imageSize = FLAssetsLibraryImageSizeOriginal;
	}	 
	
	return self;
}

- (void) dealloc
{
	FLRelease(_asset);
	FLRelease(_assetURL);
	FLRelease(_properties);
	FLRelease(_image);
	FLSuperDealloc();
}

- (NSURL*) assetURL
{
	if(!_assetURL && _asset)
	{
		_assetURL = FLRetain(self.asset.defaultRepresentation.url);
	}
	
	return _assetURL;
}

- (NSDictionary*) properties
{
	FLAssertIsNotNilWithComment(self.asset, nil);

	if(!_properties)
	{
		_properties = FLRetain(self.asset.defaultRepresentation.metadata);
	}
	
	return _properties;
}

- (void) setImage:(UIImage*) image 
         exifData:(NSDictionary*) exif
{
    FLSetObjectWithRetain(_image, image);
	FLSetObjectWithRetain(_properties, exif);
}

- (void) setImageRef:(CGImageRef) imageRef 
               scale:(float) scale
         orientation:(UIImageOrientation) orientation
{
	UIImage* image = [[UIImage alloc] initWithCGImage:imageRef scale:scale orientation:orientation];
	[self setImage:image exifData:nil];
	FLReleaseWithNil(image);
}

- (BOOL) canWriteToStorage
{
	return self.imageSize == FLAssetsLibraryImageSizeOriginal && !self.existsInStorage;
}

- (BOOL) canDeleteFromStorage
{
	return NO;
}

- (void) beginLoadingRepresentation:(FLErrorCallback) finishedLoadingBlock
{
    if(self.asset)
    {
        if(finishedLoadingBlock)
        {
            finishedLoadingBlock(nil);
        }
    }
    else
    {
        finishedLoadingBlock = FLAutorelease([finishedLoadingBlock copy]);

        [[FLAssetsLibrary instance] assetForURL:self.assetURL
            resultBlock:^(ALAsset *asset) {
                self.asset = asset;
                if(finishedLoadingBlock)
                {
                    finishedLoadingBlock(nil);
                }
            }
            failureBlock:^(NSError *error) {
                self.asset = nil;
                FLLog(@"Load asset error: %@", [error debugDescription]);
                if(finishedLoadingBlock)
                {
                    finishedLoadingBlock(error);
                }
            }];
    }
}

- (void) _readCorrectSizeFromStorage
{
    switch(self.imageSize)
    {
        case FLAssetsLibraryImageSizeOriginal:
            [self setImageRef:self.asset.defaultRepresentation.fullResolutionImage 
                scale:self.asset.defaultRepresentation.scale 
                    orientation:(UIImageOrientation)self.asset.defaultRepresentation.orientation];
            break;
            
        case FLAssetsLibraryImageSizeFullScreen:
            [self setImageRef:self.asset.defaultRepresentation.fullScreenImage 
                scale:self.asset.defaultRepresentation.scale 
                orientation:(UIImageOrientation)self.asset.defaultRepresentation.orientation];
            break;
            
        case FLAssetsLibraryImageSizeThumbnail: {
            UIImage* image = [[UIImage alloc] initWithCGImage:self.asset.thumbnail];
            [self setImage:image exifData:nil];
            FLReleaseWithNil(image);
            }
            break;
    }
}

- (void) beginReadFromStorage:(FLErrorCallback) completionBlock
{
    if(_asset)
    {
        [self _readCorrectSizeFromStorage];
        if(completionBlock)
        {
            completionBlock(nil);
        }
    }
    else
    {
        completionBlock = FLAutorelease([completionBlock copy]);
    
        [self beginLoadingRepresentation:^(NSError* error) {
            if(!error)
            {
                [self _readCorrectSizeFromStorage];
            }
            
            if(completionBlock)
            {
                completionBlock(error);
            }
        }];
    }
}

- (void) beginWriteToStorage:(FLErrorCallback) completionBlock
{
	if(self.imageSize == FLAssetsLibraryImageSizeOriginal && !_asset)
	{
		completionBlock = FLAutorelease([completionBlock copy]);
    
       	[[FLAssetsLibrary instance] writeImageToSavedPhotosAlbum:self.image.CGImage 
				orientation:(ALAssetOrientation) self.image.imageOrientation
				completionBlock: ^(NSURL *assetURL, NSError *error){
					self.assetURL = assetURL;
                    if(completionBlock)
                    {
                        completionBlock(error);
                    }
				}];
	}
    else
    {
        if(completionBlock)
        {
            completionBlock(nil);
        }
    }
}

- (void) beginDeleteFromStorage:(FLErrorCallback) completionBlock
{
// TODO: No-can-do. Maybe someday.

    if(completionBlock)
    {
        completionBlock(nil);
    }
}

- (void) readFromStorage
{
    FLAssertIsNotNilWithComment(_asset, nil);
	
	if(self.asset)
	{
		switch(self.imageSize)
		{
			case FLAssetsLibraryImageSizeOriginal:
				[self setImageRef:self.asset.defaultRepresentation.fullResolutionImage 
					scale:self.asset.defaultRepresentation.scale 
						orientation:(UIImageOrientation)self.asset.defaultRepresentation.orientation];
				break;
				
			case FLAssetsLibraryImageSizeFullScreen:
				[self setImageRef:self.asset.defaultRepresentation.fullScreenImage 
					scale:self.asset.defaultRepresentation.scale 
					orientation:(UIImageOrientation)self.asset.defaultRepresentation.orientation];
				break;
				
			case FLAssetsLibraryImageSizeThumbnail: {
				UIImage* image = [[UIImage alloc] initWithCGImage:self.asset.thumbnail];
				[self setImage:image exifData:nil];
				FLReleaseWithNil(image);
				}
				break;
		}
	}
}

- (void) writeToStorage
{
	if(self.imageSize == FLAssetsLibraryImageSizeOriginal && !_asset)
	{
		NSCondition* lock = [[NSCondition alloc] init];
		[lock lock];
		__block NSError* error = nil;
		@try
		{
			[[FLAssetsLibrary instance] writeImageToSavedPhotosAlbum:self.image.CGImage 
				orientation:(ALAssetOrientation) self.image.imageOrientation
				completionBlock: ^(NSURL *assetURL, NSError *blockError){
					error = FLAutorelease(FLRetain(blockError));
					self.assetURL = assetURL;
					[lock signal];
					}];
		
			[lock wait];
		}
		@finally
		{
			[lock unlock];
			FLReleaseWithNil(lock);
		}
		
		if(error)
		{
			FLThrowError(error);
		}
	}
}

- (NSInputStream*) createReadStream
{
/*
//	  NSURL* url = self.asset.defaultRepresentation.url;

	NSInputStream* stream = [[FLAssetsLibraryInputStream alloc] initWithAssetRepresentation:self.asset.defaultRepresentation];
	if(outStream)
	{
		*outStream = FLRetain(stream);
	}
	
	FLReleaseWithNil(stream);
	
	return self.asset.defaultRepresentation.size;
*/

	return nil; // TODO
}

- (unsigned long long) sizeInStorage
{
    FLAssertIsNotNilWithComment(self.asset, nil);
	return _asset.defaultRepresentation.size;
}

- (BOOL) existsInStorage
{
    FLAssertIsNotNilWithComment(self.asset, nil);
	return self.asset != nil;
}

- (void) deleteFromStorage
{
}

- (FLJpegFile*) createTempFileForStreamingInFolder:(FLFolder*) folder fileName:(NSString*) fileName
{
	if(!self.image)
	{
		[self readFromStorage];
	}
	
	FLJpegFile* tempFile = FLAutorelease([[FLJpegFile alloc] initWithImage:self.image exifData:self.properties folder:folder fileName:fileName]);
    [[FLTempFileMgr instance] addFile:tempFile];
	[tempFile writeToStorage];
    return tempFile;
}

- (FLJpegFile*) saveToImageFileInFolder:(FLFolder*) folder 
                               fileName:(NSString*) fileName
{
	if(!self.image)
	{
		[self readFromStorage];
	}
	
	FLJpegFile* toFile = FLAutorelease([[FLJpegFile alloc] initWithImage:self.image exifData:self.properties folder:folder fileName:fileName]);
	[toFile writeToStorage];
	
	return toFile;
}

- (BOOL) hasImage
{
	return _image != nil;
}

- (void) releaseImage
{
	FLReleaseWithNil(_image);
}

- (CGSize) imageDimensions
{
    CGSize dimensions = CGSizeZero;
    NSDictionary* metadata = self.asset.defaultRepresentation.metadata;
    if(metadata)
    {
        NSNumber* width = [metadata objectForKey:(NSString*)kCGImagePropertyPixelWidth];
        NSNumber* height = [metadata objectForKey:(NSString*)kCGImagePropertyPixelHeight];

        if(width)
        {
            dimensions.width = width.floatValue;
        }
        if(height)
        {
            dimensions.height = height.floatValue;
        }
    }
	
	return dimensions;
}

- (id)copyWithZone:(NSZone *)zone
{
	FLAssetsLibraryImage* outImage = [[FLAssetsLibraryImage alloc] initWithAssetURL:self.assetURL imageSize:self.imageSize];
	outImage.image = self.image;
	outImage.asset = self.asset;
	outImage.properties = self.properties;
	return outImage;
}

+ (NSString*) assetURLPrefix {
    return @"assets-library";
}

@end

/*
@implementation FLAssetsLibraryInputStream

- (id) initWithAssetRepresentation:(ALAssetRepresentation*) representation
{
	if(self = [super init])
	{
		_assetRepresentation = FLRetain(representation);
		_status = NSStreamStatusNotOpen;
		_delegate = self;
	}
	
	return self;
}

- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)len
{
	NSUInteger fetchSize = MIN(len, _assetSize - _bytesSent);
	
	_dataSizeInBuffer = [_assetRepresentation getBytes:_buffer fromOffset:_bytesSent length:fetchSize error:&_error];

	_bytesSent += _dataSizeInBuffer;

	FLLog(@"Requesting: %d bytes, requesting: %d, got %d", len, fetchSize, _dataSizeInBuffer);

	if(_error)
	{
		_status = NSStreamStatusError;
	}
	else if (_dataSizeInBuffer == 0 || _bytesSent >= _assetSize)
	{
		_status = NSStreamStatusAtEnd;
	}
	else 
	{
		_status = NSStreamStatusReading;
	}

	return _dataSizeInBuffer;
}

- (BOOL)getBuffer:(uint8_t **)buffer length:(NSUInteger *)len
{
	if(buffer)
	{
		*buffer = _buffer;
	}
	if(len)
	{
		*len = _dataSizeInBuffer;
	}
	return YES;
}
 
- (BOOL)hasBytesAvailable
{
	return _bytesSent < _assetSize;
}

- (NSError *)streamError
{
	return _error;
}

- (void)open
{
	FLReleaseWithNil(_error);
	_status = NSStreamStatusOpen;
	_bytesSent = 0;
	_assetSize = _assetRepresentation.size;
}
- (void)close
{
	_status = NSStreamStatusClosed;
}

- (id <NSStreamDelegate>)delegate
{
	return _delegate;
}
- (void)setDelegate:(id <NSStreamDelegate>)delegate
{
	_delegate = delegate;
	
	if(!_delegate)
	{
		_delegate = self;
	}
}

- (id)propertyForKey:(NSString *)key
{
	return nil;
}
- (BOOL)setProperty:(id)property forKey:(NSString *)key
{
	return NO;
}

- (void)scheduleInRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode
{
	[super scheduleInRunLoop:aRunLoop forMode:mode];
}

- (void)removeFromRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode
{
	[super removeFromRunLoop:aRunLoop forMode:mode];
}

- (NSStreamStatus)streamStatus
{
	return _status;
}

- (void)stream:(NSStream *)aStream handleEvent:(NSStreamEvent)eventCode
{
}

- (void) _scheduleInCFRunLoop: (NSRunLoop *) inRunLoop forMode: (id) inMode
{
	// Safe to ignore this?
}

- (void) _setCFClientFlags: (CFOptionFlags)inFlags
				 callback: (CFReadStreamClientCallBack) inCallback
				  context: (CFStreamClientContext) inContext
{
   // Safe to ignore this?
}

@end
*/