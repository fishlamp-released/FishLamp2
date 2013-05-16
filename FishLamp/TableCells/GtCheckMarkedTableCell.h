//
//  GtCheckMarkedTableCell.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/15/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#include "GtDisplayDataRow.h"
#include "GtDataContainer.h"
#import "GtTableViewCell.h"

@class GtSharedCheckMarkTableCellData;

@interface GtCheckMarkedTableCell : GtTableViewCell {
	BOOL m_checked;
	UILabel* m_subLabel;
}

@property (readwrite, copy, nonatomic) NSString* displayText;
@property (readwrite, retain, nonatomic) NSString* subText;
@property (readwrite, assign, nonatomic) BOOL checked;

@end

