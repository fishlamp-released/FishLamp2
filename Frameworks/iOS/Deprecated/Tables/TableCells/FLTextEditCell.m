//
//	FLTextEditCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/15/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLTextEditCell.h"
#import "FLGeometry.h"

#import "FLTableViewSection.h"

@interface FLTextEditCell (Private)
- (void) hideHelpText;
- (void) showHelpText;
- (BOOL) wantsHelpText;
@end

@implementation FLTextEditCell

@synthesize textEditingCellDelegate = _textEditingCellDelegate;
//@synthesize nextRowToEdit = _nextRowToEdit;
//@synthesize prevRowToEdit = _prevRowToEdit;
@synthesize maxLength = _maxLength;

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
	FLRelease(_warningIcon);
	FLRelease(_warningLabel);
	FLRelease(_helpTextLabel);
	FLRelease(_countDownLabel);
	super_dealloc_();
}

- (void) clear
{
}

- (void) beginEditing
{
}

- (void) hideHelpText
{
	if(_helpTextLabel)
	{
		[_helpTextLabel removeFromSuperview];
		FLReleaseWithNil_(_helpTextLabel);
	}
}

- (void) showHelpText
{
	NSString* helpText = self.helpText;
	if(FLStringIsNotEmpty(self.helpText) && self.valueLabelText.length == 0)
	{	
		if(!_helpTextLabel)
		{
			_helpTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
			_helpTextLabel.contentMode = UIViewContentModeTopLeft;
			_helpTextLabel.textColor = [UIColor lightGrayColor];
			_helpTextLabel.lineBreakMode = UILineBreakModeTailTruncation; 
			_helpTextLabel.textAlignment = UITextAlignmentLeft; 
			_helpTextLabel.backgroundColor = [UIColor clearColor];
			_helpTextLabel.adjustsFontSizeToFitWidth = YES;
			[self addSubview:_helpTextLabel];
			[self setNeedsLayout];
		}
		_helpTextLabel.text = helpText;
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
	if(self.dataSource && !FLStringsAreEqual(text, self.formattedDisplayString))
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
	if(!_countDownLabel)
	{
		_countDownLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 60, 12)];
		_countDownLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
		_countDownLabel.backgroundColor = [UIColor clearColor];
		_countDownLabel.textColor = [UIColor blackColor];
		_countDownLabel.textAlignment = UITextAlignmentRight;
		[self addSubview:_countDownLabel];
		
		[self setNeedsLayout];
	}
}

- (void) hideCountdownLabel
{
	if(_countDownLabel)
	{
		[_countDownLabel removeFromSuperview];
		FLReleaseWithNil_(_countDownLabel);
	}
}

- (NSInteger) remainingSize
{
	return _maxLength - self.valueLabelText.length;
}

- (void) showWarningIcon
{
//	  if( _maxLength > 0 &&
//		  !self.isEditing &&
//		  !_warningIcon && 
//		  self.remainingSize < 0)
//	  {
//		  _warningIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"warning-20.png"]];
//		  [_warningIcon resizeToImageSize]; 
//		  [self setNeedsLayout];
//		  
//		  [self addSubview:_warningIcon];
//		  [self setNeedsLayout];
//	  }
	
}

- (void) hideWarningIcon
{
//	  if(_warningIcon)
//	  {
//		  [_warningIcon removeFromSuperview];
//		  FLReleaseWithNil_(_warningIcon);
//	  }
}

#define Height 16
- (void) showWarningLabel
{
// TODO: add this back in.
//	  if(!_warningLabel)
//	  {
//		  NSInteger top = [[UIDevice currentDevice] statusBarHeight] + [[UIDevice currentDevice] navigationBarHeightPortrait] - 4;
//			 
//		  _warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, top, [FLWindow topWindow].bounds.size.width, Height)];
//		  _warningLabel.backgroundColor = [UIColor paleYellowColor];
//		  _warningLabel.textColor = [UIColor grayColor];
//		  _warningLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
//		  _warningLabel.text = @"Warning: your text is too long and will be truncated";
//		  _warningLabel.textAlignment = UITextAlignmentCenter;
//		  _warningLabel.alpha = 1.0;
//		  
//		  if(!_viewAnimator)
//		  {
//			  _viewAnimator = [[FLViewMover alloc] initWithStartPosition:FLAnimationPositionTop];
//		  }
//		  
//		  [_viewAnimator addSubview:_warningLabel
//				  superview:[FLWindow topWindow]];
//	  }
}

- (void) hideWarningLabel
{
//	  if(_warningLabel)
//	  {
//		  [_viewAnimator removeFromSuperview:_warningLabel];
//			  
//		  FLReleaseWithNil_(_warningLabel);
//	  }
}

- (void) updateCountdownLabel
{
	if(self.isEditing && _maxLength)
	{
		if(!_countDownLabel)
		{	
			[self showCountdownLabel];
		}

		if(self.remainingSize < 0)
		{
			_countDownLabel.textColor = [UIColor redColor];
			
//			  if(!_warningLabel)
//			  {
//				  [self showWarningLabel];
//			  }
//			  if(!_warningIcon)
//			  {
//				  [self showWarningIcon];
//			  }
		}
		else
		{
			_countDownLabel.textColor = [UIColor whiteColor];
			
//			  if(_warningLabel)
//			  {
//				  [self hideWarningLabel];
//			  }
//			  if(_warningIcon)
//			  {
//				  [self hideWarningIcon];
//			  }
		}
		
		_countDownLabel.text = [NSString stringWithFormat:@"%d", self.remainingSize];
	}
}      

- (void) positionCountdownView:(UILabel*) label
{
	CGRect r = FLRectJustifyRectInRectRight(self.bounds, label.frame);
	r.origin.y = 10;
	r.origin.x -= 18;
	label.frameOptimizedForSize = r;
}

- (FLTextEditCell*) nextCellToEdit
{
	return [_textEditingCellDelegate textEditCellGetNextEditableCell:self];
}

- (FLTextEditCell*) prevCellToEdit
{
	return [_textEditingCellDelegate textEditCellGetPreviousEditableCell:self];
}

- (void) onPrevious:(id) sender
{
	FLTextEditCell* prev = self.prevCellToEdit;
	if(prev)
	{
		[_textEditingCellDelegate textEditCellNeedsToBeginEditingText:prev];
	}
}

- (void) onNext:(id) sender
{
	FLTextEditCell* next = self.nextCellToEdit;
	if(next)
	{
		[_textEditingCellDelegate textEditCellNeedsToBeginEditingText:next];
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
 
	if(_countDownLabel)
	{
		[self positionCountdownView:_countDownLabel];
	}
	
	if(_helpTextLabel)
	{
		_helpTextLabel.font = self.valueLabel.font;
		[_helpTextLabel sizeToFitText];
		_helpTextLabel.frameOptimizedForSize = FLRectSetOrigin(_helpTextLabel.frame, self.valueLabel.view.frame.origin.x + 2, self.valueLabel.view.frame.origin.y);
	}
	
//	  if(_warningIcon)
//	  {
//		  CGRect rect = _warningIcon.frame;
//		  rect = FLRectJustifyRectInRectRight(self.bounds, rect);
//		  rect.origin.y = 10;
//		  rect.origin.x -= 10;
//		  _warningIcon.frameOptimizedForSize = rect;
//	  }
}

@end
