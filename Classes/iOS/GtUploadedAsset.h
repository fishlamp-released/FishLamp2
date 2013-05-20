//	This file was generated at 7/6/11 7:13 PM by PackMule. DO NOT MODIFY!!
//
//	GtUploadedAsset.h
//	Project: FishLamp Mobile
//	Schema: MobilePhotoObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtUploadedAsset
// --------------------------------------------------------------------
@interface GtUploadedAsset : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_queueUID;
	NSNumber* m_uploadedAssetUID;
	NSNumber* m_assetType;
	NSString* m_assetURL;
	NSString* m_assetUID;
	NSString* m_uploadedAssetURL;
	NSNumber* m_uploadedAssetId;
	NSNumber* m_uploadDestinationId;
	NSString* m_uploadDestinationName;
	NSString* m_uploadDestinationURL;
	NSString* m_assetName;
	UIImage* m_thumbnail;
	NSDate* m_uploadedDate;
} 


@property (readwrite, retain, nonatomic) NSString* assetName;

@property (readwrite, retain, nonatomic) NSNumber* assetType;

@property (readwrite, retain, nonatomic) NSString* assetUID;

@property (readwrite, retain, nonatomic) NSString* assetURL;

@property (readwrite, retain, nonatomic) NSString* queueUID;

@property (readwrite, retain, nonatomic) UIImage* thumbnail;

@property (readwrite, retain, nonatomic) NSNumber* uploadDestinationId;

@property (readwrite, retain, nonatomic) NSString* uploadDestinationName;

@property (readwrite, retain, nonatomic) NSString* uploadDestinationURL;

@property (readwrite, retain, nonatomic) NSNumber* uploadedAssetId;

@property (readwrite, retain, nonatomic) NSNumber* uploadedAssetUID;

@property (readwrite, retain, nonatomic) NSString* uploadedAssetURL;

@property (readwrite, retain, nonatomic) NSDate* uploadedDate;

+ (NSString*) assetNameKey;

+ (NSString*) assetTypeKey;

+ (NSString*) assetUIDKey;

+ (NSString*) assetURLKey;

+ (NSString*) queueUIDKey;

+ (NSString*) thumbnailKey;

+ (NSString*) uploadDestinationIdKey;

+ (NSString*) uploadDestinationNameKey;

+ (NSString*) uploadDestinationURLKey;

+ (NSString*) uploadedAssetIdKey;

+ (NSString*) uploadedAssetUIDKey;

+ (NSString*) uploadedAssetURLKey;

+ (NSString*) uploadedDateKey;

+ (GtUploadedAsset*) uploadedAsset; 

@end

@interface GtUploadedAsset (ValueProperties) 

@property (readwrite, assign, nonatomic) int uploadedAssetUIDValue;

@property (readwrite, assign, nonatomic) int assetTypeValue;

@property (readwrite, assign, nonatomic) long uploadedAssetIdValue;

@property (readwrite, assign, nonatomic) long uploadDestinationIdValue;
@end

