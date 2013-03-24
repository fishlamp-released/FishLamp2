//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSearchPhotoByCategoryHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFSearchPhotoByCategoryHttpGetIn
// --------------------------------------------------------------------
@interface ZFSearchPhotoByCategoryHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _searchId;
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

+ (NSString*) categoryCodeKey;

+ (NSString*) limitKey;

+ (NSString*) offsetKey;

+ (NSString*) searchIdKey;

+ (NSString*) sortOrderKey;

+ (ZFSearchPhotoByCategoryHttpGetIn*) searchPhotoByCategoryHttpGetIn; 

@end

@interface ZFSearchPhotoByCategoryHttpGetIn (ValueProperties) 
@end

