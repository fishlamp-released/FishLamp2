// [Generated]
//
// This file was generated at 6/18/12 2:02 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLQueuedAsset.h
// Project: FishLamp Mobile
// Schema: AssetQueueObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//


@class FLAsset;

// --------------------------------------------------------------------
// FLQueuedAsset
// --------------------------------------------------------------------
@interface FLQueuedAsset : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __queueUID;
    NSString* __assetUID;
    NSString* __assetURL;
    NSNumber* __assetType;
    NSNumber* __positionInQueue;
    NSNumber* __assetState;
    NSDate* __queuedDate;
    NSDate* __createdDate;
    NSDate* __modifiedDate;
    NSString* __uploadedAssetURL;
    NSNumber* __uploadedAssetId;
    NSNumber* __uploadDestinationId;
    NSString* __uploadDestinationName;
    NSString* __uploadDestinationURL;
    NSNumber* __assetSize;
    NSString* __assetName;
    NSString* __assetDescription;
    NSString* __assetFileName;
    NSString* __copyright;
    NSMutableArray* __keywords;
    FLAsset* __assetObject;
} 


@property (readwrite, strong, nonatomic) NSString* assetDescription;

@property (readwrite, strong, nonatomic) NSString* assetFileName;

@property (readwrite, strong, nonatomic) NSString* assetName;

@property (readwrite, strong, nonatomic) FLAsset* assetObject;

@property (readwrite, strong, nonatomic) NSNumber* assetSize;

@property (readwrite, strong, nonatomic) NSNumber* assetState;

@property (readwrite, strong, nonatomic) NSNumber* assetType;

@property (readwrite, strong, nonatomic) NSString* assetUID;

@property (readwrite, strong, nonatomic) NSString* assetURL;

@property (readwrite, strong, nonatomic) NSString* copyright;

@property (readwrite, strong, nonatomic) NSDate* createdDate;

@property (readwrite, strong, nonatomic) NSMutableArray* keywords;

@property (readwrite, strong, nonatomic) NSDate* modifiedDate;

@property (readwrite, strong, nonatomic) NSNumber* positionInQueue;

@property (readwrite, strong, nonatomic) NSString* queueUID;

@property (readwrite, strong, nonatomic) NSDate* queuedDate;

@property (readwrite, strong, nonatomic) NSNumber* uploadDestinationId;

@property (readwrite, strong, nonatomic) NSString* uploadDestinationName;

@property (readwrite, strong, nonatomic) NSString* uploadDestinationURL;

@property (readwrite, strong, nonatomic) NSNumber* uploadedAssetId;

@property (readwrite, strong, nonatomic) NSString* uploadedAssetURL;

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

+ (FLQueuedAsset*) queuedAsset; 

@end

@interface FLQueuedAsset (ValueProperties) 

@property (readwrite, assign, nonatomic) int assetTypeValue;

@property (readwrite, assign, nonatomic) int positionInQueueValue;

@property (readwrite, assign, nonatomic) int assetStateValue;

@property (readwrite, assign, nonatomic) long uploadedAssetIdValue;

@property (readwrite, assign, nonatomic) long uploadDestinationIdValue;

@property (readwrite, assign, nonatomic) long assetSizeValue;
@end

// [/Generated]
