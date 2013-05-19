//
//	FLTwoLineLabelAndValueCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLLabelAndValueBaseCell.h"

@interface FLTwoLineLabelAndValueCell : FLLabelAndValueBaseCell {
}

+ (FLTwoLineLabelAndValueCell*) twoLineLabelAndValueCell;
+ (FLTwoLineLabelAndValueCell*) twoLineLabelAndValueCell:(NSString*) label;
+ (FLTwoLineLabelAndValueCell*) twoLineLabelAndValueCell:(NSString*) label value:(NSString*) value;

@end

