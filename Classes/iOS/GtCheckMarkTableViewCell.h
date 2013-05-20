//
//	GtCheckMarkedTableCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtEditObjectTableViewCell.h"
#import "GtLabel.h"
@class GtCheckMarkGroup;

@interface GtCircleView : UIView {
@private    
    CGFloat m_borderWidth;
    UIColor* m_color;
}
@property (readwrite, assign, nonatomic) CGFloat borderWidth;
@property (readwrite, retain, nonatomic) UIColor* borderColor;

@end


@protocol GtCheckMarkTableCellDelegate;

@interface GtCheckMarkTableViewCell : GtEditObjectTableViewCell {
@private
	GtLabel* m_subLabel;
	id m_checkedValue;
	GtCheckMarkGroup* m_group;
	BOOL m_checked;
}
@property (readwrite, retain, nonatomic) GtCheckMarkGroup* checkMarkGroup;

@property (readwrite, retain, nonatomic) id checkedValue;

@property (readwrite, retain, nonatomic) NSString* subText;
@property (readwrite, assign, nonatomic) BOOL checked;

+ (id) checkMarkedTableCell:(NSString*) labelOrNil checked:(BOOL) checked checkedValue:(id) checkedValue;

@end

@protocol GtCheckMarkTableCellDelegate <NSObject>
- (void) checkMarkWasSelected:(GtCheckMarkTableViewCell*) cell;
@end

@interface GtOnOffCheckMarkTableViewCell : GtEditObjectTableViewCell {
@private
    GtCircleView* m_circle;
    UIImageView* m_check;
    BOOL m_checked;
}

@property (readwrite, assign, nonatomic, getter=isChecked) BOOL checked;

+ (id) onOffCheckMarkTableViewCell:(NSString*) labelOrNil;

@end