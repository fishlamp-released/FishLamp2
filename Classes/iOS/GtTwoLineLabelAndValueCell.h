//
//	GtTwoLineLabelAndValueCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtLabelAndValueBaseCell.h"

@interface GtTwoLineLabelAndValueCell : GtLabelAndValueBaseCell {
}

+ (GtTwoLineLabelAndValueCell*) twoLineLabelAndValueCell;
+ (GtTwoLineLabelAndValueCell*) twoLineLabelAndValueCell:(NSString*) label;
+ (GtTwoLineLabelAndValueCell*) twoLineLabelAndValueCell:(NSString*) label value:(NSString*) value;

@end

