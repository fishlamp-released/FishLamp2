//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioSearchPhotoByTextHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioSearchPhotoByTextHttpGetIn
// --------------------------------------------------------------------
@interface FLZenfolioSearchPhotoByTextHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _searchId;
	NSString* _sortOrder;
	NSString* _query;
	NSString* _offset;
	NSString* _limit;
} 


@property (readwrite, retain, nonatomic) NSString* limit;

@property (readwrite, retain, nonatomic) NSString* offset;

@property (readwrite, retain, nonatomic) NSString* query;

@property (readwrite, retain, nonatomic) NSString* searchId;

@property (readwrite, retain, nonatomic) NSString* sortOrder;

+ (NSString*) limitKey;

+ (NSString*) offsetKey;

+ (NSString*) queryKey;

+ (NSString*) searchIdKey;

+ (NSString*) sortOrderKey;

+ (FLZenfolioSearchPhotoByTextHttpGetIn*) searchPhotoByTextHttpGetIn; 

@end

@interface FLZenfolioSearchPhotoByTextHttpGetIn (ValueProperties) 
@end
