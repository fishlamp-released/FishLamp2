//
//	FLZfCategoryManager.h
//	MyZen
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLZfParsedCategory.h"
#import "FLDisplayFormatter.h"
#import "FLCachedObjectOperation.h"

@interface FLZfCategoryManager : NSObject {
@private
	NSMutableDictionary* _categories;
	NSMutableArray* _array;
}

- (void) setCategoryArray:(NSArray*) array;

- (FLZfParsedCategory*) parsedCategoryFromServerCategoryId:(NSNumber*) categoryId;

- (NSString*) lookupCategoryName:(NSNumber*) categoryId;
- (NSString*) lookupCategoryNameWithInt:(int) categoryId;
- (BOOL) categoriesAreLoaded;

- (NSArray*) rootCategories;
- (NSArray*) subCategoriesFromCategory:(FLZfParsedCategory*) category;
- (NSArray*) subCategoryDetailsFromCategory:(FLZfParsedCategory*) category;

- (BOOL) subCategoryHasSubCategoryDetails:(FLZfParsedCategory*) category;

- (NSMutableArray*) serverCategoryArrayFromParsedCategoryArray:(NSArray*) parsedCategoryArray;

- (NSMutableArray*) parsedCategoryArrayFromServerCategoryArray:(NSArray*) serverCategoryArray;

+ (FLZfParsedCategory*) parsedCategoryFromString:(NSString*) string parsedCategoryArray:(NSArray*) array;

+ (NSArray*) stringArrayFromParsedCategoryArray:(NSArray*) parsedCategoryArray;

@end

@interface FLZfCategoryFormatter : NSObject
@end
#if REFACTOR
@interface FLZfLoadCachedCategories : FLCachedObjectOperation {
	FLZfCategoryManager* _manager;
    FLZfCachedCategories* _inputArray;
    FLZfApiSoapGetCategories* _subOperation;
}
- (id) initWithCategoryManager:(FLZfCategoryManager*) manager;
+ (id) loadCachedCategories:(FLZfCategoryManager*) manager;
@end
#endif