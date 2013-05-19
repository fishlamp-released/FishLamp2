// [Generated]
//
// This file was generated at 6/18/12 2:02 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLAssetQueueState.h
// Project: FishLamp Mobile
// Schema: AssetQueueObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// FLAssetQueueState
// --------------------------------------------------------------------
@interface FLAssetQueueState : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __queueUID;
    NSNumber* __sortOrder;
    NSNumber* __totalAssetsAdded;
    NSNumber* __firstQueuePosition;
    NSNumber* __lastQueuePosition;
} 


@property (readwrite, strong, nonatomic) NSNumber* firstQueuePosition;

@property (readwrite, strong, nonatomic) NSNumber* lastQueuePosition;

@property (readwrite, strong, nonatomic) NSString* queueUID;

@property (readwrite, strong, nonatomic) NSNumber* sortOrder;

@property (readwrite, strong, nonatomic) NSNumber* totalAssetsAdded;

+ (NSString*) firstQueuePositionKey;

+ (NSString*) lastQueuePositionKey;

+ (NSString*) queueUIDKey;

+ (NSString*) sortOrderKey;

+ (NSString*) totalAssetsAddedKey;

+ (FLAssetQueueState*) assetQueueState; 

@end

@interface FLAssetQueueState (ValueProperties) 

@property (readwrite, assign, nonatomic) int sortOrderValue;

@property (readwrite, assign, nonatomic) long totalAssetsAddedValue;

@property (readwrite, assign, nonatomic) int firstQueuePositionValue;

@property (readwrite, assign, nonatomic) int lastQueuePositionValue;
@end

// [/Generated]
