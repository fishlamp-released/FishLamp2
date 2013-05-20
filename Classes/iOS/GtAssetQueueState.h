//	This file was generated at 7/3/11 12:00 PM by PackMule. DO NOT MODIFY!!
//
//	GtAssetQueueState.h
//	Project: FishLamp Mobile
//	Schema: MobilePhotoObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtAssetQueueState
// --------------------------------------------------------------------
@interface GtAssetQueueState : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_queueUID;
	NSNumber* m_sortOrder;
	NSNumber* m_totalAssetsAdded;
	NSNumber* m_firstQueuePosition;
	NSNumber* m_lastQueuePosition;
} 


@property (readwrite, retain, nonatomic) NSNumber* firstQueuePosition;

@property (readwrite, retain, nonatomic) NSNumber* lastQueuePosition;

@property (readwrite, retain, nonatomic) NSString* queueUID;

@property (readwrite, retain, nonatomic) NSNumber* sortOrder;

@property (readwrite, retain, nonatomic) NSNumber* totalAssetsAdded;

+ (NSString*) firstQueuePositionKey;

+ (NSString*) lastQueuePositionKey;

+ (NSString*) queueUIDKey;

+ (NSString*) sortOrderKey;

+ (NSString*) totalAssetsAddedKey;

+ (GtAssetQueueState*) assetQueueState; 

@end

@interface GtAssetQueueState (ValueProperties) 

@property (readwrite, assign, nonatomic) int sortOrderValue;

@property (readwrite, assign, nonatomic) long totalAssetsAddedValue;

@property (readwrite, assign, nonatomic) int firstQueuePositionValue;

@property (readwrite, assign, nonatomic) int lastQueuePositionValue;
@end

