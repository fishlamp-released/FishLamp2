//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioReindexPhotoSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioReindexPhotoSet
// --------------------------------------------------------------------
@interface FLZenfolioReindexPhotoSet : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _photoSetId;
	NSNumber* _startIndex;
	NSMutableArray* _mapping;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* mapping;
// Type: NSNumber*, forKey: int

@property (readwrite, retain, nonatomic) NSNumber* photoSetId;

@property (readwrite, retain, nonatomic) NSNumber* startIndex;

+ (NSString*) mappingKey;

+ (NSString*) photoSetIdKey;

+ (NSString*) startIndexKey;

+ (FLZenfolioReindexPhotoSet*) reindexPhotoSet; 

@end

@interface FLZenfolioReindexPhotoSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int photoSetIdValue;

@property (readwrite, assign, nonatomic) int startIndexValue;
@end

