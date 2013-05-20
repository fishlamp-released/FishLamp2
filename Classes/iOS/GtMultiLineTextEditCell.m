//
//	GtMultiLineTextEditCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMultiLineTextEditCell.h"

#import "GtGeometry.h"

#define MULTILINE_HEIGHT 60.0
//#define SPACE_BETWEEN_LABEL_AND_TEXT 0.0

@implementation GtMultiLineTextEditCell

@synthesize textInputTraits = m_traits;
@synthesize	numberOfLines = m_numberOfLines;
@synthesize resizeOnEdit = m_resizeOnEdit;
@synthesize disallowReturnKey = m_disallowReturnKey;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		m_resizeOnEdit = YES;
	}
	
	return self;
}

+ (GtMultiLineTextEditCell*) multiLineTextEditCell:(NSString*) titleLabelOrNil
{
	GtMultiLineTextEditCell* cell = GtReturnAutoreleased([[GtMultiLineTextEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GtMultiLineTextEditCell"]);
	if(GtStringIsNotEmpty(titleLabelOrNil))
	{
		cell.textLabelText = titleLabelOrNil;
	}
	return cell;
}

- (GtTextView*) textView
{
	return m_textView;
}

- (void) allowResponderToResign
{
	self.textView.canResignFirstResponder = YES;
}

#define INSET_VALUE -8
- (NSString*) valueLabelText
{
	return m_textView ? m_textView.text : [super valueLabelText];
}

- (CGRect) _rectForTextView
{
	CGRect layoutRect = self.layoutRect;
	CGFloat newTop = GtRectGetBottom(self.label.frame);
	layoutRect.size.height -= (newTop - layoutRect.origin.y);
	layoutRect.origin.y = newTop;
	layoutRect = GtRectGrowRectToOptimizedSizeIfNeeded(layoutRect);
	
	return layoutRect;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(m_textView )
	{	
		CGRect layoutRect = [self _rectForTextView];
		if(!CGRectEqualToRect(m_textView.frame, layoutRect))
		{
			m_textView.frame = layoutRect;
		}
	}
}


- (void) createTextView
{
	NSString* startText = self.valueLabelText;
	
	GtAssertNil(m_textView);
	
	m_textView = [[GtTextView alloc] initWithFrame:[self _rectForTextView]];
	m_textView.autoresizingMask = UIViewAutoresizingNone;
	m_textView.showsVerticalScrollIndicator = YES;
	m_textView.scrollEnabled = YES;
	m_textView.backgroundColor = [UIColor clearColor];
	m_textView.font = self.valueLabel.font;
	m_textView.textColor = self.valueLabel.textColor;
	m_textView.useEnforcedEdgeInsets = YES;
	m_textView.enforcedEdgeInsets = UIEdgeInsetsMake(INSET_VALUE,INSET_VALUE,ABS(INSET_VALUE),ABS(INSET_VALUE));
	m_textView.themeAction = @selector(applyThemeToTableViewCellTextView:); 
	[m_textView applyTheme];
	m_textView.delegate = self;
	m_textView.returnKeyType = UIReturnKeyDefault;
	if(m_traits)
	{	
		[m_traits copyTextInputTraitsToControl:m_textView];
	}

	[self addSubview:m_textView];

	[m_textView setText:[startText trimmedString]];
		
	[m_textView becomeFirstResponder];
	m_textView.canResignFirstResponder = NO;
	[self updateCountdownLabel];
	[self setNeedsLayout];
}

- (void) clear
{
	self.valueLabelText = @"";
	if(m_textView)
	{
		m_textView.text = @"";
	}
}

- (GtTextInputTraits*) textInputTraits
{
	if(!m_traits)
	{
		m_traits = [[GtTextInputTraits alloc] init];
	}
	
	return m_traits;
}

- (void)textViewDidChange:(UITextView *)textView
{
    NSString* text = textView.text;
    if(self.disallowReturnKey && text.length && [text characterAtIndex:text.length - 1] == '\n')
    {
        text = [text substringToIndex:text.length - 1];
        textView.text = text;
        
        if(self.nextCellToEdit)
        {
            [self onNext:nil];
        }
        else
        {
            if(self.textEditingCellDelegate)
            {
                [self.textEditingCellDelegate textEditCellDidEndEditingText:self withDoneButtonPress:YES];
            }
        }
    }
    else if(self.maxLength && (text.length > self.maxLength))
    {
        text = [text substringToIndex:self.maxLength];
        textView.text = text;
    }
    
    self.valueLabelText = text;
}

- (void) beginEditing
{
	[super beginEditing];
	if(!self.disabled)
	{
		[self.valueLabel.view removeFromSuperview];
		[self createTextView];
		[self setNeedsLayout];
	}
}

- (void) removeTextEditCell
{
	if(m_textView)
	{
		m_textView.delegate = nil;
	
		m_textView.canResignFirstResponder = YES;
		[m_textView resignFirstResponder];
		[m_textView removeFromSuperview];
		
		GtAutorelease(m_textView);
		m_textView = nil;
		
		[self addSubview:self.valueLabel.view];
	}
}

- (void) endEditing
{
	[super endEditing];
	
	[self removeTextEditCell];
}

- (void) dealloc
{
	GtRelease(m_traits);
	GtRelease(m_textView);
	GtSuperDealloc();
}

- (BOOL) isEditing
{
	return m_textView != nil;
}	

- (BOOL)textViewShouldBeginEditing:(UITextView *)textField
{
	BOOL willStartEditing = self.canEditData;
	
	if(OSVersionIsAtLeast3_2() && willStartEditing)
	{
		m_textView.inputAccessoryView = 
			[self.textEditingCellDelegate textEditCellGetInputAccessoryView:self];
	}
	
	return willStartEditing;
}

- (void)textViewDidBeginEditing:(UITextView *)textField
{
	[super textDidBeginEditing];
}

- (void)textViewDidEndEditing:(UITextView *)textField
{
	[super textDidEndEditing:textField.text];
	
	[self removeTextEditCell];
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
	return m_textView.canResignFirstResponder;
}

- (void) updateCellState
{
	[super updateCellState];
	m_textView.editable = !self.disabled;
}

- (CGSize) valueTextSizeForContentViewWidth:(CGFloat) width
{
	if(m_numberOfLines)
	{
		CGSize size = [@"Ty" sizeWithFont:self.valueLabel.font
							constrainedToSize:CGSizeMake(width,CGFLOAT_MAX)
							lineBreakMode:self.valueLabel.lineBreakMode];
		size.height += 2;
		size.height *= m_numberOfLines;
		return size;
	}
	else
	{
		return [super valueTextSizeForContentViewWidth:width];
	}
}

- (void) calculateCellHeightInTable:(UITableView *)tableView
{
	if([GtTextEditCell inGlobalEditingMode] && m_resizeOnEdit)
	{
		self.cellHeight = GT_EDITING_ROW_HEIGHT;
	}
	else
	{
		[super calculateCellHeightInTable:tableView];
	}
	
}

//- (CGFloat) cellHeight
//{
//	if([GtTextEditCell inGlobalEditingMode])
//	  {
//		return GT_EDITING_ROW_HEIGHT;
//	  }
//
//	  return [super cellHeight];
//}

@end

