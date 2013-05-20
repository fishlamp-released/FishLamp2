//
//	GtPickerViewCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPickerViewCell.h"


@implementation GtPickerViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]))
	{
		m_pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
		[self addSubview:m_pickerView];
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_pickerView);
	GtSuperDealloc();
}

- (UIPickerView*) pickerView
{
	return m_pickerView;
}

- (CGFloat) cellHeight
{
	return m_pickerView.frame.size.height;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	m_pickerView.frame = GtRectSetWidth(m_pickerView.frame, self.bounds.size.width);
}

@end
