//
//	FLTableViewLayoutBuilder.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/29/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLTableViewTab.h"
#import "FLTableViewSection.h"
#import "FLEditObjectTableViewCell.h"
#import "FLTableViewLayout.h"

typedef void (^FLTableViewLayoutCreateCell)(id cell); // returns keyPath for data

@interface FLTableViewLayoutBuilder : NSObject {
@private
	NSUInteger _tab;
	FLTableViewLayout* _tableLayout;
	FLTableViewSection* _currentSection;
	FLEditObjectTableViewCell* _currentCell;
	NSMutableArray* _cells;
	NSMutableArray* _groups;
}

@property (readonly, retain, nonatomic) NSMutableArray* cells;
@property (readonly, retain, nonatomic) NSMutableArray* sections;

@property (readwrite, retain, nonatomic) FLTableViewLayout* tableLayout;
@property (readwrite, retain, nonatomic) FLEditObjectTableViewCell* cell;
@property (readwrite, retain, nonatomic) FLTableViewSection* section;
@property (readwrite, assign, nonatomic) NSUInteger tab;

- (id) initWithTableLayout:(FLTableViewLayout*) tableLayout;

+ (FLTableViewLayoutBuilder*) tableViewLayoutBuilder:(FLTableViewLayout*) tableLayout;

- (void) addTab;

- (FLTableViewSection*) addSection:(NSString*) key;
- (FLTableViewSection*) addSection;

- (FLEditObjectTableViewCell*) addCell:(FLEditObjectTableViewCell*) cell;
- (FLEditObjectTableViewCell*) addCell:(FLEditObjectTableViewCell*) cell forKey:(NSString*) forKey;
- (FLEditObjectTableViewCell*) addCell:(FLEditObjectTableViewCell*) cell forKey:(NSString*) key dataSourceKey:(NSString*) dataSource;

- (void) addCell:(FLEditObjectTableViewCell*) cell 
         forKey:(NSString*) dataKeyOrNil
   configureCell:(FLTableViewLayoutCreateCell) configureCell;
@end