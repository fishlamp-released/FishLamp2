//	This file was generated at 10/11/11 11:00 AM by PackMule. DO NOT MODIFY!!
//
//	GtQueuedAsset.h
//	Project: FishLamp Mobile
//	Schema: MobilePhotoObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


@class GtAsset;

// --------------------------------------------------------------------
// GtQueuedAsset
// --------------------------------------------------------------------
@interface GtQueuedAsset : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_queueUID;
	NSString* m_assetUID;
	NSString* m_assetURL;
	NSNumber* m_assetType;
	NSNumber* m_positionInQueue;
	NSNumber* m_assetState;
	NSDate* m_queuedDate;
	NSDate* m_createdDate;
	NSDate* m_modifiedDate;
	NSString* m_uploadedAssetURL;
	NSNumber* m_uploadedAssetId;
	NSNumber* m_uploadDestinationId;
	NSString* m_uploadDestinationName;
	NSString* m_uploadDestinationURL;
	NSNumber* m_assetSize;
	NSString* m_assetName;
	NSString* m_assetDescription;
	NSString* m_assetFileName;
	NSString* m_copyright;
	NSMutableArray* m_keywords;
	GtAsset* m_assetObject;
} 


@property (readwrite, retain, nonatomic) NSString* assetDescription;

@property (readwrite, retain, nonatomic) NSString* assetFileName;

@property (readwrite, retain, nonatomic) NSString* assetName;

@property (readwrite, retain, nonatomic) GtAsset* assetObject;

@property (readwrite, retain, nonatomic) NSNumber* assetSize;

@property (readwrite, retain, nonatomic) NSNumber* assetState;

@property (readwrite, retain, nonatomic) NSNumber* assetType;

@property (readwrite, retain, nonatomic) NSString* assetUID;

@property (readwrite, retain, nonatomic) NSString* assetURL;

@property (readwrite, retain, nonatomic) NSString* copyright;

@property (readwrite, retain, nonatomic) NSDate* createdDate;

@property (readwrite, retain, nonatomic) NSMutableArray* keywords;

@property (readwrite, retain, nonatomic) NSDate* modifiedDate;

@property (readwrite, retain, nonatomic) NSNumber* positionInQueue;

@property (readwrite, retain, nonatomic) NSString* queueUID;

@property (readwrite, retain, nonatomic) NSDate* queuedDate;

@property (readwrite, retain, nonatomic) NSNumber* uploadDestinationId;

@property (readwrite, retain, nonatomic) NSString* uploadDestinationName;

@property (readwrite, retain, nonatomic) NSString* uploadDestinationURL;

@property (readwrite, retain, nonatomic) NSNumber* uploadedAssetId;

@property (readwrite, retain, nonatomic) NSString* uploadedAssetURL;

+ (NSString*) assetDescriptionKey;

+ (NSString*) assetFileNameKey;

+ (NSString*) assetNameKey;

+ (NSString*) assetObjectKey;

+ (NSString*) assetSizeKey;

+ (NSString*) assetStateKey;

+ (NSString*) assetTypeKey;

+ (NSString*) assetUIDKey;

+ (NSString*) assetURLKey;

+ (NSString*) copyrightKey;

+ (NSString*) createdDateKey;

+ (NSString*) keywordsKey;

+ (NSString*) modifiedDateKey;

+ (NSString*) positionInQueueKey;

+ (NSString*) queueUIDKey;

+ (NSString*) queuedDateKey;

+ (NSString*) uploadDestinationIdKey;

+ (NSString*) uploadDestinationNameKey;

+ (NSString*) uploadDestinationURLKey;

+ (NSString*) uploadedAssetIdKey;

+ (NSString*) uploadedAssetURLKey;

+ (GtQueuedAsset*) queuedAsset; 

@end

@interface GtQueuedAsset (ValueProperties) 

@property (readwrite, assign, nonatomic) int assetTypeValue;

@property (readwrite, assign, nonatomic) int positionInQueueValue;

@property (readwrite, assign, nonatomic) int assetStateValue;

@property (readwrite, assign, nonatomic) long uploadedAssetIdValue;

@property (readwrite, assign, nonatomic) long uploadDestinationIdValue;

@property (readwrite, assign, nonatomic) long assetSizeValue;
@end

