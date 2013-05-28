//
//  SDKImage.h
//  FishLamp
//
//  Created by Mike Fullerton on 11/26/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

//#import "FLCocoaRequired.h"
//
//#import "FLStorable.h"
//#import "FLImageProperties.h"
//
//@protocol FLImageStorage;
//
//extern NSString* const FLImageTypeThumbnail;
//extern NSString* const FLImageTypePreview;
//extern NSString* const FLImageTypeOriginal;
//
//@interface FLStorableImage : NSObject<FLStorable> {
//@private
//	SDKImage* _image;
//	NSData* _imageData;
//	NSDictionary* _exifDictionary;
//    FLImageProperties* _imageProperties;
//    NSString* _storableSubType;
//    NSURL* _fileURL;
//}
//
//@property (readonly, strong, nonatomic) NSString* fileName;
//@property (readonly, strong, nonatomic) NSURL* fileURL;
//
//@property (readwrite, strong) FLImageProperties* imageProperties;
//
//@property (readonly, strong, nonatomic) SDKImage* image;
//@property (readonly, strong, nonatomic) NSData* imageData;
//@property (readwrite, strong, nonatomic) NSDictionary* exifDictionary;
//
//- (id) initWithImageProperties:(FLImageProperties*) imageProperties 
//                       fileURL:(NSURL*) fileURL;
//
//- (id) initWithImage:(SDKImage*) imageOrNil
//      exifDictionary:(NSDictionary*) exifDictionaryOrNil 
//           imageData:(NSData*) imageDataOrNil;
//
//+ (id) image;
//
//+ (id) imageWithImage:(SDKImage*) image 
//       exifDictionary:(NSDictionary*) exifDictionary
//            imageData:(NSData*) imageData;
//
//+ (id) imageWithImageProperties:(FLImageProperties*) imageProperties 
//                        fileURL:(NSURL*) fileURL;
//
//- (void) setImage:(SDKImage*) image 
//   exifDictionary:(NSDictionary*) exifDictionary
//        imageData:(NSData*) imageData;
//
//- (void) releaseAllImageData;
//
//@end
//
//@interface FLStorableImage (ExtendedConstruction)
//
//- (id) initWithImage:(SDKImage*) image;
//- (id) initWithData:(NSData*) data;
//+ (id) imageWithData:(NSData*) imageData;
//+ (id) imageWithImage:(SDKImage*) image exifDictionary:(NSDictionary*) exifDictionary;
//+ (id) imageWithImageProperties:(FLImageProperties*) imageProperties;
//- (id) initWithImageProperties:(FLImageProperties*) imageProperties;
//
//@end
