//
//	FLDataSouce.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/26/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FishLamp.h"

@protocol FLLegacyDataSourceDelegate;

@interface FLLegacyDataSource : NSObject {
@private
	NSMutableDictionary* _dataSources;
	__unsafe_unretained id<FLLegacyDataSourceDelegate> _delegate;
}

@property (readwrite, assign, nonatomic) id<FLLegacyDataSourceDelegate> delegate; 

- (NSDictionary*) dataSources;

// data source management
- (void) setDataSource:(id) dataSource forKey:(NSString*) key;
- (void) setDefaultDataSource:(id) dataSource; // owns all keys not owned by other dataSources.

- (id) dataSourceForDataSourceKey:(NSString*) key;
- (id) defaultDataSource;

- (id) dataSourceForKeyPath:(NSString*) keyPath;

// data management

- (id) objectForKeyPath:(NSString*) keyPath;
- (BOOL) objectExistsForKeyPath:(NSString*) keyPath;

- (void) setObject:(id) object forKeyPath:(NSString*) keyPath fireDataChangedEvent:(BOOL) fire;
- (void) removeObjectForKeyPath:(NSString*) keyPath fireDataChangedEvent:(BOOL) fire;
@end

typedef struct {
	__unsafe_unretained NSString* dataSourceKey;
	__unsafe_unretained NSString* dataKey;
} FLSplitKeyPath;

NS_INLINE
NSString* FLKeyPathStringMake(NSString* dataSourceKey, NSString* dataKey) {
	return FLStringIsEmpty(dataSourceKey) ? 
		FLAutorelease(FLRetain(dataKey)) :
		[NSString stringWithFormat:@"%@.%@", dataSourceKey, dataKey];
}

extern
FLSplitKeyPath FLSplitKeyPathFromString(NSString* string); // strings are autoreleased.

NS_INLINE
NSString* FLStringFromSplitKeyPath(FLSplitKeyPath splitKeyPath) {
	return FLKeyPathStringMake(splitKeyPath.dataSourceKey, splitKeyPath.dataKey);
}


@protocol FLLegacyDataSourceDelegate <NSObject>
- (void) dataSourceManager:(FLLegacyDataSource*) dataSource 
	dataChangedForKeyPath:(NSString*) keyPath 
	newValue:(id) newValue
	previousValue:(id) previousValue;

- (void) dataSourceManager:(FLLegacyDataSource*) dataSource 
	dataRemovedForKeyPath:(NSString*) keyPath 
	previousValue:(id) previousValue;

@end

@interface NSObject (FLLegacyDataSourceAdaptor)
- (id) dataSourceManager:(FLLegacyDataSource*) dataSourceManager objectForKey:(id) key;
- (void) dataSourceManager:(FLLegacyDataSource*) dataSourceManager setObject:(id) object forKey:(id) key;
- (void) dataSourceManager:(FLLegacyDataSource*) dataSourceManager removeObjectForKey:(id) key;
- (BOOL) dataSourceManager:(FLLegacyDataSource*) dataSourceManager objectExistsForKey:(id) key;
- (BOOL) dataSourceManager:(FLLegacyDataSource*) dataSourceManager ownsObjectForKey:(id) key;
@end

@interface NSObject (FLKeyPath)
+ (NSString*) keyPathWithDataKey:(NSString*) dataKey;
+ (NSString*) dataSourceKey;
@end