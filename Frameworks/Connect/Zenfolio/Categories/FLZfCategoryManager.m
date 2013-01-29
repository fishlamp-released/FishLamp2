//
//	FLZfCategoryManager.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//
#if REFACTOR


#import "FLZfCategoryManager.h"
#import "FLZfParsedCategory.h"
#import "FLDatabaseCacheOperation.h"
#import "FLLowMemoryHandler.h"
#import "FLZfCachedCategories.h"
#import "FLZfApiSoapGetCategories.h"
#import "FLZfErrors.h"

@implementation FLZfLoadCachedCategories

- (id) initWithCategoryManager:(FLZfCategoryManager*) manager
{
	if((self = [super init]))
	{
		_manager = FLRetain(manager);
		
		_inputArray = [[FLZfCachedCategories alloc] init];
		_inputArray.arrayIdValue = 1;
		
		_subOperation = [[FLZfApiSoapGetCategories alloc] initWithServerContext:[FLZfApiSoap instance]];
		
		self.cache = [[self.context userStorageService].cacheDatabase;
		self.canLoadFromCache = YES;
		self.canSaveToCache = YES;
	}
	
	return self;
}

+ (FLOperation*) subOperation {
    return _subOperation;
}



+ (id) loadCachedCategories:(FLZfCategoryManager*) manager {
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

@implementation FLZfCategoryManager

- (id) init
{
	if((self = [super init]))
	{
	}
	
	return self;
}

- (void) setCategoryArray:(NSArray*) zfArray
{
	FLReleaseWithNil(_array);
	FLReleaseWithNil(_categories);

	_array = [[NSMutableArray alloc] initWithCapacity:[zfArray count]];
	_categories = [[NSMutableDictionary alloc] initWithCapacity:[zfArray count]];

	for(FLZfCategory* cat in zfArray)
	{
		FLZfParsedCategory* zfCat = [[FLZfParsedCategory alloc] initWithCategory:cat];
	
		[_categories setObject:zfCat forKey:[zfCat categoryCode]];
		[_array addObject:zfCat];
		
		FLReleaseWithNil(zfCat);
	}
}

- (void) dealloc
{	
	FLRelease(_array);
	FLRelease(_categories);
	FLSuperDealloc();
}

- (FLZfParsedCategory*) parsedCategoryFromServerCategoryId:(NSNumber*) categoryId
{
	if(!_categories) {
		FLThrowErrorCode_v(FLZfErrorDomain, FLZfErrorCodeCategoriesNotLoaded, @"Categories not loaded");
	}
	
	return [_categories objectForKey:categoryId];
}


- (NSString*) lookupCategoryName:(NSNumber*) categoryId
{
	if(!_categories) {
		FLThrowErrorCode_v(FLZfErrorDomain, FLZfErrorCodeCategoriesNotLoaded, @"Categories not loaded");
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
	for(FLZfParsedCategory* cat in _array)
	{
		if(cat.subCategory == 0 && cat.subCategoryDetail == 0)
		{
			[array addObject:cat];
		}
	}
	
	return array;
}

- (NSArray*) subCategoriesFromCategory:(FLZfParsedCategory*) category
{
	NSMutableArray* array = FLAutorelease([[NSMutableArray alloc] init]);
	for(FLZfParsedCategory* cat in _array)
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

- (BOOL) subCategoryHasSubCategoryDetails:(FLZfParsedCategory*) category
{
	for(FLZfParsedCategory* cat in _array)
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

- (NSArray*) subCategoryDetailsFromCategory:(FLZfParsedCategory*) category
{
	NSMutableArray* array = FLAutorelease([[NSMutableArray alloc] init]);
	for(FLZfParsedCategory* cat in _array)
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
		for(FLZfParsedCategory* cat in parsedCategoryArray)
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
//		  [_categoryManager zfCategoryArrayFromIntCategoryArray:photo.Categories outCategoryArray:&array];
//		  if(array)
//		  {
//			photo.categoryArray = array;
//			  FLReleaseWithNil(array);
//		  }
//	  }
//}

+ (FLZfParsedCategory*) parsedCategoryFromString:(NSString*) string parsedCategoryArray:(NSArray*) array
{
	if(FLStringsAreEqual(string, NSLocalizedString(@"None", nil)))
	{
		return nil;
	}
	
	for(FLZfParsedCategory* category in array)
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
	for(FLZfParsedCategory* cat in cats)
	{
		[stringArray addObject:cat.displayName];
	}
	return stringArray;
}

@end

@implementation FLZfCategoryFormatter

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
	
		FLZfParsedCategory* cat = nil;
		FLZfParsedCategory* subCat = nil;
		FLZfParsedCategory* subCatDetails = nil;
		
		for(FLZfParsedCategory* aCat in array)
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