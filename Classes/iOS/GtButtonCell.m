//
//	GtButtonCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/14/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtButtonCell.h"


@implementation GtButtonCell

@synthesize button = m_button;
@synthesize buttonMode = m_mode;

- (id) initWithButton:(GtButton*) button buttonMode :(GtButtonCellButtonMode) buttonMode
{
	if((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GtButtonCell"]))
	{
		self.button = button;
		m_mode = buttonMode;
		self.cellHeight = GtButtonCellDefaultCellHeight;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.backgroundColor = [UIColor clearColor];
		self.backgroundColor = [UIColor clearColor];
		
		self.sectionWidget.drawMode = GtTableViewCellSectionDrawModeNone;
	}
	
	return self;
}

- (void) setButton:(GtButton*) button
{
	if(m_button)
	{
		[m_button removeFromSuperview];
		GtReleaseWithNil(m_button);
	}
	
	m_button = GtRetain(button);
	[self addSubview:m_button];
}

- (void) enabledStateDidChange
{
	self.button.enabled = self.canEditData;
	[super enabledStateDidChange];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	CGRect layoutRect = self.layoutRect;

	switch(m_mode)
	{
		case GtButtonCellButtonModeCenter:
			[self.button setViewSizeToContentSize];
			self.button.frameOptimizedForSize = GtRectCenterRectInRect(layoutRect, self.button.frame);
		break;
		
		case GtButtonCellButtonModeFill:
			if(GtBitMaskTest(self.sectionWidget.drawMode, GtTableViewCellSectionDrawModeBorder))
			{
				self.button.frameOptimizedForSize = 
					GtRectCenterRectInRect(layoutRect,
						GtRectSetWidth(m_button.frame, layoutRect.size.width - 20 ));
			}
			else
			{
				self.button.frameOptimizedForSize = 
					GtRectCenterRectInRect(layoutRect,
						GtRectSetWidth(m_button.frame, layoutRect.size.width));
			}		 
		break;
	}
	

}

- (void) dealloc
{
	GtRelease(m_button);
	GtSuperDealloc();
}

+ (GtButtonCell*) buttonCell:(GtButton*) button buttonMode :(GtButtonCellButtonMode) buttonMode
{
	return GtReturnAutoreleased([[GtButtonCell alloc] initWithButton:button buttonMode:buttonMode]);
}

@end
