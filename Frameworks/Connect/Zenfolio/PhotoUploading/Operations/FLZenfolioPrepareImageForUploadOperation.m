//
//  FLZenfolioPrepareImageForUploadOperation.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/1/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLZenfolioPrepareImageForUploadOperation.h"

#import "ISO8601DateFormatter.h"
#import "FLDatabase.h"
#import "FishLampCocoa.h"

#import "NSFileManager+FLExtras.h"
#import "FLZenfolioUploadGallery.h"
#import "FLTempFileMgr.h"
#import "NSString+URL.h"
#import "NSString+GUID.h"

#import "FLUserDataStorageService.h"

#if IOS
//#import "FLAssetsLibraryImage.h"
#endif


#define kUploadFilePrefix @"UPLOAD_"

#define CreateNewUploadFileName() [NSString stringWithFormat:@"%@%@.JPG", kUploadFilePrefix, [NSString guidString]]

@implementation FLZenfolioPrepareImageForUploadOperation

@synthesize startFileSize = _startSize;
@synthesize finalFileSize = _finalSize;

- (id) initWithUploadablePhoto:(FLZenfolioQueuedPhoto*) photo
{
    if((self = [super init]))
    {
        _photo = FLRetain(photo);
	}
    
    return self;
}

- (FLJpegFile*) shrinkImageForUploadIfNeeded:(FLJpegFile*) imageFile
{
	if(_photo.scaledUploadSizeValue != kUploadOriginalSize)
	{
  
#if REFACTOR      
//#if IOS

FIXME("needs to be abstracted for mac, etc..")

		CGFloat resizeImageLongSide = (_photo.scaledUploadSizeValue == kUploadLargeSize) ? UploadLargeSize : UploadMediumSize;
		if(resizeImageLongSide > 0)
		{
			if(!imageFile.hasImage)
			{
				[imageFile readFromStorage];
			}
			
			FLJpegFile* uploadFile = FLAutorelease([[FLJpegFile alloc] initWithJpegData:nil 
				folder:[self.userContext userStorageService].tempFolder 
				fileName:CreateNewUploadFileName()] );
			[[FLTempFileMgr instance] addFile:uploadFile];
            
			UIImage* newImage = nil;
			
			[imageFile.image shrinkImage:&newImage 
							   maxLongSide:resizeImageLongSide
								makeSquare:NO];
			
			[uploadFile setImage:newImage exifDictionary:imageFile.properties]; 
			
			FLReleaseWithNil(newImage);
			
			[uploadFile writeToStorage];
			[uploadFile releaseImage];
			
            
			[imageFile releaseImage];
                
            NSError* error = nil;
			[NSFileManager getFileSize:uploadFile.filePath outSize:&_finalSize outError:&error];
            if(error)
            {   
                FLThrowError(FLAutorelease(error));
            }
			
			return uploadFile;
		}
#endif
    }
	
	return imageFile;
}

- (FLResult) runOperation {

// FIXME

//    FLAssertIsNotNil_(_photo);
//
//    FLJpegFile* imageFile = [_photo.imageAsset.original createTempFileForStreamingInFolder:[[self.userContext userStorageService] tempFolder]
//        fileName:CreateNewUploadFileName()
//        ];
//		
//	if(!imageFile) {
//        FLThrowErrorCode_v(FLZenfolioErrorDomain, FLZenfolioErrorCodeUploadMissingImage, @"Image is missing for upload");
//	}
//    
//    NSError* error = nil;
//    [NSFileManager getFileSize:imageFile.filePath outSize:&_startSize outError:&error];
//    if(error)
//    {
//        FLThrowError(FLAutorelease(error));
//    }
//    
//    _finalSize = _startSize;
//
//    return [self shrinkImageForUploadIfNeeded:imageFile];

return nil;
}

#if FL_MRC
- (void) dealloc {
    [_photo release];
    [super dealloc];
}
#endif


@end
