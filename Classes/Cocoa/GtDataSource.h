//
//	GtDataSouce.h
//	FishLamp
//
//	Created by Mike Fullerton on 8/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtOrderedCollection.h"

typedef struct {
	NSString* dataSourceKey;
	NSString* dataKey;
} GtSplitKeyPath;

NS_INLINE
NSString* GtKeyPathStringMake(NSString* dataSourceKey, NSString* dataKey)
{
	return GtStringIsEmpty(dataSourceKey) ? 
		GtRetain(GtAutorelease(dataKey)) : 
		[NSString stringWithFormat:@"%@.%@", dataSourceKey, dataKey];
}

extern
GtSplitKeyPath GtSplitKeyPathFromString(NSString* string); // strings are autoreleased.

NS_INLINE
NSString* GtStringFromSplitKeyPath(GtSplitKeyPath splitKeyPath)
{
	return GtKeyPathStringMake(splitKeyPath.dataSourceKey, splitKeyPath.dataKey);
}

@class GtDataSource;

// -------
@protocol GtDataSourceManagerDelegate;

@interface GtDataSourceManager : NSObject {
@private
	NSMutableDictionary* m_dataSources;
	id<GtDataSourceManagerDelegate> m_delegate;
}

@property (readwrite, assign, nonatomic) id<GtDataSourceManagerDelegate> delegate; 

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

@protocol GtDataSourceManagerDelegate <NSObject>
- (void) dataSourceManager:(GtDataSourceManager*) dataSource 
	dataChangedForKeyPath:(NSString*) keyPath 
	newValue:(id) newValue
	previousValue:(id) previousValue;

- (void) dataSourceManager:(GtDataSourceManager*) dataSource 
	dataRemovedForKeyPath:(NSString*) keyPath 
	previousValue:(id) previousValue;

@end

@interface NSObject (GtDataSourceAdaptor)
- (id) dataSourceManager:(GtDataSourceManager*) dataSourceManager objectForKey:(id) key;
- (void) dataSourceManager:(GtDataSourceManager*) dataSourceManager setObject:(id) object forKey:(id) key;
- (void) dataSourceManager:(GtDataSourceManager*) dataSourceManager removeObjectForKey:(id) key;
- (BOOL) dataSourceManager:(GtDataSourceManager*) dataSourceManager objectExistsForKey:(id) key;
- (BOOL) dataSourceManager:(GtDataSourceManager*) dataSourceManager ownsObjectForKey:(id) key;
@end

@interface NSObject (GtKeyPath)
+ (NSString*) keyPathWithDataKey:(NSString*) dataKey;
+ (NSString*) dataSourceKey;
@end