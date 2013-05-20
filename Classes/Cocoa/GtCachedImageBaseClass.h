//	This file was generated at 7/3/11 10:38 AM by PackMule. DO NOT MODIFY!!
//
//	GtCachedImageBaseClass.h
//	Project: FishLamp
//	Schema: GtGeneratedCoreObjects
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//



// --------------------------------------------------------------------
// GtCachedImageBaseClass
// --------------------------------------------------------------------
@interface GtCachedImageBaseClass : NSObject<NSCopying, NSCoding>{ 
@private
	NSString* m_fileName;
	NSString* m_url;
	NSString* m_imageId;
	NSString* m_photoUrl;
	NSString* m_host;
	NSString* m_imageVersion;
	NSNumber* m_canCacheInMemory;
} 


@property (readwrite, retain, nonatomic) NSNumber* canCacheInMemory;

@property (readwrite, retain, nonatomic) NSString* fileName;

@property (readwrite, retain, nonatomic) NSString* host;

@property (readwrite, retain, nonatomic) NSString* imageId;

@property (readwrite, retain, nonatomic) NSString* imageVersion;

@property (readwrite, retain, nonatomic) NSString* photoUrl;

@property (readwrite, retain, nonatomic) NSString* url;

+ (NSString*) canCacheInMemoryKey;

+ (NSString*) fileNameKey;

+ (NSString*) hostKey;

+ (NSString*) imageIdKey;

+ (NSString*) imageVersionKey;

+ (NSString*) photoUrlKey;

+ (NSString*) urlKey;

+ (GtCachedImageBaseClass*) cachedImageBaseClass; 

@end

@interface GtCachedImageBaseClass (ValueProperties) 

@property (readwrite, assign, nonatomic) BOOL canCacheInMemoryValue;
@end

