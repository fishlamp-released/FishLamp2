//
//	FLZenfolioCategoryInfo.h
//	ZenfolioWebService
//
//	Created by Mike Fullerton on 5/5/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLZenfolioCategory.h"

@interface FLZenfolioParsedCategory : NSObject<NSCoding> {
@private
	int _category;
	int _subCategory;
	int _subCategoryDetail;
	NSNumber* _categoryCode;
	NSString* _displayName;
}


- (id) initWithCategory:(FLZenfolioCategory*) categoryObject;
- (id) initEmptyCategory;

+ (FLZenfolioParsedCategory*) emptyCategory;

@property (readonly, strong, nonatomic) NSString* displayName;

// this is the raw code from Zenfolio
@property (readonly, strong, nonatomic) NSNumber* categoryCode;

@property (readonly, assign, nonatomic) int category;
@property (readonly, assign, nonatomic) int subCategory;
@property (readonly, assign, nonatomic) int subCategoryDetail;

@property (readonly, assign, nonatomic) BOOL isCategory;
@property (readonly, assign, nonatomic) BOOL isSubCategory;
@property (readonly, assign, nonatomic) BOOL isSubCategoryDetail;

@property (readonly, assign, nonatomic) BOOL isEmpty;

@end
