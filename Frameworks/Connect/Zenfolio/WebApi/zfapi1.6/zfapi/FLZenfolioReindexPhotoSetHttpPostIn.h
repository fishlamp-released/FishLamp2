//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioReindexPhotoSetHttpPostIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioReindexPhotoSetHttpPostIn
// --------------------------------------------------------------------
@interface FLZenfolioReindexPhotoSetHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _photoSetId;
	NSString* _startIndex;
	NSMutableArray* _mapping;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* mapping;
// Type: NSString*, forKey: String

@property (readwrite, retain, nonatomic) NSString* photoSetId;

@property (readwrite, retain, nonatomic) NSString* startIndex;

+ (NSString*) mappingKey;

+ (NSString*) photoSetIdKey;

+ (NSString*) startIndexKey;

+ (FLZenfolioReindexPhotoSetHttpPostIn*) reindexPhotoSetHttpPostIn; 

@end

@interface FLZenfolioReindexPhotoSetHttpPostIn (ValueProperties) 
@end

