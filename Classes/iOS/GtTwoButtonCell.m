//
//	GtTwoButtonCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/19/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTwoButtonCell.h"
#import "GtCallbackObject.h"
#import "GtGeometry.h"

@implementation GtTwoButtonCell

@synthesize leftButton = m_leftButton;
@synthesize rightButton = m_rightButton;

- (void) setLeftButton:(GtButton*) leftButton
{
	if(m_leftButton)
	{
		[m_leftButton removeFromSuperview];
		GtReleaseWithNil(m_leftButton);
	}
	
	m_leftButton = GtRetain(leftButton);
	[self addSubview:m_leftButton];
	[self setNeedsLayout];
}

- (void) setRightButton:(GtButton*) rightButton
{
	if(m_rightButton)
	{
		[m_rightButton removeFromSuperview];
		GtReleaseWithNil(m_rightButton);
	}
	
	m_rightButton = GtRetain(rightButton);
	[self addSubview:m_rightButton];
	[self setNeedsLayout];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.cellHeight = 50.0f;
	}
	return self;
}

- (void) enabledStateDidChange
{
	m_leftButton.enabled = self.canEditData;
	m_rightButton.enabled = self.canEditData;
	[super enabledStateDidChange];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
 
	CGRect layoutRect = self.layoutRect;

	if(!GtBitMaskTest(self.sectionWidget.drawMode,GtTableViewCellSectionDrawModeBorder))
	{
		layoutRect = CGRectInset(layoutRect, 10, 0);
	}

	CGRect buttonFrame = GtRectSetWidth(m_leftButton ? m_leftButton.frame : m_rightButton.frame, (layoutRect.size.width / 2.0f) - (DeviceIsPad() ? 20.0f : 10.0f));
	
	if(m_leftButton)
	{
		m_leftButton.newFrame = GtRectJustifyRectInRectLeft(layoutRect, buttonFrame);
	}
	if(m_rightButton)
	{
		m_rightButton.newFrame = GtRectJustifyRectInRectRight(layoutRect, buttonFrame);
	}
}
- (void)dealloc 
{
	GtRelease(m_leftButton);
	GtRelease(m_rightButton);	
	GtSuperDealloc();
}

+ (GtTwoButtonCell*) twoButtonCell
{
	return GtReturnAutoreleased([[GtTwoButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GtTwoButtonCell"]);
}	

+ (GtTwoButtonCell*) twoButtonCell:(GtButton*) leftButton
	rightButton:(GtButton*) rightButton
{
	GtTwoButtonCell* cell = [GtTwoButtonCell twoButtonCell];
	if(leftButton)
	{
		cell.leftButton = leftButton;
	}
	if(rightButton)
	{
		cell.rightButton = rightButton;
	}
	return cell;
}

@end
