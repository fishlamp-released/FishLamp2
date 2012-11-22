//
//	FLItemCountCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/17/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLItemCountCell.h"


@implementation FLItemCountCell

@synthesize count = _count;
@synthesize total = _total;
@synthesize itemCountCellDelegate = _itemCountDelegate;
@synthesize bottomLabel = _bottomLabel;

@synthesize actionItemName = _itemName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) 
	{	
		self.showsReorderControl = NO;
		self.shouldIndentWhileEditing = NO;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.accessoryType = UITableViewCellAccessoryNone;
	 
		_label = [[UILabel alloc] initWithFrame:CGRectZero];
		_label.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
		_label.lineBreakMode = UILineBreakModeTailTruncation;
		_label.textColor = [UIColor grayColor];
		_label.textAlignment = UITextAlignmentCenter;
		_label.backgroundColor = [UIColor clearColor];
		
		_bottomLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_bottomLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
		_bottomLabel.lineBreakMode = UILineBreakModeTailTruncation;
		_bottomLabel.textColor = [UIColor grayColor];
		_bottomLabel.textAlignment = UITextAlignmentCenter;
		_bottomLabel.backgroundColor = [UIColor clearColor];
		
//		  self.cellHeight = FLItemCountCellHeight;
		
		[self.contentView addSubview:_label];
		[self.contentView addSubview:_bottomLabel];
		
		self.backgroundColor = [UIColor clearColor];
		self.contentView.backgroundColor = [UIColor clearColor];
	}
	
	return self;
}

- (void) setTextColor:(UIColor*) textColor shadowTextColor:(UIColor*) shadowColor
{
	_label.textColor = textColor;
	_bottomLabel.textColor = textColor;
	
	_label.shadowColor = shadowColor;
	_bottomLabel.shadowColor = shadowColor;
}

- (BOOL) isSpinning
{
	return _spinner && _spinner.isAnimating;
}

- (void) dealloc
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	FLReleaseWithNil_(_itemName);
	FLReleaseWithNil_(_label);
	FLReleaseWithNil_(_spinner);
	FLReleaseWithNil_(_bottomLabel);
	
	super_dealloc_();
}

- (void) updateText
{
	if(FLStringIsNotEmpty(self.actionItemName))
	{
		if(self.count < self.total)
		{
			_label.text = [NSString stringWithFormat:(NSLocalizedString(@"%d of %d %@", nil)), self.count, self.total, self.actionItemName];
		}
		else
		{
			_label.text = [NSString stringWithFormat:(NSLocalizedString(@"%d %@", nil)), self.total, self.actionItemName];
		}
	}
}

- (void) setCount:(NSInteger) count
{
	if(_count != count)
	{
		_count = count;
		[self updateText];
	}
}

- (void) setTotal:(NSInteger) total
{
	if(_total != total)
	{
		_total = total;
		[self updateText];
	}
}

- (void) setItemName:(NSString*) actionItemName
{
    if(!FLStringsAreEqual(actionItemName, _itemName))
	{
        FLRetainObject_(_itemName, actionItemName);
		[self updateText];
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	[self updateText];
	
	_label.frame = FLRectSetOrigin(_label.frame, 0,10);
	_label.frame = FLRectSetSize(_label.frame, self.contentView.bounds.size.width, 20);
	_bottomLabel.frame = FLRectSetSize(_bottomLabel.frame, self.contentView.bounds.size.width, 18);
	
 //	  _label.frame = FLRectCenterRectInRect(self.contentView.frame, _label.frame);
 //	  _bottomLabel.frame = FLRectCenterRectInRectHorizontally(self.contentView.frame, _bottomLabel.frame);
	_bottomLabel.frame = FLRectAlignRectVertically(_label.frame, _bottomLabel.frame);
	 
	if(_spinner)
	{
		_spinner.frame = FLRectCenterRectInRect(_bottomLabel.frame, _spinner.frame);
	}
}

- (void) checkState:(id) state
{
	if(_spinner && _spinner.isAnimating && self.superview)
	{
		[_itemCountDelegate itemCountCellNeedsLoading:self];
		[self performSelector:@selector(checkState:) withObject:nil afterDelay:1.0];
	}
}

- (void) startSpinner
{
	if(!_spinner)
	{
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[_spinner startAnimating];
		[self.contentView addSubview:_spinner];
		[self setNeedsLayout];
		if(_itemCountDelegate)
		{
			[self performSelector:@selector(checkState:) withObject:nil afterDelay:1.0];
		}
	}
}

- (void) stopSpinner
{
	[_spinner removeFromSuperview];
	FLReleaseWithNil_(_spinner);
}

@end
