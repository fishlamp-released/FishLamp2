//
//	GtItemCountCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 8/17/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtItemCountCell.h"


@implementation GtItemCountCell

@synthesize count = m_count;
@synthesize total = m_total;
@synthesize itemCountCellDelegate = m_itemCountDelegate;
@synthesize bottomLabel = m_bottomLabel;

@synthesize itemName = m_itemName;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if ((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])) 
	{	
		self.showsReorderControl = NO;
		self.shouldIndentWhileEditing = NO;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.accessoryType = UITableViewCellAccessoryNone;
	 
		m_label = [[UILabel alloc] initWithFrame:CGRectZero];
		m_label.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
		m_label.lineBreakMode = UILineBreakModeTailTruncation;
		m_label.textColor = [UIColor grayColor];
		m_label.textAlignment = UITextAlignmentCenter;
		m_label.backgroundColor = [UIColor clearColor];
		
		m_bottomLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		m_bottomLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
		m_bottomLabel.lineBreakMode = UILineBreakModeTailTruncation;
		m_bottomLabel.textColor = [UIColor grayColor];
		m_bottomLabel.textAlignment = UITextAlignmentCenter;
		m_bottomLabel.backgroundColor = [UIColor clearColor];
		
//		  self.cellHeight = GtItemCountCellHeight;
		
		[self.contentView addSubview:m_label];
		[self.contentView addSubview:m_bottomLabel];
		
		self.backgroundColor = [UIColor clearColor];
		self.contentView.backgroundColor = [UIColor clearColor];
	}
	
	return self;
}

- (void) setTextColor:(UIColor*) textColor shadowTextColor:(UIColor*) shadowColor
{
	m_label.textColor = textColor;
	m_bottomLabel.textColor = textColor;
	
	m_label.shadowColor = shadowColor;
	m_bottomLabel.shadowColor = shadowColor;
}

- (BOOL) isSpinning
{
	return m_spinner && m_spinner.isAnimating;
}

- (void) dealloc
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];
	GtReleaseWithNil(m_itemName);
	GtReleaseWithNil(m_label);
	GtReleaseWithNil(m_spinner);
	GtReleaseWithNil(m_bottomLabel);
	
	GtSuperDealloc();
}

- (void) updateText
{
	if(GtStringIsNotEmpty(self.itemName))
	{
		if(self.count < self.total)
		{
			m_label.text = [NSString stringWithFormat:(NSLocalizedString(@"%d of %d %@", nil)), self.count, self.total, self.itemName];
		}
		else
		{
			m_label.text = [NSString stringWithFormat:(NSLocalizedString(@"%d %@", nil)), self.total, self.itemName];
		}
	}
}

- (void) setCount:(NSInteger) count
{
	if(m_count != count)
	{
		m_count = count;
		[self updateText];
	}
}

- (void) setTotal:(NSInteger) total
{
	if(m_total != total)
	{
		m_total = total;
		[self updateText];
	}
}

- (void) setItemName:(NSString*) itemName
{
	if(GtAssignObject(m_itemName, itemName))
	{
		[self updateText];
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	[self updateText];
	
	m_label.frame = GtRectSetOrigin(m_label.frame, 0,10);
	m_label.frame = GtRectSetSize(m_label.frame, self.contentView.bounds.size.width, 20);
	m_bottomLabel.frame = GtRectSetSize(m_bottomLabel.frame, self.contentView.bounds.size.width, 18);
	
 //	  m_label.frame = GtRectCenterRectInRect(self.contentView.frame, m_label.frame);
 //	  m_bottomLabel.frame = GtRectCenterRectInRectHorizontally(self.contentView.frame, m_bottomLabel.frame);
	m_bottomLabel.frame = GtRectAlignRectVertically(m_label.frame, m_bottomLabel.frame);
	 
	if(m_spinner)
	{
		m_spinner.frame = GtRectCenterRectInRect(m_bottomLabel.frame, m_spinner.frame);
	}
}

- (void) checkState:(id) state
{
	if(m_spinner && m_spinner.isAnimating && self.superview)
	{
		[m_itemCountDelegate itemCountCellNeedsLoading:self];
		[self performSelector:@selector(checkState:) withObject:nil afterDelay:1.0];
	}
}

- (void) startSpinner
{
	if(!m_spinner)
	{
		m_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[m_spinner startAnimating];
		[self.contentView addSubview:m_spinner];
		[self setNeedsLayout];
		if(m_itemCountDelegate)
		{
			[self performSelector:@selector(checkState:) withObject:nil afterDelay:1.0];
		}
	}
}

- (void) stopSpinner
{
	[m_spinner removeFromSuperview];
	GtReleaseWithNil(m_spinner);
}

@end
