//
//	ZFCategoryManager.h
//	MyZen
//
//	Created by Mike Fullerton on 6/13/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ZFParsedCategory.h"
#import "FLDisplayFormatter.h"
#import "FLCachedObjectOperation.h"

@interface ZFCategoryManager : NSObject {
@private
	NSMutableDictionary* _categories;
	NSMutableArray* _array;
}

- (void) setCategoryArray:(NSArray*) array;

- (ZFParsedCategory*) parsedCategoryFromServerCategoryId:(NSNumber*) categoryId;

- (NSString*) lookupCategoryName:(NSNumber*) categoryId;
- (NSString*) lookupCategoryNameWithInt:(int) categoryId;
- (BOOL) categoriesAreLoaded;

- (NSArray*) rootCategories;
- (NSArray*) subCategoriesFromCategory:(ZFParsedCategory*) category;
- (NSArray*) subCategoryDetailsFromCategory:(ZFParsedCategory*) category;

- (BOOL) subCategoryHasSubCategoryDetails:(ZFParsedCategory*) category;

- (NSMutableArray*) serverCategoryArrayFromParsedCategoryArray:(NSArray*) parsedCategoryArray;

- (NSMutableArray*) parsedCategoryArrayFromServerCategoryArray:(NSArray*) serverCategoryArray;

+ (ZFParsedCategory*) parsedCategoryFromString:(NSString*) string parsedCategoryArray:(NSArray*) array;

+ (NSArray*) stringArrayFromParsedCategoryArray:(NSArray*) parsedCategoryArray;

@end

@interface ZFCategoryFormatter : NSObject
@end
#if REFACTOR
@interface ZFLoadCachedCategories : FLCachedObjectOperation {
	ZFCategoryManager* _manager;
    ZFCachedCategories* _inputArray;
    ZFApiSoapGetCategories* _subOperation;
}
- (id) initWithCategoryManager:(ZFCategoryManager*) manager;
+ (id) loadCachedCategories:(ZFCategoryManager*) manager;
@end
#endif