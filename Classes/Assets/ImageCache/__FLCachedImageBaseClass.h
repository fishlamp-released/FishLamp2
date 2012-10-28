// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCachedImageBaseClass.h
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//



// --------------------------------------------------------------------
// FLCachedImageBaseClass
// --------------------------------------------------------------------
@interface FLCachedImageBaseClass : NSObject<NSCopying, NSCoding>{ 
@private
    NSString* __fileName;
    NSString* __url;
    NSString* __imageId;
    NSString* __photoUrl;
    NSString* __host;
    NSString* __imageVersion;
    NSNumber* __canCacheInMemory;
} 


@property (readwrite, strong, nonatomic) NSNumber* canCacheInMemory;

@property (readwrite, strong, nonatomic) NSString* fileName;

@property (readwrite, strong, nonatomic) NSString* host;

@property (readwrite, strong, nonatomic) NSString* imageId;

@property (readwrite, strong, nonatomic) NSString* imageVersion;

@property (readwrite, strong, nonatomic) NSString* photoUrl;

@property (readwrite, strong, nonatomic) NSString* url;

+ (NSString*) canCacheInMemoryKey;

+ (NSString*) fileNameKey;

+ (NSString*) hostKey;

+ (NSString*) imageIdKey;

+ (NSString*) imageVersionKey;

+ (NSString*) photoUrlKey;

+ (NSString*) urlKey;

+ (FLCachedImageBaseClass*) cachedImageBaseClass; 

@end

@interface FLCachedImageBaseClass (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL canCacheInMemoryValue;
@end

// [/Generated]
