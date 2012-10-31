//
//	FLButtonCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/14/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLButtonCell.h"


@implementation FLButtonCell

@synthesize button = _button;
@synthesize buttonMode = _mode;

- (id) initWithButton:(FLLegacyButton*) button buttonMode :(FLButtonCellButtonMode) buttonMode
{
	if((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FLButtonCell"]))
	{
		self.button = button;
		_mode = buttonMode;
		self.cellHeight = FLButtonCellDefaultCellHeight;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.backgroundColor = [UIColor clearColor];
		self.backgroundColor = [UIColor clearColor];
		
		self.sectionWidget.drawMode = FLTableViewCellSectionDrawModeNone;
	}
	
	return self;
}

- (void) setButton:(FLLegacyButton*) button
{
	if(_button)
	{
		[_button removeFromSuperview];
		FLReleaseWithNil_(_button);
	}
	
	_button = retain_(button);
	[self addSubview:_button];
}

- (void) enabledStateDidChange
{
	self.button.enabled = self.canEditData;
	[super enabledStateDidChange];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	FLRect layoutRect = self.layoutRect;

	switch(_mode)
	{
		case FLButtonCellButtonModeCenter:
			[self.button setViewSizeToContentSize];
			self.button.frameOptimizedForSize = FLRectCenterRectInRect(layoutRect, self.button.frame);
		break;
		
		case FLButtonCellButtonModeFill:
			if(FLTestBits(self.sectionWidget.drawMode, FLTableViewCellSectionDrawModeBorder))
			{
				self.button.frameOptimizedForSize = 
					FLRectCenterRectInRect(layoutRect,
						FLRectSetWidth(_button.frame, layoutRect.size.width - 20 ));
			}
			else
			{
				self.button.frameOptimizedForSize = 
					FLRectCenterRectInRect(layoutRect,
						FLRectSetWidth(_button.frame, layoutRect.size.width));
			}		 
		break;
	}
	

}

- (void) dealloc
{
	mrc_release_(_button);
	mrc_super_dealloc_();
}

+ (FLButtonCell*) buttonCell:(FLLegacyButton*) button buttonMode :(FLButtonCellButtonMode) buttonMode
{
	return autorelease_([[FLButtonCell alloc] initWithButton:button buttonMode:buttonMode]);
}

@end
