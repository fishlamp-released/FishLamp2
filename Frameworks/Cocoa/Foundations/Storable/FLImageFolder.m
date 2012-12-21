//
//  FLFileAssetStorage.m
//  Downloader
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLImageFolder.h"
#import "FLStorableImage.h"
#import "FLCoreFoundation.h"

#define FLOriginalFileSuffix @"_O"
#define FLPreviewFileSuffix @"_F"
#define FLThumbnailFileSuffix @"_T"

@interface FLImageFolder () 
//@property (readwrite, strong) FLFolder* folder;
@end

@implementation FLImageFolder

//@synthesize folder = _folder;

static NSDictionary* s_suffixes = nil;
+ (void) initialize {
    if(!s_suffixes) {
        s_suffixes = [NSDictionary dictionaryWithObjectsAndKeys:
            FLOriginalFileSuffix, FLImageTypeOriginal, 
            FLPreviewFileSuffix, FLImageTypePreview, 
            FLThumbnailFileSuffix, FLImageTypeThumbnail, nil];
    }
}

//#if FL_MRC
//- (void) dealloc {
//    [_folder release];
//    [super dealloc];
//}
//#endif

- (NSString*) extensionForUTI:(NSString*) uti {
    return @"JPG";
}

//- (id) initWithFolder:(FLFolder*) folder {
//    self = [super init];
//    if(self) {
//        self = folder;
//    }
//    return self;
//}

// kUTTypeImage


- (id) readAssetFromStorage:(id) name {

    NSString* pathToFile = [self pathForFile:name];

    NSString* fileUTI = [self fileUTI:pathToFile];

    if (UTTypeConformsTo(bridge_(CFStringRef, fileUTI), kUTTypeImage)) {
        NSData* data = [self readDataFromFile:name];
        FLStorableImage* image = [FLStorableImage imageWithData:data];
        image.storableType = fileUTI;
        image.storageKey = name;
        return image;
    }
    else if (UTTypeConformsTo(bridge_(CFStringRef, fileUTI), kUTTypeMovie)) {
    }
    
    return nil;
}

- (FLStorableImage*) readImageForStorageKey:(id) storageKey subType:(NSString*) subType {

    NSString* suffix = [s_suffixes objectForKey:subType];
    FLConfirmStringIsNotEmpty_v(subType, @"Unknown subtype: %@", subType);
    
// TODO: MUST WORK WITH ALL IMAGE TYPES!!    
    NSString* extension = @"JPG";
    
    NSString* fileName = [NSString stringWithFormat:@"%@%@.%@", storageKey, suffix, extension];

    NSData* data = [self readDataFromFile:fileName];
    if(data) {
        FLStorableImage* image = [FLStorableImage imageWithData:data];
        image.storableSubType = subType;
        image.storableType = [self fileUTI:fileName];
        image.storageKey = storageKey;
        return image;
    }
    
    return nil;
}

- (FLStorableImage*) readOriginalImageForStorageKey:(id) storageKey {
	return [self readImageForStorageKey:storageKey subType:FLImageTypeOriginal];
}

- (FLStorableImage*) readThumbnailImageForStorageKey:(id) storageKey {
	return [self readImageForStorageKey:storageKey subType:FLImageTypeThumbnail];
}

- (FLStorableImage*) readPreviewImageForStorageKey:(id) storageKey {
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
//		NSURL* url = [[NSURL alloc] initFileURLWithPath:[self pathForFile:self.fileName]];
//		CGImageSourceRef imageSourceRef = nil;
//		@try
//		{
//			imageSourceRef = CGImageSourceCreateWithURL(bridge_(void*,url), nil);
//			if(imageSourceRef)
//			{
//				self.properties = 
//                    FLAutorelease(bridge_(NSDictionary*,
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
//			FLReleaseWithNil(url);
//		}
//	}
//
//	return _properties;

    return nil;
}

- (void) writeImage:(FLStorableImage*) image withCompression:(CGFloat) compression {

    FLAssert_(compression >= 0.0 && compression <= 1.0);

    NSData* bytes = image.imageData;
    NSString* uti = image.storableType;
    NSString* fileName = image.storageKey;
    NSDictionary* properties = image.exifDictionary;

    NSString* filePath = [self pathForFile:fileName];

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

        NSDictionary* compressionInfo = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:compression] forKey: bridge_(NSString*, kCGImageDestinationLossyCompressionQuality)];

        CGImageDestinationSetProperties(imageDestRef, bridge_(CFDictionaryRef, compressionInfo));

        imageSourceRef = CGImageSourceCreateWithData(bridge_(void*, bytes), nil);
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
        FLReleaseWithNil(url);
    }
}

- (void) writeImage:(FLStorableImage*) image {
    [self writeImage:image withCompression:1.0f];
}

- (void) writePhoto:(FLPhoto*) photo {


}

- (id<FLImageStorage>) imageStorage:(FLStorableImage*) image {
    return self;
}

- (void) deleteImage:(FLStorableImage*) image {

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
//        FLStorableImage* image = self.image;
//        FLAssertIsNotNil_v(image, nil);
//
//#if IOS        
//        CGImageRef imageRef = image.CGImage;
//#else
//// TODO: (how to get CGImage from FLStorableImage?)
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
//        FLRelease(url);
//    }
//}
//
//- (void) writeToStorage {
//	[self _throwIfNotConfigured];
//	
//	if(!_image && !_jpegData) {
//		FLThrowError([NSError errorWithDomain:[FLFrameworkErrorDomain instance] code:FLErrorNoDataToSave
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


//- (void) writeImage:(FLStorableImage*) image subType:(NSString*) subType forStorageKey:(id) storageKey {
//
//}
//
//- (void) writePreviewImage:(FLStorableImage*) image forStorageKey:(id) storageKey {
//    [self writeImage:image subType:FLImageTypePreview forStorageKey:storageKey];
//}
//
//- (void) writeOriginalImage:(FLStorableImage*) image forStorageKey:(id) storageKey {
//    [self writeImage:image subType:FLImageTypeOriginal forStorageKey:storageKey];
//}
//
//- (void) writeThumbnailImage:(FLStorableImage*) image forStorageKey:(id) storageKey {
//    [self writeImage:image subType:FLImageTypeThumbnail forStorageKey:storageKey];
//}





@end
