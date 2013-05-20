//
//	GtWideSingleLineLabelAndValueCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtLabelAndValueBaseCell.h"

#define GtWideSingleLineLabelAndValueCellDefaultHeight 35.0

@interface GtWideSingleLineLabelAndValueCell : GtLabelAndValueBaseCell {
}

- (void) layoutLabels:(CGRect) rect;

+ (GtWideSingleLineLabelAndValueCell*) wideSingleLineLabelAndValueCell;
+ (GtWideSingleLineLabelAndValueCell*) wideSingleLineLabelAndValueCell:(NSString*) label;
+ (GtWideSingleLineLabelAndValueCell*) wideSingleLineLabelAndValueCell:(NSString*) label value:(NSString*) value;
@end