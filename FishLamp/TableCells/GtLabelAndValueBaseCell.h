//
//  GtLabelAndValueBaseCell.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "GtDisplayDataRow.h"
#import "GtTableViewCell.h"

#define GtDefaultRowHeight 40

@interface GtLabelAndValueBaseCell : GtTableViewCell {
@private;
	UILabel* m_label;
	UILabel* m_value;
    struct {
        unsigned int updateTextWithRowData:1;
    } m_baseFlags;
}

@property (readwrite, assign, nonatomic) BOOL updateTextWithRowData;

@property (readonly, assign, nonatomic) UILabel* label;
@property (readonly, assign, nonatomic) UILabel* value;

@property (readwrite, assign, nonatomic) NSString* text;

- (void) createValue;
- (void) createLabel;	
	
@end

