//
//	FLTwoButtonCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/19/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLTwoButtonCell.h"
#import "FLCallbackObject.h"
#import "FLGeometry.h"

@implementation FLTwoButtonCell

@synthesize leftButton = _leftButton;
@synthesize rightButton = _rightButton;

- (void) setLeftButton:(FLLegacyButton*) leftButton
{
	if(_leftButton)
	{
		[_leftButton removeFromSuperview];
		FLReleaseWithNil(_leftButton);
	}
	
	_leftButton = FLRetain(leftButton);
	[self addSubview:_leftButton];
	[self setNeedsLayout];
}

- (void) setRightButton:(FLLegacyButton*) rightButton
{
	if(_rightButton)
	{
		[_rightButton removeFromSuperview];
		FLReleaseWithNil(_rightButton);
	}
	
	_rightButton = FLRetain(rightButton);
	[self addSubview:_rightButton];
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
	_leftButton.enabled = self.canEditData;
	_rightButton.enabled = self.canEditData;
	[super enabledStateDidChange];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
 
	CGRect layoutRect = self.layoutRect;

	if(!FLTestBits(self.sectionWidget.drawMode,FLTableViewCellSectionDrawModeBorder))
	{
		layoutRect = CGRectInset(layoutRect, 10, 0);
	}

	CGRect buttonFrame = FLRectSetWidth(_leftButton ? _leftButton.frame : _rightButton.frame, (layoutRect.size.width / 2.0f) - (DeviceIsPad() ? 20.0f : 10.0f));
	
	if(_leftButton)
	{
		_leftButton.newFrame = FLRectJustifyRectInRectLeft(layoutRect, buttonFrame);
	}
	if(_rightButton)
	{
		_rightButton.newFrame = FLRectJustifyRectInRectRight(layoutRect, buttonFrame);
	}
}
- (void)dealloc 
{
	FLRelease(_leftButton);
	FLRelease(_rightButton);	
	super_dealloc_();
}

+ (FLTwoButtonCell*) twoButtonCell
{
	return FLAutorelease([[FLTwoButtonCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FLTwoButtonCell"]);
}	

+ (FLTwoButtonCell*) twoButtonCell:(FLLegacyButton*) leftButton
	rightButton:(FLLegacyButton*) rightButton
{
	FLTwoButtonCell* cell = [FLTwoButtonCell twoButtonCell];
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
