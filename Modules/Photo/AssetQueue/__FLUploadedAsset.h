// [Generated]
//
// This file was generated at 6/18/12 2:02 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLUploadedAsset.h
// Project: FishLamp Mobile
// Schema: AssetQueueObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLUploadedAsset
// --------------------------------------------------------------------
@interface FLUploadedAsset : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __queueUID;
    NSNumber* __uploadedAssetUID;
    NSNumber* __assetType;
    NSString* __assetURL;
    NSString* __assetUID;
    NSString* __uploadedAssetURL;
    NSNumber* __uploadedAssetId;
    NSNumber* __uploadDestinationId;
    NSString* __uploadDestinationName;
    NSString* __uploadDestinationURL;
    NSString* __assetName;
    UIImage* __thumbnail;
    NSDate* __uploadedDate;
} 


@property (readwrite, strong, nonatomic) NSString* assetName;

@property (readwrite, strong, nonatomic) NSNumber* assetType;

@property (readwrite, strong, nonatomic) NSString* assetUID;

@property (readwrite, strong, nonatomic) NSString* assetURL;

@property (readwrite, strong, nonatomic) NSString* queueUID;

@property (readwrite, strong, nonatomic) UIImage* thumbnail;

@property (readwrite, strong, nonatomic) NSNumber* uploadDestinationId;

@property (readwrite, strong, nonatomic) NSString* uploadDestinationName;

@property (readwrite, strong, nonatomic) NSString* uploadDestinationURL;

@property (readwrite, strong, nonatomic) NSNumber* uploadedAssetId;

@property (readwrite, strong, nonatomic) NSNumber* uploadedAssetUID;

@property (readwrite, strong, nonatomic) NSString* uploadedAssetURL;

@property (readwrite, strong, nonatomic) NSDate* uploadedDate;

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

+ (FLUploadedAsset*) uploadedAsset; 

@end

@interface FLUploadedAsset (ValueProperties) 

@property (readwrite, assign, nonatomic) int uploadedAssetUIDValue;

@property (readwrite, assign, nonatomic) int assetTypeValue;

@property (readwrite, assign, nonatomic) long uploadedAssetIdValue;

@property (readwrite, assign, nonatomic) long uploadDestinationIdValue;
@end

// [/Generated]
