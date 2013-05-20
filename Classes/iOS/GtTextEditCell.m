//
//	GtTextEditCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTextEditCell.h"
#import "GtGeometry.h"

#import "GtTableViewSection.h"

@interface GtTextEditCell (Private)
- (void) hideHelpText;
- (void) showHelpText;
- (BOOL) wantsHelpText;
@end

@implementation GtTextEditCell

@synthesize textEditingCellDelegate = m_textEditingCellDelegate;
//@synthesize nextRowToEdit = m_nextRowToEdit;
//@synthesize prevRowToEdit = m_prevRowToEdit;
@synthesize maxLength = m_maxLength;

static BOOL s_editingMode;

+ (void) setGlobalEditingMode:(BOOL) canStop
{
	s_editingMode = canStop;
}

+ (BOOL) inGlobalEditingMode
{
	return s_editingMode;
}

- (BOOL) isEditing
{
	return NO;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.accessoryType = UITableViewCellAccessoryNone;
    }
	
	return self;
}

- (void) setSelectionStyle:(UITableViewCellSelectionStyle) style
{
	[super setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void) dealloc
{
	[self hideWarningLabel];
	GtRelease(m_warningIcon);
	GtRelease(m_warningLabel);
	GtRelease(m_helpTextLabel);
	GtRelease(m_countDownLabel);
	GtSuperDealloc();
}

- (void) clear
{
}

- (void) beginEditing
{
}

- (void) hideHelpText
{
	if(m_helpTextLabel)
	{
		[m_helpTextLabel removeFromSuperview];
		GtReleaseWithNil(m_helpTextLabel);
	}
}

- (void) showHelpText
{
	NSString* helpText = self.helpText;
	if(GtStringIsNotEmpty(self.helpText) && self.valueLabelText.length == 0)
	{	
		if(!m_helpTextLabel)
		{
			m_helpTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			m_helpTextLabel.contentMode = UIViewContentModeTopLeft;
			m_helpTextLabel.textColor = [UIColor lightGrayColor];
			m_helpTextLabel.lineBreakMode = UILineBreakModeTailTruncation; 
			m_helpTextLabel.textAlignment = UITextAlignmentLeft; 
			m_helpTextLabel.backgroundColor = [UIColor clearColor];
			m_helpTextLabel.adjustsFontSizeToFitWidth = YES;
			[self addSubview:m_helpTextLabel];
			[self setNeedsLayout];
		}
		m_helpTextLabel.text = helpText;
	}
	else
	{
		[self hideHelpText];
	}
}

- (void) allowResponderToResign
{
}

- (BOOL) updateText:(NSString*) text
{
	[super setValueLabelText:text];
	if(self.dataSource && !GtStringsAreEqual(text, self.formattedDisplayString))
	{
		self.formattedDisplayString = text;
		return YES;
	}
	
	return NO;
}

- (void) setValueLabelText:(NSString*) text
{
	[self updateText:text];
	[self showHelpText];
	[self showWarningIcon];
	[self updateCountdownLabel];
}

- (void) didStopEditing
{
	[self hideCountdownLabel];
	[self showHelpText];
	[self hideWarningLabel];
	[self showWarningIcon];
}

- (void) shutDownEditing
{
	[self didStopEditing];
}

- (void) endEditing
{
	[self shutDownEditing];
}

- (void) cancelEditing
{
	self.textEditingCellDelegate = nil;
	[self endEditing];
}

- (void)textDidBeginEditing
{
	[self.textEditingCellDelegate textEditCellDidBeginEditingText:self];
	[self updateCountdownLabel];
	[self hideWarningIcon];
}

- (void)textDidEndEditing:(NSString*) text
{
	[self updateText:text];
	[self shutDownEditing];
}

- (void) showCountdownLabel
{
	if(!m_countDownLabel)
	{
		m_countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 60, 12)];
		m_countDownLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
		m_countDownLabel.backgroundColor = [UIColor clearColor];
		m_countDownLabel.textColor = [UIColor blackColor];
		m_countDownLabel.textAlignment = UITextAlignmentRight;
		[self addSubview:m_countDownLabel];
		
		[self setNeedsLayout];
	}
}

- (void) hideCountdownLabel
{
	if(m_countDownLabel)
	{
		[m_countDownLabel removeFromSuperview];
		GtReleaseWithNil(m_countDownLabel);
	}
}

- (NSInteger) remainingSize
{
	return m_maxLength - self.valueLabelText.length;
}

- (void) showWarningIcon
{
//	  if( m_maxLength > 0 &&
//		  !self.isEditing &&
//		  !m_warningIcon && 
//		  self.remainingSize < 0)
//	  {
//		  m_warningIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"warning-20.png"]];
//		  [m_warningIcon resizeToImageSize]; 
//		  [self setNeedsLayout];
//		  
//		  [self addSubview:m_warningIcon];
//		  [self setNeedsLayout];
//	  }
	
}

- (void) hideWarningIcon
{
//	  if(m_warningIcon)
//	  {
//		  [m_warningIcon removeFromSuperview];
//		  GtReleaseWithNil(m_warningIcon);
//	  }
}

#define Height 16
- (void) showWarningLabel
{
// TODO: add this back in.
//	  if(!m_warningLabel)
//	  {
//		  NSInteger top = [[UIDevice currentDevice] statusBarHeight] + [[UIDevice currentDevice] navigationBarHeightPortrait] - 4;
//			 
//		  m_warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, top, [GtWindow topWindow].bounds.size.width, Height)];
//		  m_warningLabel.backgroundColor = [UIColor paleYellowColor];
//		  m_warningLabel.textColor = [UIColor grayColor];
//		  m_warningLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
//		  m_warningLabel.text = @"Warning: your text is too long and will be truncated";
//		  m_warningLabel.textAlignment = UITextAlignmentCenter;
//		  m_warningLabel.alpha = 1.0;
//		  
//		  if(!m_viewAnimator)
//		  {
//			  m_viewAnimator = [[GtViewMover alloc] initWithStartPosition:GtAnimationPositionTop];
//		  }
//		  
//		  [m_viewAnimator addSubview:m_warningLabel
//				  superview:[GtWindow topWindow]];
//	  }
}

- (void) hideWarningLabel
{
//	  if(m_warningLabel)
//	  {
//		  [m_viewAnimator removeFromSuperview:m_warningLabel];
//			  
//		  GtReleaseWithNil(m_warningLabel);
//	  }
}

- (void) updateCountdownLabel
{
	if(self.isEditing && m_maxLength)
	{
		if(!m_countDownLabel)
		{	
			[self showCountdownLabel];
		}

		if(self.remainingSize < 0)
		{
			m_countDownLabel.textColor = [UIColor redColor];
			
//			  if(!m_warningLabel)
//			  {
//				  [self showWarningLabel];
//			  }
//			  if(!m_warningIcon)
//			  {
//				  [self showWarningIcon];
//			  }
		}
		else
		{
			m_countDownLabel.textColor = [UIColor whiteColor];
			
//			  if(m_warningLabel)
//			  {
//				  [self hideWarningLabel];
//			  }
//			  if(m_warningIcon)
//			  {
//				  [self hideWarningIcon];
//			  }
		}
		
		m_countDownLabel.text = [NSString stringWithFormat:@"%d", self.remainingSize];
	}
}      

- (void) positionCountdownView:(UILabel*) label
{
	CGRect r = GtRectJustifyRectInRectRight(self.bounds, label.frame);
	r.origin.y = 10;
	r.origin.x -= 18;
	label.frameOptimizedForSize = r;
}

- (GtTextEditCell*) nextCellToEdit
{
	return [m_textEditingCellDelegate textEditCellGetNextEditableCell:self];
}

- (GtTextEditCell*) prevCellToEdit
{
	return [m_textEditingCellDelegate textEditCellGetPreviousEditableCell:self];
}

- (void) onPrevious:(id) sender
{
	GtTextEditCell* prev = self.prevCellToEdit;
	if(prev)
	{
		[m_textEditingCellDelegate textEditCellNeedsToBeginEditingText:prev];
	}
}

- (void) onNext:(id) sender
{
	GtTextEditCell* next = self.nextCellToEdit;
	if(next)
	{
		[m_textEditingCellDelegate textEditCellNeedsToBeginEditingText:next];
	}
}

- (void) onStopEditing:(id) sender
{
	if(self.textEditingCellDelegate)
	{
		[self.textEditingCellDelegate textEditCellDidEndEditingText:self withDoneButtonPress:NO];
	}
}

- (void) updateCellState
{
	[super updateCellState];

	if(self.dataSource)
	{
		if(!self.maxLength)
		{
			self.maxLength = self.maxDataSize;
		}
		self.valueLabelText = self.formattedDisplayString;
	}
	
	[self showHelpText];
	[self showWarningIcon];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
 
	if(m_countDownLabel)
	{
		[self positionCountdownView:m_countDownLabel];
	}
	
	if(m_helpTextLabel)
	{
		m_helpTextLabel.font = self.valueLabel.font;
		[m_helpTextLabel sizeToFitText];
		m_helpTextLabel.frameOptimizedForSize = GtRectSetOrigin(m_helpTextLabel.frame, self.valueLabel.view.frame.origin.x + 2, self.valueLabel.view.frame.origin.y);
	}
	
//	  if(m_warningIcon)
//	  {
//		  CGRect rect = m_warningIcon.frame;
//		  rect = GtRectJustifyRectInRectRight(self.bounds, rect);
//		  rect.origin.y = 10;
//		  rect.origin.x -= 10;
//		  m_warningIcon.frameOptimizedForSize = rect;
//	  }
}

@end
