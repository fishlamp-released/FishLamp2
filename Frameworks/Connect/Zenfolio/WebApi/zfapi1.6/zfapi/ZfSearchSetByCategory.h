//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSearchSetByCategory.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


#import "ZFApi1_6Enums.h"
#import "ZFApi1_6Enums.h"

// --------------------------------------------------------------------
// ZFSearchSetByCategory
// --------------------------------------------------------------------
@interface ZFSearchSetByCategory : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _searchId;
	NSString* _type;
	NSString* _sortOrder;
	NSNumber* _categoryCode;
	NSNumber* _offset;
	NSNumber* _limit;
} 


@property (readwrite, retain, nonatomic) NSNumber* categoryCode;

@property (readwrite, retain, nonatomic) NSNumber* limit;

@property (readwrite, retain, nonatomic) NSNumber* offset;

@property (readwrite, retain, nonatomic) NSString* searchId;

@property (readwrite, retain, nonatomic) NSString* sortOrder;

@property (readwrite, retain, nonatomic) NSString* type;

+ (NSString*) categoryCodeKey;

+ (NSString*) limitKey;

+ (NSString*) offsetKey;

+ (NSString*) searchIdKey;

+ (NSString*) sortOrderKey;

+ (NSString*) typeKey;

+ (ZFSearchSetByCategory*) searchSetByCategory; 

@end

@interface ZFSearchSetByCategory (ValueProperties) 

@property (readwrite, assign, nonatomic) ZFPhotoSetType typeValue;

@property (readwrite, assign, nonatomic) ZFSortOrder sortOrderValue;

@property (readwrite, assign, nonatomic) int categoryCodeValue;

@property (readwrite, assign, nonatomic) int offsetValue;

@property (readwrite, assign, nonatomic) int limitValue;
@end

