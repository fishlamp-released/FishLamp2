//	This file was generated at 7/3/11 10:47 AM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioSyncState.h
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLZenfolioSyncState
// --------------------------------------------------------------------
@interface FLZenfolioSyncState : NSObject<NSCopying, NSCoding>{ 
@private
	NSDate* _lastSyncDate;
	NSNumber* _isSynced;
	NSNumber* _syncObjectId;
} 


@property (readwrite, retain, nonatomic) NSNumber* isSynced;

@property (readwrite, retain, nonatomic) NSDate* lastSyncDate;

@property (readwrite, retain, nonatomic) NSNumber* syncObjectId;

+ (NSString*) isSyncedKey;

+ (NSString*) lastSyncDateKey;

+ (NSString*) syncObjectIdKey;

+ (FLZenfolioSyncState*) syncState; 

@end

@interface FLZenfolioSyncState (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL isSyncedValue;

@property (readwrite, assign, nonatomic) NSInteger syncObjectIdValue;
@end

