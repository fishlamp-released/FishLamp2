//
//	FLZenfolioCategoryManager.h
//	FishLamp
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZenfolioParsedCategory.h"
#import "FLDisplayFormatter.h"
#import "FLCachedObjectOperation.h"

@interface FLZenfolioCategoryManager : NSObject {
@private
	NSMutableDictionary* _categories;
	NSMutableArray* _array;
}

- (void) setCategoryArray:(NSArray*) array;

- (FLZenfolioParsedCategory*) parsedCategoryFromServerCategoryId:(NSNumber*) categoryId;

- (NSString*) lookupCategoryName:(NSNumber*) categoryId;
- (NSString*) lookupCategoryNameWithInt:(int) categoryId;
- (BOOL) categoriesAreLoaded;

- (NSArray*) rootCategories;
- (NSArray*) subCategoriesFromCategory:(FLZenfolioParsedCategory*) category;
- (NSArray*) subCategoryDetailsFromCategory:(FLZenfolioParsedCategory*) category;

- (BOOL) subCategoryHasSubCategoryDetails:(FLZenfolioParsedCategory*) category;

- (NSMutableArray*) serverCategoryArrayFromParsedCategoryArray:(NSArray*) parsedCategoryArray;

- (NSMutableArray*) parsedCategoryArrayFromServerCategoryArray:(NSArray*) serverCategoryArray;

+ (FLZenfolioParsedCategory*) parsedCategoryFromString:(NSString*) string parsedCategoryArray:(NSArray*) array;

+ (NSArray*) stringArrayFromParsedCategoryArray:(NSArray*) parsedCategoryArray;

@end

@interface FLZenfolioCategoryFormatter : NSObject
@end
#if REFACTOR
@interface FLZenfolioLoadCachedCategories : FLCachedObjectOperation {
	FLZenfolioCategoryManager* _manager;
    FLZenfolioCachedCategories* _inputArray;
    FLZenfolioApiSoapGetCategories* _subOperation;
}
- (id) initWithCategoryManager:(FLZenfolioCategoryManager*) manager;
+ (id) loadCachedCategories:(FLZenfolioCategoryManager*) manager;
@end
#endif