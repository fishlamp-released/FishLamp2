//	This file was generated at 3/13/12 6:26 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCachedCategories.h
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class FLZfCategory;

// --------------------------------------------------------------------
// FLZfCachedCategories
// --------------------------------------------------------------------
@interface FLZfCachedCategories : NSObject<NSCopying, NSCoding>{ 
@private
	NSNumber* _arrayId;
	NSMutableArray* _categoryArray;
} 


@property (readwrite, retain, nonatomic) NSNumber* arrayId;

@property (readwrite, retain, nonatomic) NSMutableArray* categoryArray;
// Type: FLZfCategory*, forKey: category

+ (NSString*) arrayIdKey;

+ (NSString*) categoryArrayKey;

+ (FLZfCachedCategories*) cachedCategories; 

@end

@interface FLZfCachedCategories (ValueProperties) 

@property (readwrite, assign, nonatomic) NSInteger arrayIdValue;
@end

