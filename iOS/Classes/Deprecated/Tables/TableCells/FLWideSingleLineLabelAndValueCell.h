//
//	FLWideSingleLineLabelAndValueCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLLabelAndValueBaseCell.h"

#define FLWideSingleLineLabelAndValueCellDefaultHeight 35.0

@interface FLWideSingleLineLabelAndValueCell : FLLabelAndValueBaseCell {
}

- (void) layoutLabels:(FLRect) rect;

+ (FLWideSingleLineLabelAndValueCell*) wideSingleLineLabelAndValueCell;
+ (FLWideSingleLineLabelAndValueCell*) wideSingleLineLabelAndValueCell:(NSString*) label;
+ (FLWideSingleLineLabelAndValueCell*) wideSingleLineLabelAndValueCell:(NSString*) label value:(NSString*) value;
@end