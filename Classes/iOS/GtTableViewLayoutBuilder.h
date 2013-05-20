//
//	GtTableViewLayoutBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/29/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTableViewTab.h"
#import "GtTableViewSection.h"
#import "GtEditObjectTableViewCell.h"
#import "GtTableViewLayout.h"

typedef void (^GtTableViewLayoutCreateCell)(id cell); // returns keyPath for data

@interface GtTableViewLayoutBuilder : NSObject {
@private
	NSUInteger m_tab;
	GtTableViewLayout* m_tableLayout;
	GtTableViewSection* m_currentSection;
	GtEditObjectTableViewCell* m_currentCell;
	NSMutableArray* m_cells;
	NSMutableArray* m_groups;
}

@property (readonly, retain, nonatomic) NSMutableArray* cells;
@property (readonly, retain, nonatomic) NSMutableArray* sections;

@property (readwrite, retain, nonatomic) GtTableViewLayout* tableLayout;
@property (readwrite, retain, nonatomic) GtEditObjectTableViewCell* cell;
@property (readwrite, retain, nonatomic) GtTableViewSection* section;
@property (readwrite, assign, nonatomic) NSUInteger tab;

- (id) initWithTableLayout:(GtTableViewLayout*) tableLayout;

+ (GtTableViewLayoutBuilder*) tableViewLayoutBuilder:(GtTableViewLayout*) tableLayout;

- (void) addTab;

- (GtTableViewSection*) addSection:(NSString*) key;
- (GtTableViewSection*) addSection;

- (GtEditObjectTableViewCell*) addCell:(GtEditObjectTableViewCell*) cell;
- (GtEditObjectTableViewCell*) addCell:(GtEditObjectTableViewCell*) cell forKey:(NSString*) forKey;
- (GtEditObjectTableViewCell*) addCell:(GtEditObjectTableViewCell*) cell forKey:(NSString*) key dataSourceKey:(NSString*) dataSource;

- (void) addCell:(GtEditObjectTableViewCell*) cell 
         forKey:(NSString*) dataKeyOrNil
   configureCell:(GtTableViewLayoutCreateCell) configureCell;
@end