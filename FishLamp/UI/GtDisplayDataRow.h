//
//  GtDisplayDataRow.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/20/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtEditableDataProtocol.h"
#import "GtDisplayFormatter.h"
#import "GtObject.h"

@class GtDisplayDataGroup;
@class GtObjectEditHandler;
@protocol GtDisplayDataRowDataSource;

#define GtDefaultSingleLineMinHeight 18.0
#define GtDefaultMultiLineMinHeight (GtDefaultSingleLineMinHeight*2)

#define LABEL_HEIGHT 14
#define LABEL_TOP 8.0

@interface GtDisplayDataRow : NSObject {
@private

// retained    
	UITableViewCell* m_cell;
	id m_key;
	NSString* m_label;
	NSString* m_helpText;

	SEL m_cellConfigureAction;
	Class m_cellClass;
	
	SEL m_panelConfigureAction;
	Class m_panelClass;
	
	Class m_formatterClass;
	id m_rowId;
	id m_cellData;

// not retained
	GtDisplayDataGroup* m_parent;
	id m_dataSource;

// data	
    NSUInteger m_maxDataSize;
    struct {
        unsigned int committing: 1;
        unsigned int editing: 1;
        unsigned int isEditable: 1;
	} m_flags;
    
}

- (id) initWithDataSourceAndKey:(id<GtDisplayDataRowDataSource>) dataSource key:(id) key;

// data
@property (readwrite, assign, nonatomic) id data;
@property (readwrite, assign, nonatomic) NSUInteger maxDataSize;

// data source
@property (readonly, assign, nonatomic) id key;
@property (readwrite, assign, nonatomic) id dataSource;

// misc helpers
@property (readwrite, assign, nonatomic) GtDisplayDataGroup* parentGroup;
@property (readonly, assign, nonatomic) GtObjectEditHandler* parentHandler;

// display
@property (readwrite, assign, nonatomic) NSString* label;
@property (readwrite, assign, nonatomic) NSString* helpText;
@property (readwrite, assign, nonatomic) Class formatterClass;

// cell
@property (readwrite, assign, nonatomic) UITableViewCell* cell;
@property (readwrite, assign, nonatomic) SEL cellConfigureAction;
@property (readwrite, assign, nonatomic) Class cellClass;
@property (readwrite, assign, nonatomic) id cellData;

@property (readwrite, assign, nonatomic) SEL panelConfigureAction;
@property (readwrite, assign, nonatomic) Class panelClass;

// state
@property (readwrite, assign, nonatomic) id rowId;
@property (readwrite, assign, nonatomic) BOOL isEditable;
@property (readwrite, assign, nonatomic) BOOL editing;


- (NSString*) displayStringFromValue;
- (void) setValueWithDisplayString:(NSString*) displayString;
- (id) getDataFromStringDisplay:(NSString*) data;

- (CGFloat) textHeight:(UIFont*) font areaSize:(CGSize) areaSize;

- (CGFloat) textHeight;

+ (CGFloat) defaultCellWidth;
	
@end

@protocol GtDisplayDataRowDataSource <NSObject>

- (id) displayDataRow:(GtDisplayDataRow*) row getDataForRow:(id) key;
- (void) displayDataRow:(GtDisplayDataRow*) row setDataForRow:(id) key data:(id) data;

@end

/** 
This is the same as GtDisplayDataRow except it doesn't use the
data source. You set the data in it and it owns the data
*/

@interface GtSimpleDisplayDataRow : GtDisplayDataRow {
@private
	id m_data;
}

@property (readwrite, assign, nonatomic) id data;

- (id) initWithRowData:(id) data;

@end
