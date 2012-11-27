//
//  FLFileAssetStorage.m
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLPhotoFolder.h"
#import "FLImage.h"

#define FLOriginalFileSuffix @"_O"
#define FLPreviewFileSuffix @"_F"
#define FLThumbnailFileSuffix @"_T"

@interface FLPhotoFolder () 
@property (readwrite, strong) FLFolder* folder;
@end

@implementation FLPhotoFolder

@synthesize folder = _folder;

static NSDictionary* s_suffixes = nil;
+ (void) initialize {
    if(!s_suffixes) {
        s_suffixes = [NSDictionary dictionaryWithObjectsAndKeys:
            FLOriginalFileSuffix, FLImageTypeOriginal, 
            FLPreviewFileSuffix, FLImageTypePreview, 
            FLThumbnailFileSuffix, FLImageTypeThumbnail, nil];
    }
}

#if FL_MRC
- (void) dealloc {
    [_folder release];
    [super dealloc];
}
#endif

- (NSString*) extensionForUTI:(NSString*) uti {
    return @"JPG";
}

- (id) initWithFolder:(FLFolder*) folder {
    self = [super init];
    if(self) {
        self.folder = folder;
    }
    return self;
}

// kUTTypeImage


- (id) readAssetFromStorage:(id) name {

    NSString* pathToFile = [_folder pathForFile:name];

    NSString* fileUTI = [_folder fileUTI:pathToFile];

    if (UTTypeConformsTo(bridge_(CFStringRef, fileUTI), kUTTypeImage)) {
        NSData* data = [_folder readDataFromFile:name];
        FLImage* photo = [FLImage photoWithImageBytes:data];
        photo.assetType = fileUTI;
        photo.storageKey = name;
        return photo;
    }
    else if (UTTypeConformsTo(bridge_(CFStringRef, fileUTI), kUTTypeMovie)) {
    }
    
    return nil;
}

- (FLImage*) readImageForStorageKey:(id) storageKey subType:(NSString*) subType {

    NSString* suffix = [s_suffixes objectForKey:subType];
    FLConfirmStringIsNotEmpty_v(subType, @"Unknown subtype: %@", subType);
    
// TODO: MUST WORK WITH ALL IMAGE TYPES!!    
    NSString* extension = @"JPG";
    
    NSString* fileName = [NSString stringWithFormat:@"%@%@.%@", storageKey, suffix, extension];

    NSData* data = [_folder readDataFromFile:fileName];
    if(data) {
        FLImage* image = [FLImage photoWithImageBytes:data];
        image.assetSubType = subType;
        image.assetType = [_folder fileUTI:fileName];
        image.storageKey = storageKey;
        return image;
    }
    
    return nil;
}

- (FLImage*) readOriginalImageForStorageKey:(id) storageKey {
	return [self readImageForStorageKey:storageKey subType:FLImageTypeOriginal];
}

- (FLImage*) readThumbnailImageForStorageKey:(id) storageKey {
	return [self readImageForStorageKey:storageKey subType:FLImageTypeThumbnail];
}

- (FLImage*) readPreviewImageForStorageKey:(id) storageKey {
	return [self readImageForStorageKey:storageKey subType:FLImageTypePreview];
}

- (FLPhoto*) readPhoto:(id) storageKey {
    FLPhoto* photo = [FLPhoto photo];
    photo.storageKey = storageKey;
    return photo;
}

- (NSDictionary*) readPropertiesForStorageKey:(id) storageKey {
//	if(!_properties) {
//		[self _throwIfNotConfigured];
//
//		NSURL* url = [[NSURL alloc] initFileURLWithPath:[self.folder pathForFile:self.fileName]];
//		CGImageSourceRef imageSourceRef = nil;
//		@try
//		{
//			imageSourceRef = CGImageSourceCreateWithURL(bridge_(void*,url), nil);
//			if(imageSourceRef)
//			{
//				self.properties = 
//                    autorelease_(bridge_(NSDictionary*,
//                        CGImageSourceCopyPropertiesAtIndex(imageSourceRef, 0, nil)));
//			}
//		}
//		@finally
//		{
//			if(imageSourceRef)
//			{
//				CFRelease(imageSourceRef);
//			}
//		
//			FLReleaseWithNil_(url);
//		}
//	}
//
//	return _properties;

    return nil;
}

- (void) writeImage:(FLImage*) image withCompression:(CGFloat) compression {

    FLAssert_(compression >= 0.0 && compression <= 1.0);

    NSData* bytes = image.imageBytes;
    NSString* uti = image.storageType;
    NSString* fileName = image.storageKey;
    NSDictionary* properties = image.properties;

    NSString* filePath = [self.folder pathForFile:fileName];

    FLAssertStringIsNotEmpty_(filePath);

    NSURL* url = [[NSURL alloc] initFileURLWithPath:filePath];
    FLAssertIsNotNil_(url);
    
    CGImageDestinationRef imageDestRef = nil;
    CGImageSourceRef imageSourceRef = nil;
    @try {
        FLAssertIsNotNil_(bytes);
        FLAssert_v(bytes.length > 0, @"image is of size zero");
    
        imageDestRef = CGImageDestinationCreateWithURL(bridge_(void*,url), bridge_(CFStringRef, uti), 1, nil /* always nil */);
        FLConfirmIsNotNil_(imageDestRef);

        NSDictionary* compressionInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:compression] forKey: bridge_(NSString* kCGImageDestinationLossyCompressionQuality)];

        CGImageDestinationSetProperties(imageDestRef, bridge_(CFDictionaryRef, compressionInfo));

        imageSourceRef = CGImageSourceCreateWithData(bridge_(void*,jpgData), nil);
        FLConfirmIsNotNil_(imageSourceRef);
        
        if(properties) {
            CGImageDestinationAddImageFromSource(imageDestRef, imageSourceRef, 0, bridge_(void*,properties));
        }
        
        if(!CGImageDestinationFinalize(imageDestRef)){
             FLDebugLog(@"wth - image finalize failed");
        } 
    }
    @finally {
        FLReleaseCRef_(imageSourceRef);
        FLReleaseCRef_(imageDestRef);
        FLReleaseWithNil_(url);
    }
}

- (void) writeImage:(FLImage*) image withCompression:(CGFloat) compression {
    [self writeImage:image withCompression:1.0f];
}

- (void) writePhoto:(FLPhoto*) photo {


}

//
//- (void) writeImageToStorage {
//    FLAssertStringIsNotEmpty_v(self.filePath, nil);
//
//    NSURL* url = [[NSURL alloc] initFileURLWithPath:self.filePath];
//    FLAssertIsNotNil_v(url, nil);
//    
//    CGImageDestinationRef imageSourceRef = nil;
//    @try {
//        NSImage_* image = self.image;
//        FLAssertIsNotNil_v(image, nil);
//
//#if IOS        
//        CGImageRef imageRef = image.CGImage;
//#else
//// TODO: (how to get CGImage from NSImage_?)
//        
//        CGImageRef imageRef = nil;
//        
//        FLAssertIsImplemented_v(nil);
//        
//        #pragma unused (image)
//#endif        
//        
//        FLAssertIsNotNil_v(imageRef, nil);
//    
//        imageSourceRef = CGImageDestinationCreateWithURL(bridge_(void*,url), kUTTypeJPEG, 1, nil /* always nil */);
//        
//        CGImageDestinationSetProperties(imageSourceRef, bridge_(void*,s_destinationProperties));
//        
//        CGImageDestinationAddImage(imageSourceRef, imageRef, bridge_(void*,self.properties));
//
//        if(!CGImageDestinationFinalize(imageSourceRef)) {
//            FLDebugLog(@"Writing image failed");
//        
//// TODO: there must be a wait to get an error code or something?? wtf.        
//        }
//    }
//    @finally {
//        if(imageSourceRef) {		
//            CFRelease(imageSourceRef);
//        }
//        release_(url);
//    }
//}
//
//- (void) writeToStorage {
//	[self _throwIfNotConfigured];
//	
//	if(!_image && !_jpegData) {
//		FLThrowError_([NSError errorWithDomain:[FLFrameworkErrorDomain instance] code:FLErrorNoDataToSave
//			userInfo:[NSDictionary dictionaryWithObject:@"No image data to save" forKey:NSLocalizedDescriptionKey]]);
// 
//	}
//	
//    if(_jpegData) {
//		[self writeJpegToStorage];
//	}
//	else {
//        [self writeImageToStorage];
//    }
//
//#if DEBUG	
//	if(![[NSFileManager defaultManager] fileExistsAtPath:self.filePath]) {
//		FLDebugLog(@"Saving image file Failed:%@", self.filePath);
//	}
//#endif
//}


//- (void) writeImage:(FLImage*) image subType:(NSString*) subType forStorageKey:(id) storageKey {
//
//}
//
//- (void) writePreviewImage:(FLImage*) image forStorageKey:(id) storageKey {
//    [self writeImage:image subType:FLImageTypePreview forStorageKey:storageKey];
//}
//
//- (void) writeOriginalImage:(FLImage*) image forStorageKey:(id) storageKey {
//    [self writeImage:image subType:FLImageTypeOriginal forStorageKey:storageKey];
//}
//
//- (void) writeThumbnailImage:(FLImage*) image forStorageKey:(id) storageKey {
//    [self writeImage:image subType:FLImageTypeThumbnail forStorageKey:storageKey];
//}





@end
