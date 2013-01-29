//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSearchSetByCategoryHttpPostIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFSearchSetByCategoryHttpPostIn
// --------------------------------------------------------------------
@interface ZFSearchSetByCategoryHttpPostIn : NSObject<NSCoding, NSCopying>{ 
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

+ (ZFSearchSetByCategoryHttpPostIn*) searchSetByCategoryHttpPostIn; 

@end

@interface ZFSearchSetByCategoryHttpPostIn (ValueProperties) 
@end

