//
//	FLTableViewLayout.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLTableViewTab.h"
#import "FLTableViewSection.h"
#import "FLEditObjectTableViewCell.h"

@interface FLTableViewLayout : NSObject {
	NSMutableArray* _tabs;
	NSUInteger _currentTabIndex;
	__unsafe_unretained id<FLTableViewCellDataSource> _cellDataSource;
}

- (id) initWithCellDataSouce:(id<FLTableViewCellDataSource>) dataSource;

@property (readwrite, assign, nonatomic) id<FLTableViewCellDataSource> cellDataSource;
@property (readonly, assign, nonatomic) NSUInteger tabCount;
@property (readwrite, assign, nonatomic) NSUInteger currentTabIndex; 
@property (readonly, assign, nonatomic) FLTableViewTab* currentTab;

- (void) addTab;

- (FLTableViewTab*) tabWithIndex:(NSUInteger) tab;

- (FLEditObjectTableViewCell*) rowForRowKey:(id) key;
- (void) removeRowForRowKey:(id) key;

//- (BOOL) hasEditableRows;

- (void) prepareForDestruction;

@end

