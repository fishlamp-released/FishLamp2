//
//	FLPickerViewCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLPickerViewCell.h"


@implementation FLPickerViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]))
	{
		_pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
		[self addSubview:_pickerView];
	}
	
	return self;
}

- (void) dealloc
{
	FLRelease(_pickerView);
	FLSuperDealloc();
}

- (UIPickerView*) pickerView
{
	return _pickerView;
}

- (CGFloat) cellHeight
{
	return _pickerView.frame.size.height;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	_pickerView.frame = FLRectSetWidth(_pickerView.frame, self.bounds.size.width);
}

@end
