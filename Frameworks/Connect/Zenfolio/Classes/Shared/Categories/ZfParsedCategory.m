//
//	ZFCategoryInfo.m
//	ZenfolioWebService
//
//	Created by Mike Fullerton on 5/5/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "ZFParsedCategory.h"

@interface ZFParsedCategory ()
@property (readwrite, strong, nonatomic) NSString* displayName;
@property (readwrite, strong, nonatomic) NSNumber* categoryCode;
@end


@implementation ZFParsedCategory

@synthesize category = _category;
@synthesize subCategory = _subCategory;
@synthesize subCategoryDetail = _subCategoryDetail;
@synthesize categoryCode = _categoryCode;
@synthesize displayName = _displayName;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[aCoder encodeObject:_displayName forKey:@"name"];
	[aCoder encodeInt32:_category forKey:@"cat"];
	[aCoder encodeInt32:_subCategory forKey:@"subcat"];
	[aCoder encodeInt32:_subCategoryDetail forKey:@"detail"];
	[aCoder encodeInt64:[_categoryCode longLongValue] forKey:@"code"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if((self = [super init]))
	{
		self.displayName = [aDecoder decodeObjectForKey:@"name"];
		_category = [aDecoder decodeInt32ForKey:@"cat"];
		_subCategory = [aDecoder decodeInt32ForKey:@"subcat"];
		_subCategoryDetail = [aDecoder decodeInt32ForKey:@"detail"];
		self.categoryCode = [NSNumber numberWithUnsignedLongLong:(unsigned long long)[aDecoder decodeInt64ForKey:@"code"]];
	}
	
	return self;
}

- (id) initWithCategory:(ZFCategory*) categoryObject
{
	if((self = [super init]))
	{
		_displayName = FLRetain(categoryObject.DisplayName);
		
		_categoryCode = FLRetain(categoryObject.Code);

		NSString* data = [[NSString alloc] initWithFormat:@"%d", _categoryCode.intValue];
		NSUInteger len = [data length];
		_category = [[data substringWithRange:NSMakeRange(0, 3 - (9 - len))] intValue]; // leading zeros truncated
		_subCategory = [[data substringWithRange:NSMakeRange(len - 6,3)] intValue];
		_subCategoryDetail = [[data substringWithRange:NSMakeRange(len - 3,3)] intValue];
		FLReleaseWithNil(data);
	}
	
	return self;
}

- (void) dealloc
{
	FLReleaseWithNil(_categoryCode);
	FLReleaseWithNil(_displayName);
	FLSuperDealloc();
}

- (NSString*) description
{
	return [NSString stringWithFormat:@"%@: codeValue: %@, category: %d, subcategory: %d, subcategory details: %d",
		_displayName,
		[_categoryCode description],
		_category,
		_subCategory,
		_subCategoryDetail];
}

- (BOOL) isCategory
{
	return _category != 0 && _subCategory == 0 && _subCategoryDetail == 0;
}

- (BOOL) isSubCategory
{
	return _category != 0 && _subCategory != 0 && _subCategoryDetail == 0;
}

- (BOOL) isSubCategoryDetail
{
	return _category != 0 && _subCategory != 0 && _subCategoryDetail != 0;
}

+ (NSString*) displayFormatterDataToString:(ZFParsedCategory*) aCat
{
	return aCat.displayName;
}

- (id) initEmptyCategory
{
	if((self = [super init]))
	{
		_displayName = @"None";
		_category = 0;
		_categoryCode = 0;
		_subCategoryDetail = 0;
		_subCategory = 0;
	}
	return self;
}

-(BOOL) isEmpty
{
	return _categoryCode == 0;
}

+ (ZFParsedCategory*) emptyCategory
{
	return FLAutorelease([[ZFParsedCategory alloc] initEmptyCategory]);
}

@end
