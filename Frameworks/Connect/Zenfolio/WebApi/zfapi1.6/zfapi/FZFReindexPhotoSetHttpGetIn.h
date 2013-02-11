//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioReindexPhotoSetHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioReindexPhotoSetHttpGetIn
// --------------------------------------------------------------------
@interface FLZenfolioReindexPhotoSetHttpGetIn : NSObject<NSCoding, NSCopying>{ 
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

+ (FLZenfolioReindexPhotoSetHttpGetIn*) reindexPhotoSetHttpGetIn; 

@end

@interface FLZenfolioReindexPhotoSetHttpGetIn (ValueProperties) 
@end

