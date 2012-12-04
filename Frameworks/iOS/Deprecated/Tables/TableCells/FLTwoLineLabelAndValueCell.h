//
//	FLTwoLineLabelAndValueCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLLabelAndValueBaseCell.h"

@interface FLTwoLineLabelAndValueCell : FLLabelAndValueBaseCell {
}

+ (FLTwoLineLabelAndValueCell*) twoLineLabelAndValueCell;
+ (FLTwoLineLabelAndValueCell*) twoLineLabelAndValueCell:(NSString*) label;
+ (FLTwoLineLabelAndValueCell*) twoLineLabelAndValueCell:(NSString*) label value:(NSString*) value;

@end

