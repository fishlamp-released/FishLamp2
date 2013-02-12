//
//	FLZenfolioCategoryManager.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#if REFACTOR


#import "FLZenfolioCategoryManager.h"
#import "FLZenfolioParsedCategory.h"
#import "FLDatabaseCacheOperation.h"
#import "FLLowMemoryHandler.h"
#import "FLZenfolioCachedCategories.h"
#import "FLZenfolioApiSoapGetCategories.h"
#import "FLZenfolioErrors.h"


@implementation ZFCachedCategories (Cache)
FLSynthesizeCachedObjectHandlerProperty(ZFCachedCategories);
@end

@implementation FLZenfolioLoadCachedCategories

- (id) initWithCategoryManager:(FLZenfolioCategoryManager*) manager
{
	if((self = [super init]))
	{
		_manager = FLRetain(manager);
		
		_inputArray = [[FLZenfolioCachedCategories alloc] init];
		_inputArray.arrayIdValue = 1;
		
		_subOperation = [[FLZenfolioApiSoapGetCategories alloc] initWithServerContext:[FLZenfolioApiSoap instance]];
		
		self.cache = [[self.context userStorageService].cacheDatabase;
		self.canLoadFromCache = YES;
		self.canSaveToCache = YES;
	}
	
	return self;
}

+ (FLOperation*) subOperation {
    return _subOperation;
}



+ (id) loadCachedCategories:(FLZenfolioCategoryManager*) manager {
    return FLAutorelease([[[self class] alloc] initWithCategoryManager:manager]);
}

- (FLResult) resultFromCacheObject:(id) object {
	return [object categoryArray];
}

- (void) saveOutputToCache:(FLResult) result {
	[self.input setCategoryArray: result];
	[self.cache saveObject:_inputArray];
}

- (FLResult) runOperation {
    [super runOperationWithInput];
	if(!self.error) {
		[_manager setCategoryArray:self.output];
	}
}

#if FL_MRC
- (void) dealloc {
    [_manager release];
    [super dealloc];
}
#endif


@end

@implementation FLZenfolioCategoryManager

- (id) init
{
	if((self = [super init]))
	{
	}
	
	return self;
}

- (void) setCategoryArray:(NSArray*) ZenfolioArray
{
	FLReleaseWithNil(_array);
	FLReleaseWithNil(_categories);

	_array = [[NSMutableArray alloc] initWithCapacity:[ZenfolioArray count]];
	_categories = [[NSMutableDictionary alloc] initWithCapacity:[ZenfolioArray count]];

	for(FLZenfolioCategory* cat in ZenfolioArray)
	{
		FLZenfolioParsedCategory* ZenfolioCat = [[FLZenfolioParsedCategory alloc] initWithCategory:cat];
	
		[_categories setObject:ZenfolioCat forKey:[ZenfolioCat categoryCode]];
		[_array addObject:ZenfolioCat];
		
		FLReleaseWithNil(ZenfolioCat);
	}
}

- (void) dealloc
{	
	FLRelease(_array);
	FLRelease(_categories);
	FLSuperDealloc();
}

- (FLZenfolioParsedCategory*) parsedCategoryFromServerCategoryId:(NSNumber*) categoryId
{
	if(!_categories) {
		FLThrowErrorCode_v(FLZenfolioErrorDomain, FLZenfolioErrorCodeCategoriesNotLoaded, @"Categories not loaded");
	}
	
	return [_categories objectForKey:categoryId];
}


- (NSString*) lookupCategoryName:(NSNumber*) categoryId
{
	if(!_categories) {
		FLThrowErrorCode_v(FLZenfolioErrorDomain, FLZenfolioErrorCodeCategoriesNotLoaded, @"Categories not loaded");
	}
	
	return [[_categories objectForKey:categoryId] displayName];
}

- (NSString*) lookupCategoryNameWithInt:(int) categoryId
{
	NSNumber* num = [[NSNumber alloc] initWithInt:categoryId];
	NSString* outString = [self lookupCategoryName:num];
	FLReleaseWithNil(num);
	return outString;
}

- (BOOL) categoriesAreLoaded
{
	return _categories != nil;
}

- (NSArray*) rootCategories
{
	NSMutableArray* array = FLAutorelease([[NSMutableArray alloc] init]);
	for(FLZenfolioParsedCategory* cat in _array)
	{
		if(cat.subCategory == 0 && cat.subCategoryDetail == 0)
		{
			[array addObject:cat];
		}
	}
	
	return array;
}

- (NSArray*) subCategoriesFromCategory:(FLZenfolioParsedCategory*) category
{
	NSMutableArray* array = FLAutorelease([[NSMutableArray alloc] init]);
	for(FLZenfolioParsedCategory* cat in _array)
	{
		if( cat.category == category.category &&
			cat.subCategory != 0 && 
			cat.subCategoryDetail == 0)
		{
			[array addObject:cat];
		}
	}
	
	return array;
}

- (BOOL) subCategoryHasSubCategoryDetails:(FLZenfolioParsedCategory*) category
{
	for(FLZenfolioParsedCategory* cat in _array)
	{
		if( cat.category == category.category &&
			cat.subCategory == category.subCategory &&
			cat.subCategoryDetail != 0)
		{
			return YES;
		}
	}
    
    return NO;
}

- (NSArray*) subCategoryDetailsFromCategory:(FLZenfolioParsedCategory*) category
{
	NSMutableArray* array = FLAutorelease([[NSMutableArray alloc] init]);
	for(FLZenfolioParsedCategory* cat in _array)
	{
		if( cat.category == category.category &&
			cat.subCategory == category.subCategory &&
			cat.subCategoryDetail != 0)
		{
			[array addObject:cat];
		}
	}
	
	return array;
}

- (NSMutableArray*) serverCategoryArrayFromParsedCategoryArray:(NSArray*) parsedCategoryArray
{
	if([self categoriesAreLoaded] && parsedCategoryArray && parsedCategoryArray.count)
	{
		NSMutableArray* cats = [NSMutableArray array];
		for(FLZenfolioParsedCategory* cat in parsedCategoryArray)
		{
			[cats addObject:cat.categoryCode];
		}
		
		return cats;
	}
	
	return nil;
}

- (NSMutableArray*) parsedCategoryArrayFromServerCategoryArray:(NSArray*) serverCategoryArray
{
	if([self categoriesAreLoaded])
	{
		NSMutableArray* newArray = [NSMutableArray array];
		if(serverCategoryArray && serverCategoryArray.count)
		{
			for(NSNumber* catCode in serverCategoryArray)
			{
				[newArray addObject:[self parsedCategoryFromServerCategoryId:catCode]];
			}
		}
		
		return newArray;
	}
	
	return nil;
}

//- (NSArray*) parsedCategoryArrayFromCategores:(NSArray*) categories
//{
//	  if([self categoriesAreLoaded])
//	  {
//		  NSMutableArray* array = nil;
//		  [_categoryManager ZenfolioCategoryArrayFromIntCategoryArray:photo.Categories outCategoryArray:&array];
//		  if(array)
//		  {
//			photo.categoryArray = array;
//			  FLReleaseWithNil(array);
//		  }
//	  }
//}

+ (FLZenfolioParsedCategory*) parsedCategoryFromString:(NSString*) string parsedCategoryArray:(NSArray*) array
{
	if(FLStringsAreEqual(string, NSLocalizedString(@"None", nil)))
	{
		return nil;
	}
	
	for(FLZenfolioParsedCategory* category in array)
	{
		if([category.displayName isEqualToString:string])
		{
			return category;
		}
	}
	
	return nil;
}

+ (NSArray*) stringArrayFromParsedCategoryArray:(NSArray*) cats
{
	NSMutableArray* stringArray = [NSMutableArray arrayWithCapacity:cats.count];
	[stringArray addObject:NSLocalizedString(@"None", nil)];
	for(FLZenfolioParsedCategory* cat in cats)
	{
		[stringArray addObject:cat.displayName];
	}
	return stringArray;
}

@end

@implementation FLZenfolioCategoryFormatter

#define EMPTY NSLocalizedString(@"None", nil)

+ (NSString*) displayFormatterDataToString:(id) data
{
	if(!data)
	{
		return NSLocalizedString(@"Loading...", nil);
	}

	NSMutableString* outString = [NSMutableString string];
	if([data isKindOfClass:[NSArray class]])
	{
		NSArray* array = data;
	
		if(array.count == 0) 
		{
			return EMPTY;
		}
	
		FLZenfolioParsedCategory* cat = nil;
		FLZenfolioParsedCategory* subCat = nil;
		FLZenfolioParsedCategory* subCatDetails = nil;
		
		for(FLZenfolioParsedCategory* aCat in array)
		{
			if(aCat.isCategory)
			{
				cat = aCat;
			}
			else if(aCat.isSubCategory)
			{
				subCat = aCat;
			}
			else if(aCat.isSubCategoryDetail)
			{
				subCatDetails = aCat;
			}
		}
		
		if(cat)
		{
			[outString appendString:cat.displayName];
		}
		if(subCat)
		{
			[outString appendFormat:@", %@", subCat.displayName];
		}
		if(subCatDetails)
		{
			[outString appendFormat:@", %@", subCatDetails.displayName];
		}
	
	}
	else
	{
		FLAssertFailed_v(@"unknown category container");
	}
	
	return outString && outString.length > 0 ? outString: EMPTY;
}

+ (id) displayFormatterStringToData:(NSString*) string
{
	return nil;
}


@end
#endif