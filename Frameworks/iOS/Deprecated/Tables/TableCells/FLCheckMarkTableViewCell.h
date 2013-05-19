//
//	FLCheckMarkedTableCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLEditObjectTableViewCell.h"
#import "FLLabel.h"
@class FLCheckMarkGroup;

@interface FLCircleView : UIView {
@private    
    CGFloat _borderWidth;
    UIColor* _color;
}
@property (readwrite, assign, nonatomic) CGFloat borderWidth;
@property (readwrite, retain, nonatomic) UIColor* borderColor;

@end


@protocol FLCheckMarkTableCellDelegate;

@interface FLCheckMarkTableViewCell : FLEditObjectTableViewCell {
@private
	FLLabel* _subLabel;
	id _checkedValue;
	FLCheckMarkGroup* _group;
	BOOL _checked;
}
@property (readwrite, retain, nonatomic) FLCheckMarkGroup* checkMarkGroup;

@property (readwrite, retain, nonatomic) id checkedValue;

@property (readwrite, retain, nonatomic) NSString* subText;
@property (readwrite, assign, nonatomic) BOOL checked;

+ (id) checkMarkedTableCell:(NSString*) labelOrNil checked:(BOOL) checked checkedValue:(id) checkedValue;

@end

@protocol FLCheckMarkTableCellDelegate <NSObject>
- (void) checkMarkWasSelected:(FLCheckMarkTableViewCell*) cell;
@end

@interface FLOnOffCheckMarkTableViewCell : FLEditObjectTableViewCell {
@private
    FLCircleView* _circle;
    UIImageView* _check;
    BOOL _checked;
}

@property (readwrite, assign, nonatomic, getter=isChecked) BOOL checked;

+ (id) onOffCheckMarkTableViewCell:(NSString*) labelOrNil;

@end