//
//	GtTableViewLayout.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTableViewTab.h"
#import "GtTableViewSection.h"
#import "GtEditObjectTableViewCell.h"

@interface GtTableViewLayout : NSObject {
	NSMutableArray* m_tabs;
	NSUInteger m_currentTabIndex;
	id<GtTableViewCellDataSource> m_cellDataSource;
}

- (id) initWithCellDataSouce:(id<GtTableViewCellDataSource>) dataSource;

@property (readwrite, assign, nonatomic) id<GtTableViewCellDataSource> cellDataSource;
@property (readonly, assign, nonatomic) NSUInteger tabCount;
@property (readwrite, assign, nonatomic) NSUInteger currentTabIndex; 
@property (readonly, assign, nonatomic) GtTableViewTab* currentTab;

- (void) addTab;

- (GtTableViewTab*) tabWithIndex:(NSUInteger) tab;

- (GtEditObjectTableViewCell*) rowForRowKey:(id) key;
- (void) removeRowForRowKey:(id) key;

//- (BOOL) hasEditableRows;

- (void) prepareForDestruction;

@end

