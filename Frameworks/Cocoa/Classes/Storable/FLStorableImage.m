////
////  FLStorableImage.m
////  FishLamp
////
////  Created by Mike Fullerton on 11/26/12.
////  Copyright (c) 2012 Mike Fullerton. All rights reserved.
////
//
//#import "FLStorableImage.h"
//
//NSString* const FLImageTypeThumbnail =  @"com.fishlamp.image.thumbnail";
//NSString* const FLImageTypePreview =    @"com.fishlamp.image.preview";
//NSString* const FLImageTypeOriginal =   @"com.fishlamp.image.original";
//
//@interface FLStorableImage ()
//@property (readwrite, strong, nonatomic) SDKImage* image;
//@property (readwrite, strong, nonatomic) NSData* imageData;
//@property (readwrite, strong, nonatomic) NSURL* fileURL;
//@end
//
//@implementation FLStorableImage
//
//@synthesize image = _image;
//@synthesize imageData = _imageData;
//@synthesize exifDictionary = _exifDictionary;
//@synthesize imageProperties = _imageProperties;
//@synthesize storableSubType = _storableSubType;
//@synthesize fileURL = _fileURL;
//
//- (id) init {
//    return [self initWithImage:nil exifDictionary:nil imageData:nil];
//}
//
//- (id) initWithImage:(SDKImage*) image 
//      exifDictionary:(NSDictionary*) exifDictionary 
//           imageData:(NSData*) imageData  {
//    
//    self = [super init];
//    if(self) {
//		[self setImage:image exifDictionary:exifDictionary imageData:imageData ];
//    }
//    return self;
//}       
//
//
//- (id) initWithImageProperties:(FLImageProperties*) imageProperties 
//                       fileURL:(NSURL*) fileURL
//{
//    self = [self initWithImage:nil exifDictionary:nil imageData:nil];
//    if(self) {
//        self.imageProperties = imageProperties;
//        self.fileURL = fileURL;
//    }
//    
//    return self;
//}
//
//- (id) copyWithZone:(NSZone *)zone {
//    FLStorableImage* image = [[FLStorableImage alloc] initWithImageProperties:FLAutorelease([self.imageProperties copy])];
//    [image setImage:self.image exifDictionary:FLAutorelease([_exifDictionary copy]) imageData:_imageData];
//    image.storableSubType = self.storableSubType;
//    image.fileURL = self.fileURL;
//    return image;
//}
//
//
//+ (id) imageWithImageProperties:(FLImageProperties*) imageProperties 
//                        fileURL:(NSURL*) fileURL {
//    return FLAutorelease([[[self class] alloc] initWithImageProperties:imageProperties fileURL:fileURL]);
//}
//
//+ (id) image {
//    return FLAutorelease([[[self class] alloc] initWithImage:nil exifDictionary:nil imageData:nil ]);
//}
//
//+ (id) imageWithImage:(SDKImage*) image 
//             exifDictionary:(NSDictionary*)exifDictionary
//            imageData:(NSData*) imageData {
//    return FLAutorelease([[[self class] alloc] initWithImage:image exifDictionary:exifDictionary imageData:imageData]);
//}            
//
//#if FL_MRC
//- (void) dealloc { 
//    [_fileURL release];
//    [_imageProperties release];
//    [_image release];
//    [_imageData release];
//    [_exifDictionary release];
//    [_storableSubType release];
//    [super dealloc];
//}
//#endif
//
//- (NSString*) fileName {
//    FLAssertNotNil(_imageProperties);
//    return _imageProperties.fileName;
//}
//
//- (id) storageKey {
//    return self.fileName;
//}
//
//- (NSString*) storableType {
//
//    NSString* extension = [self.fileName pathExtension];
//    FLConfirmStringIsNotEmptyWithComment(extension, @"failed to get file extension for %@", self.fileName);
//    
//    NSString* UTI = FLAutorelease(bridge_transfer_(NSString*, UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension,  bridge_(CFStringRef, extension), NULL)));
//
//    FLConfirmNotNilWithComment(UTI, @"failed to get UTI for extension for file %@", self.fileName);
//
//    return UTI;
//}
//
//- (void) setImage:(SDKImage*) image 
//   exifDictionary:(NSDictionary*) exifDictionary 
//        imageData:(NSData*) imageData {
//    
//    self.image = image;
//    self.imageData = imageData;
//    self.exifDictionary = exifDictionary;
////    _dimensions = _image ? _image.size : CGSizeZero;
//}       
//
//- (void) releaseAllImageData {
//    [self setImage:nil exifDictionary:nil imageData:nil];
//}
//
////- (void) clear {
////    [self setImage:nil imageData:nil exifDictionary:nil];
////}
//
//
////- (void) setImageData:(NSData*) data {
////    [self setImage:nil imageData:data exifDictionary:nil];
////}
//
//- (void) copySelfTo:(FLStorableImage*) image {
//    [super copySelfTo:image];
//    [image setImage:self.image exifDictionary:self.exifDictionary imageData:self.imageData];
//    image.imageProperties = self.imageProperties;
//    image.fileURL = self.fileURL;
//}
//
//@end
//
//@implementation FLStorableImage (ExtendedConstruction)
//
//- (id) initWithImage:(SDKImage*) image 
//            exifDictionary:(NSDictionary*) exifDictionary {
//	
//    return [self initWithImage:image exifDictionary:exifDictionary imageData:nil];
//}
//
//- (id) initWithImage:(SDKImage*) image {
//    return [self initWithImage:image exifDictionary:nil imageData:nil];
//}
//
//- (id) initWithData:(NSData*) data {
//    return [self initWithImage:nil exifDictionary:nil imageData:data];
//}
//
//+ (id) imageWithData:(NSData*) imageData {
//    return FLAutorelease([[[self class] alloc] initWithData:imageData]);
//}
//
//+ (id) imageWithImage:(SDKImage*) image exifDictionary:(NSDictionary*) exifDictionary{
//    return FLAutorelease([[[self class] alloc] initWithImage:image exifDictionary:exifDictionary]);
//}
//
//+ (id) imageWithImageProperties:(FLImageProperties*) imageProperties {
//    return FLAutorelease([[[self class] alloc] initWithImageProperties:imageProperties fileURL:nil]);
//}
//
//- (id) initWithImageProperties:(FLImageProperties*) imageProperties {
//    return [self initWithImageProperties:imageProperties fileURL:nil];
//}
//
//@end
//
//
//
//
////- (void) setImage:(SDKImage*) image {
////    [self setImage:image imageData:nil exifDictionary:nil];
////}
////
////- (void) setImage:(SDKImage*) image exifDictionary:(NSDictionary*) exif {
////    [self setImage:image imageData:nil exifDictionary:exif];
////}
//
