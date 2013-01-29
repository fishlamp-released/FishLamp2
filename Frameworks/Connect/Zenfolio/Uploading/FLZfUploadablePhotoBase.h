//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfUploadablePhotoBase.h
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "FLZfPhotoUpdater.h"
@class FLZfUploadGallery;
@class FLZfAccessDescriptor;

// --------------------------------------------------------------------
// FLZfUploadablePhotoBase
// --------------------------------------------------------------------
@interface FLZfUploadablePhotoBase : FLZfPhotoUpdater<NSCopying, NSCoding>{ 
@private
	NSString* _photoDataFileName;
	NSNumber* _uploadFileId;
	NSNumber* _sortId;
	FLZfUploadGallery* _uploadGallery;
	NSNumber* _uploadSize;
	FLZfAccessDescriptor* _accessDescriptor;
	NSNumber* _saveToPhoneGalleryOnUpload;
	NSNumber* _wasSavedToPhotoGallery;
	NSNumber* _isCameraImage;
	NSString* _loginName;
	NSString* _originalFileName;
	NSMutableArray* _categoryArray;
	NSNumber* _uploadedPhotoId;
	NSValue* _dimensions;
	NSNumber* _uploaded;
	NSDate* _takenDate;
	NSDate* _modifiedDate;
} 


@property (readwrite, retain, nonatomic) FLZfAccessDescriptor* accessDescriptor;

@property (readwrite, retain, nonatomic) NSMutableArray* categoryArray;

@property (readwrite, retain, nonatomic) NSValue* dimensions;

@property (readwrite, retain, nonatomic) NSNumber* isCameraImage;

@property (readwrite, retain, nonatomic) NSString* loginName;

@property (readwrite, retain, nonatomic) NSDate* modifiedDate;

@property (readwrite, retain, nonatomic) NSString* originalFileName;

@property (readwrite, retain, nonatomic) NSString* photoDataFileName;

@property (readwrite, retain, nonatomic) NSNumber* saveToPhoneGalleryOnUpload;

@property (readwrite, retain, nonatomic) NSNumber* sortId;

@property (readwrite, retain, nonatomic) NSDate* takenDate;

@property (readwrite, retain, nonatomic) NSNumber* uploadFileId;

@property (readwrite, retain, nonatomic) FLZfUploadGallery* uploadGallery;

@property (readwrite, retain, nonatomic) NSNumber* uploadSize;

@property (readwrite, retain, nonatomic) NSNumber* uploaded;

@property (readwrite, retain, nonatomic) NSNumber* uploadedPhotoId;

@property (readwrite, retain, nonatomic) NSNumber* wasSavedToPhotoGallery;

+ (NSString*) accessDescriptorKey;

+ (NSString*) categoryArrayKey;

+ (NSString*) dimensionsKey;

+ (NSString*) isCameraImageKey;

+ (NSString*) loginNameKey;

+ (NSString*) modifiedDateKey;

+ (NSString*) originalFileNameKey;

+ (NSString*) photoDataFileNameKey;

+ (NSString*) saveToPhoneGalleryOnUploadKey;

+ (NSString*) sortIdKey;

+ (NSString*) takenDateKey;

+ (NSString*) uploadFileIdKey;

+ (NSString*) uploadGalleryKey;

+ (NSString*) uploadSizeKey;

+ (NSString*) uploadedKey;

+ (NSString*) uploadedPhotoIdKey;

+ (NSString*) wasSavedToPhotoGalleryKey;

+ (FLZfUploadablePhotoBase*) uploadablePhotoBase; 

@end

@interface FLZfUploadablePhotoBase (ValueProperties) 

@property (readwrite, assign, nonatomic) int uploadFileIdValue;

@property (readwrite, assign, nonatomic) int sortIdValue;

@property (readwrite, assign, nonatomic) NSInteger uploadSizeValue;

@property (readwrite, assign, nonatomic) BOOL saveToPhoneGalleryOnUploadValue;

@property (readwrite, assign, nonatomic) BOOL wasSavedToPhotoGalleryValue;

@property (readwrite, assign, nonatomic) BOOL isCameraImageValue;

@property (readwrite, assign, nonatomic) unsigned long uploadedPhotoIdValue;

@property (readwrite, assign, nonatomic) CGSize dimensionsValue;

@property (readwrite, assign, nonatomic) BOOL uploadedValue;
@end

