//	This file was generated at 3/13/12 6:26 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCachedCategories.h
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//


@class ZFCategory;

// --------------------------------------------------------------------
// ZFCachedCategories
// --------------------------------------------------------------------
@interface ZFCachedCategories : NSObject<NSCopying, NSCoding>{ 
@private
	NSNumber* _arrayId;
	NSMutableArray* _categoryArray;
} 


@property (readwrite, retain, nonatomic) NSNumber* arrayId;

@property (readwrite, retain, nonatomic) NSMutableArray* categoryArray;
// Type: ZFCategory*, forKey: category

+ (NSString*) arrayIdKey;

+ (NSString*) categoryArrayKey;

+ (ZFCachedCategories*) cachedCategories; 

@end

@interface ZFCachedCategories (ValueProperties) 

@property (readwrite, assign, nonatomic) NSInteger arrayIdValue;
@end

