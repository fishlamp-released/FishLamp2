//
//  GtTableViewCell.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/29/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtDisplayDataRow.h"

#define GT_DEFAULT_CELL_HEIGHT 40

@interface GtTableViewCell : UITableViewCell {

@private
	GtDisplayDataRow* m_rowData;
	BOOL m_isLoaded;
}

@property (readonly, assign, nonatomic) GtDisplayDataRow* rowData;
@property (readwrite, assign, nonatomic) BOOL isLoaded;
@property (readonly, assign, nonatomic) CGFloat cellHeight;

- (void) setRowData:(GtDisplayDataRow*) rowData isLoaded:(BOOL) isLoaded;

@end
