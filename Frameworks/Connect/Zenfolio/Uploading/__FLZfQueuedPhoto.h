//	This file was generated at 3/13/12 6:26 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfQueuedPhoto.h
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "FLQueuedAsset.h"
@class FLZfAccessDescriptor;

// --------------------------------------------------------------------
// FLZfQueuedPhoto
// --------------------------------------------------------------------
@interface FLZfQueuedPhoto : FLQueuedAsset<NSCopying, NSCoding>{ 
@private
	FLZfAccessDescriptor* _accessDescriptor;
	NSMutableArray* _categoryArray;
	NSMutableArray* _zenfolioCategories;
	NSNumber* _scaledUploadSize;
	NSNumber* _saveToDeviceBeforeUpload;
	NSNumber* _wasSavedToDeviceBeforeUpload;
} 


@property (readwrite, retain, nonatomic) FLZfAccessDescriptor* accessDescriptor;

@property (readwrite, retain, nonatomic) NSMutableArray* categoryArray;

@property (readwrite, retain, nonatomic) NSNumber* saveToDeviceBeforeUpload;

@property (readwrite, retain, nonatomic) NSNumber* scaledUploadSize;

@property (readwrite, retain, nonatomic) NSNumber* wasSavedToDeviceBeforeUpload;

@property (readwrite, retain, nonatomic) NSMutableArray* zenfolioCategories;

+ (NSString*) accessDescriptorKey;

+ (NSString*) categoryArrayKey;

+ (NSString*) saveToDeviceBeforeUploadKey;

+ (NSString*) scaledUploadSizeKey;

+ (NSString*) wasSavedToDeviceBeforeUploadKey;

+ (NSString*) zenfolioCategoriesKey;

+ (FLZfQueuedPhoto*) queuedPhoto; 

@end

@interface FLZfQueuedPhoto (ValueProperties) 

@property (readwrite, assign, nonatomic) int scaledUploadSizeValue;

@property (readwrite, assign, nonatomic) BOOL saveToDeviceBeforeUploadValue;

@property (readwrite, assign, nonatomic) BOOL wasSavedToDeviceBeforeUploadValue;
@end

