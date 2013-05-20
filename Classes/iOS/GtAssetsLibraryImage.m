//
//	GtAssetsLibraryImage.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/22/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAssetsLibraryImage.h"
#import "GtAssetsLibraryImageAsset.h"
#import "GtAssetsLibrary.h" 
#import "GtTempFileMgr.h"

@interface GtAssetsLibraryImage ()
@property (readwrite, retain, nonatomic) NSURL* assetURL; // file: or asset:
@property (readwrite, retain, nonatomic) ALAsset* asset;
@property (readwrite, assign, nonatomic) GtAssetsLibraryImageSize imageSize;
@property (readwrite, retain, nonatomic) NSDictionary* properties;
@property (readwrite, retain, nonatomic) UIImage* image;
@end

@implementation GtAssetsLibraryImage

@synthesize image = m_image;
@synthesize imageSize = m_imageSize;
@synthesize properties = m_properties;
@synthesize asset = m_asset;
@synthesize assetURL = m_assetURL;

- (id) initWithALAsset:(ALAsset*) asset 
             imageSize:(GtAssetsLibraryImageSize) imageSize;
{
	GtAssertNotNil(asset);

	if((self = [super init]))
	{
		m_asset = GtRetain(asset);
		m_imageSize = imageSize;
	}	 
	return self;
}

- (id) initWithAssetURL:(NSURL*) assetURL  
              imageSize:(GtAssetsLibraryImageSize) imageSize
{
	GtAssertNotNil(assetURL);

	if((self = [super init]))
	{
		m_assetURL = GtRetain(assetURL);
		m_imageSize = imageSize;
	}	 
	return self;
}

- (id) initWithOriginalImage:(UIImage*) image 
                    exifData:(NSDictionary*) exif 
{
	GtAssertNotNil(image);

	if((self = [super init]))
	{
		[self setImage:image exifData:exif];
		m_imageSize = GtAssetsLibraryImageSizeOriginal;
	}	 
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_asset);
	GtRelease(m_assetURL);
	GtRelease(m_properties);
	GtRelease(m_image);
	GtSuperDealloc();
}

- (NSURL*) assetURL
{
	if(!m_assetURL && m_asset)
	{
		m_assetURL = GtRetain(self.asset.defaultRepresentation.url);
	}
	
	return m_assetURL;
}

- (NSDictionary*) properties
{
	GtAssertNotNil(self.asset);

	if(!m_properties)
	{
		m_properties = GtRetain(self.asset.defaultRepresentation.metadata);
	}
	
	return m_properties;
}

- (void) setImage:(UIImage*) image 
         exifData:(NSDictionary*) exif
{
    GtAssignObject(m_image, image);
	GtAssignObject(m_properties, exif);
}

- (void) setImageRef:(CGImageRef) imageRef 
               scale:(float) scale
         orientation:(UIImageOrientation) orientation
{
	UIImage* image = [[UIImage alloc] initWithCGImage:imageRef scale:scale orientation:orientation];
	[self setImage:image exifData:nil];
	GtReleaseWithNil(image);
}

- (BOOL) canWriteToStorage
{
	return self.imageSize == GtAssetsLibraryImageSizeOriginal && !self.existsInStorage;
}

- (BOOL) canDeleteFromStorage
{
	return NO;
}

- (void) beginLoadingRepresentation:(GtErrorCallback) finishedLoadingBlock
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
        finishedLoadingBlock = GtReturnAutoreleased([finishedLoadingBlock copy]);

        [[GtAssetsLibrary instance] assetForURL:self.assetURL
            resultBlock:^(ALAsset *asset) {
                self.asset = asset;
                if(finishedLoadingBlock)
                {
                    finishedLoadingBlock(nil);
                }
            }
            failureBlock:^(NSError *error) {
                self.asset = nil;
                GtLog(@"Load asset error: %@", [error debugDescription]);
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
        case GtAssetsLibraryImageSizeOriginal:
            [self setImageRef:self.asset.defaultRepresentation.fullResolutionImage 
                scale:self.asset.defaultRepresentation.scale 
                    orientation:(UIImageOrientation)self.asset.defaultRepresentation.orientation];
            break;
            
        case GtAssetsLibraryImageSizeFullScreen:
            [self setImageRef:self.asset.defaultRepresentation.fullScreenImage 
                scale:self.asset.defaultRepresentation.scale 
                orientation:(UIImageOrientation)self.asset.defaultRepresentation.orientation];
            break;
            
        case GtAssetsLibraryImageSizeThumbnail: {
            UIImage* image = [[UIImage alloc] initWithCGImage:self.asset.thumbnail];
            [self setImage:image exifData:nil];
            GtReleaseWithNil(image);
            }
            break;
    }
}

- (void) beginReadFromStorage:(GtErrorCallback) completionBlock
{
    if(m_asset)
    {
        [self _readCorrectSizeFromStorage];
        if(completionBlock)
        {
            completionBlock(nil);
        }
    }
    else
    {
        completionBlock = GtReturnAutoreleased([completionBlock copy]);
    
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

- (void) beginWriteToStorage:(GtErrorCallback) completionBlock
{
	if(self.imageSize == GtAssetsLibraryImageSizeOriginal && !m_asset)
	{
		completionBlock = GtReturnAutoreleased([completionBlock copy]);
    
       	[[GtAssetsLibrary instance] writeImageToSavedPhotosAlbum:self.image.CGImage 
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

- (void) beginDeleteFromStorage:(GtErrorCallback) completionBlock
{
// TODO: No-can-do. Maybe someday.

    if(completionBlock)
    {
        completionBlock(nil);
    }
}

- (void) readFromStorage
{
    GtAssertNotNil(m_asset);
	
	if(self.asset)
	{
		switch(self.imageSize)
		{
			case GtAssetsLibraryImageSizeOriginal:
				[self setImageRef:self.asset.defaultRepresentation.fullResolutionImage 
					scale:self.asset.defaultRepresentation.scale 
						orientation:(UIImageOrientation)self.asset.defaultRepresentation.orientation];
				break;
				
			case GtAssetsLibraryImageSizeFullScreen:
				[self setImageRef:self.asset.defaultRepresentation.fullScreenImage 
					scale:self.asset.defaultRepresentation.scale 
					orientation:(UIImageOrientation)self.asset.defaultRepresentation.orientation];
				break;
				
			case GtAssetsLibraryImageSizeThumbnail: {
				UIImage* image = [[UIImage alloc] initWithCGImage:self.asset.thumbnail];
				[self setImage:image exifData:nil];
				GtReleaseWithNil(image);
				}
				break;
		}
	}
}

- (void) writeToStorage
{
	if(self.imageSize == GtAssetsLibraryImageSizeOriginal && !m_asset)
	{
		NSCondition* lock = [[NSCondition alloc] init];
		[lock lock];
		__block NSError* error = nil;
		@try
		{
			[[GtAssetsLibrary instance] writeImageToSavedPhotosAlbum:self.image.CGImage 
				orientation:(ALAssetOrientation) self.image.imageOrientation
				completionBlock: ^(NSURL *assetURL, NSError *blockError){
					error = GtReturnAutoreleased(GtRetain(blockError));
					self.assetURL = assetURL;
					[lock signal];
					}];
		
			[lock wait];
		}
		@finally
		{
			[lock unlock];
			GtReleaseWithNil(lock);
		}
		
		if(error)
		{
			GtThrowError(error);
		}
	}
}

- (NSInputStream*) createReadStream
{
/*
//	  NSURL* url = self.asset.defaultRepresentation.url;

	NSInputStream* stream = [[GtAssetsLibraryInputStream alloc] initWithAssetRepresentation:self.asset.defaultRepresentation];
	if(outStream)
	{
		*outStream = GtRetain(stream);
	}
	
	GtReleaseWithNil(stream);
	
	return self.asset.defaultRepresentation.size;
*/

	return nil; // TODO
}

- (unsigned long long) sizeInStorage
{
    GtAssertNotNil(self.asset);
	return m_asset.defaultRepresentation.size;
}

- (BOOL) existsInStorage
{
    GtAssertNotNil(self.asset);
	return self.asset != nil;
}

- (void) deleteFromStorage
{
}

- (GtJpegFile*) createTempFileForStreamingInFolder:(GtFolder*) folder fileName:(NSString*) fileName
{
	if(!self.image)
	{
		[self readFromStorage];
	}
	
	GtJpegFile* tempFile = GtReturnAutoreleased([[GtJpegFile alloc] initWithImage:self.image exifData:self.properties folder:folder fileName:fileName]);
    [[GtTempFileMgr instance] addFile:tempFile];
	[tempFile writeToStorage];
    return tempFile;
}

- (GtJpegFile*) saveToImageFileInFolder:(GtFolder*) folder 
                               fileName:(NSString*) fileName
{
	if(!self.image)
	{
		[self readFromStorage];
	}
	
	GtJpegFile* toFile = GtReturnAutoreleased([[GtJpegFile alloc] initWithImage:self.image exifData:self.properties folder:folder fileName:fileName]);
	[toFile writeToStorage];
	
	return toFile;
}

- (BOOL) hasImage
{
	return m_image != nil;
}

- (void) releaseImage
{
	GtReleaseWithNil(m_image);
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
	GtAssetsLibraryImage* outImage = [[GtAssetsLibraryImage alloc] initWithAssetURL:self.assetURL imageSize:self.imageSize];
	outImage.image = self.image;
	outImage.asset = self.asset;
	outImage.properties = self.properties;
	return outImage;
}


@end

/*
@implementation GtAssetsLibraryInputStream

- (id) initWithAssetRepresentation:(ALAssetRepresentation*) representation
{
	if(self = [super init])
	{
		m_assetRepresentation = GtRetain(representation);
		m_status = NSStreamStatusNotOpen;
		m_delegate = self;
	}
	
	return self;
}

- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)len
{
	NSUInteger fetchSize = MIN(len, m_assetSize - m_bytesSent);
	
	m_dataSizeInBuffer = [m_assetRepresentation getBytes:m_buffer fromOffset:m_bytesSent length:fetchSize error:&m_error];

	m_bytesSent += m_dataSizeInBuffer;

	GtLog(@"Requesting: %d bytes, requesting: %d, got %d", len, fetchSize, m_dataSizeInBuffer);

	if(m_error)
	{
		m_status = NSStreamStatusError;
	}
	else if (m_dataSizeInBuffer == 0 || m_bytesSent >= m_assetSize)
	{
		m_status = NSStreamStatusAtEnd;
	}
	else 
	{
		m_status = NSStreamStatusReading;
	}

	return m_dataSizeInBuffer;
}

- (BOOL)getBuffer:(uint8_t **)buffer length:(NSUInteger *)len
{
	if(buffer)
	{
		*buffer = m_buffer;
	}
	if(len)
	{
		*len = m_dataSizeInBuffer;
	}
	return YES;
}
 
- (BOOL)hasBytesAvailable
{
	return m_bytesSent < m_assetSize;
}

- (NSError *)streamError
{
	return m_error;
}

- (void)open
{
	GtReleaseWithNil(m_error);
	m_status = NSStreamStatusOpen;
	m_bytesSent = 0;
	m_assetSize = m_assetRepresentation.size;
}
- (void)close
{
	m_status = NSStreamStatusClosed;
}

- (id <NSStreamDelegate>)delegate
{
	return m_delegate;
}
- (void)setDelegate:(id <NSStreamDelegate>)delegate
{
	m_delegate = delegate;
	
	if(!m_delegate)
	{
		m_delegate = self;
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
	return m_status;
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