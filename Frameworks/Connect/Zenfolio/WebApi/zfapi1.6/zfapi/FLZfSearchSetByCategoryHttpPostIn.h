//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfSearchSetByCategoryHttpPostIn.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfSearchSetByCategoryHttpPostIn
// --------------------------------------------------------------------
@interface FLZfSearchSetByCategoryHttpPostIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _searchId;
	NSString* _type;
	NSString* _sortOrder;
	NSString* _categoryCode;
	NSString* _offset;
	NSString* _limit;
} 


@property (readwrite, retain, nonatomic) NSString* categoryCode;

@property (readwrite, retain, nonatomic) NSString* limit;

@property (readwrite, retain, nonatomic) NSString* offset;

@property (readwrite, retain, nonatomic) NSString* searchId;

@property (readwrite, retain, nonatomic) NSString* sortOrder;

@property (readwrite, retain, nonatomic) NSString* type;

+ (NSString*) categoryCodeKey;

+ (NSString*) limitKey;

+ (NSString*) offsetKey;

+ (NSString*) searchIdKey;

+ (NSString*) sortOrderKey;

+ (NSString*) typeKey;

+ (FLZfSearchSetByCategoryHttpPostIn*) searchSetByCategoryHttpPostIn; 

@end

@interface FLZfSearchSetByCategoryHttpPostIn (ValueProperties) 
@end

