//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioSearchPhotoByText.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


#import "FLZenfolioApi1_6Enums.h"

// --------------------------------------------------------------------
// FLZenfolioSearchPhotoByText
// --------------------------------------------------------------------
@interface FLZenfolioSearchPhotoByText : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _searchId;
	NSString* _sortOrder;
	NSString* _query;
	NSNumber* _offset;
	NSNumber* _limit;
} 


@property (readwrite, retain, nonatomic) NSNumber* limit;

@property (readwrite, retain, nonatomic) NSNumber* offset;

@property (readwrite, retain, nonatomic) NSString* query;

@property (readwrite, retain, nonatomic) NSString* searchId;

@property (readwrite, retain, nonatomic) NSString* sortOrder;

+ (NSString*) limitKey;

+ (NSString*) offsetKey;

+ (NSString*) queryKey;

+ (NSString*) searchIdKey;

+ (NSString*) sortOrderKey;

+ (FLZenfolioSearchPhotoByText*) searchPhotoByText; 

@end

@interface FLZenfolioSearchPhotoByText (ValueProperties) 

@property (readwrite, assign, nonatomic) FLZenfolioSortOrder sortOrderValue;

@property (readwrite, assign, nonatomic) int offsetValue;

@property (readwrite, assign, nonatomic) int limitValue;
@end
