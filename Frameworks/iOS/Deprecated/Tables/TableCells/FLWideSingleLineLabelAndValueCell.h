//
//	FLWideSingleLineLabelAndValueCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLLabelAndValueBaseCell.h"

#define FLWideSingleLineLabelAndValueCellDefaultHeight 35.0

@interface FLWideSingleLineLabelAndValueCell : FLLabelAndValueBaseCell {
}

- (void) layoutLabels:(CGRect) rect;

+ (FLWideSingleLineLabelAndValueCell*) wideSingleLineLabelAndValueCell;
+ (FLWideSingleLineLabelAndValueCell*) wideSingleLineLabelAndValueCell:(NSString*) label;
+ (FLWideSingleLineLabelAndValueCell*) wideSingleLineLabelAndValueCell:(NSString*) label value:(NSString*) value;
@end