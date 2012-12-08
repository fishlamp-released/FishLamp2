//
//	FLMultiLineTextEditCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLMultiLineTextEditCell.h"

#import "FLGeometry.h"
#import "FLStringUtils.h"

#define MULTILINE_HEIGHT 60.0
//#define SPACE_BETWEEN_LABEL_AND_TEXT 0.0

@implementation FLMultiLineTextEditCell

@synthesize textInputTraits = _traits;
@synthesize	numberOfLines = _numberOfLines;
@synthesize resizeOnEdit = _resizeOnEdit;
@synthesize disallowReturnKey = _disallowReturnKey;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
        self.wantsApplyTheme = YES;
        _resizeOnEdit = YES;
	}
	
	return self;
}

+ (FLMultiLineTextEditCell*) multiLineTextEditCell:(NSString*) titleLabelOrNil
{
	FLMultiLineTextEditCell* cell = FLAutorelease([[FLMultiLineTextEditCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FLMultiLineTextEditCell"]);
	if(FLStringIsNotEmpty(titleLabelOrNil))
	{
		cell.textLabelText = titleLabelOrNil;
	}
	return cell;
}

- (FLTextView*) textView
{
	return _textView;
}

- (void) allowResponderToResign
{
	self.textView.canResignFirstResponder = YES;
}

#define INSET_VALUE -8
- (NSString*) valueLabelText
{
	return _textView ? _textView.text : [super valueLabelText];
}

- (CGRect) _rectForTextView
{
	CGRect layoutRect = self.layoutRect;
	CGFloat newTop = FLRectGetBottom(self.label.frame);
	layoutRect.size.height -= (newTop - layoutRect.origin.y);
	layoutRect.origin.y = newTop;
	layoutRect = FLRectOptimizedForViewSize(layoutRect);
	
	return layoutRect;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(_textView )
	{	
		CGRect layoutRect = [self _rectForTextView];
		if(!CGRectEqualToRect(_textView.frame, layoutRect))
		{
			_textView.frame = layoutRect;
		}
	}
}
- (void) applyTheme:(FLTheme*) theme {
//	self.textDescriptor = self.valueDescriptor;
}


- (void) createTextView
{
	NSString* startText = self.valueLabelText;
	
	FLAssertIsNil_(_textView);
	
	_textView = [[FLTextView alloc] initWithFrame:[self _rectForTextView]];
	_textView.autoresizingMask = UIViewAutoresizingNone;
	_textView.showsVerticalScrollIndicator = YES;
	_textView.scrollEnabled = YES;
	_textView.backgroundColor = [UIColor clearColor];
	_textView.font = self.valueLabel.font;
	_textView.textColor = self.valueLabel.textColor;
	_textView.useEnforcedEdgeInsets = YES;
	_textView.enforcedEdgeInsets = UIEdgeInsetsMake(INSET_VALUE,INSET_VALUE,ABS(INSET_VALUE),ABS(INSET_VALUE));
	[_textView applyThemeIfNeeded];
	_textView.delegate = self;
	_textView.returnKeyType = UIReturnKeyDefault;
	if(_traits)
	{	
		[_traits copyTextInputTraitsToControl:_textView];
	}

	[self addSubview:_textView];

	[_textView setText:[startText trimmedString]];
		
	[_textView becomeFirstResponder];
	_textView.canResignFirstResponder = NO;
	[self updateCountdownLabel];
	[self setNeedsLayout];
}

- (void) clear
{
	self.valueLabelText = @"";
	if(_textView)
	{
		_textView.text = @"";
	}
}

- (FLTextInputTraits*) textInputTraits
{
	if(!_traits)
	{
		_traits = [[FLTextInputTraits alloc] init];
	}
	
	return _traits;
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
	if(_textView)
	{
		_textView.delegate = nil;
	
		_textView.canResignFirstResponder = YES;
		[_textView resignFirstResponder];
		[_textView removeFromSuperview];
		
		mrc_autorelease_(_textView);
		_textView = nil;
		
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
	FLRelease(_traits);
	FLRelease(_textView);
	super_dealloc_();
}

- (BOOL) isEditing
{
	return _textView != nil;
}	

- (BOOL)textViewShouldBeginEditing:(UITextView *)textField
{
	BOOL willStartEditing = self.canEditData;
	
	if(willStartEditing)
	{
		_textView.inputAccessoryView = 
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
	return _textView.canResignFirstResponder;
}

- (void) updateCellState
{
	[super updateCellState];
	_textView.editable = !self.disabled;
}

- (CGSize) valueTextSizeForContentViewWidth:(CGFloat) width
{
	if(_numberOfLines)
	{
		CGSize size = [@"Ty" sizeWithFont:self.valueLabel.font
							constrainedToSize:FLSizeMake(width,CGFLOAT_MAX)
							lineBreakMode:self.valueLabel.lineBreakMode];
		size.height += 2;
		size.height *= _numberOfLines;
		return size;
	}
	else
	{
		return [super valueTextSizeForContentViewWidth:width];
	}
}

- (void) calculateCellHeightInTable:(UITableView *)tableView
{
	if([FLTextEditCell inGlobalEditingMode] && _resizeOnEdit)
	{
		self.cellHeight = FL_EDITING_ROW_HEIGHT;
	}
	else
	{
		[super calculateCellHeightInTable:tableView];
	}
	
}

//- (CGFloat) cellHeight
//{
//	if([FLTextEditCell inGlobalEditingMode])
//	  {
//		return FL_EDITING_ROW_HEIGHT;
//	  }
//
//	  return [super cellHeight];
//}

@end

