//	This file was generated at 7/3/11 1:04 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUploadGallery.h
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


#import "FLDatabaseObject.h"

// --------------------------------------------------------------------
// FLZenfolioUploadGallery
// --------------------------------------------------------------------
@interface FLZenfolioUploadGallery : FLDatabaseObject<NSCopying, NSCoding>{ 
@private
	NSString* _name;
	NSNumber* _photoSetId;
	NSString* _uploadUrl;
} 


@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

@property (readwrite, retain, nonatomic) NSString* uploadUrl;

+ (NSString*) nameKey;

+ (NSString*) photoSetIdKey;

+ (NSString*) uploadUrlKey;

+ (FLZenfolioUploadGallery*) uploadGallery; 

@end

@interface FLZenfolioUploadGallery (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;
@end

