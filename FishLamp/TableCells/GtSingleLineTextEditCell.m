//
//  GtSingleLineTextEditCell.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/28/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtSingleLineTextEditCell.h"
#import "GtColors.h"
#import "GtGeometry.h"

@implementation MyTextField

- (void) setCanResignFirstResponder:(BOOL) canResign
{
    m_canResign = canResign;
}

- (BOOL) canResignFirstResponder
{
    return m_canResign;
}

@end


@implementation GtSingleLineTextEditCell

- (UITextField*) textField
{
	return m_textField;
}

- (NSString*) text
{
	return m_textField ? [m_textField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : m_valueText;
}
- (void) clear
{
	[m_textField setText: @""];
}

- (BOOL) isEditing
{
	return [m_textField isEditing];
}

- (void) tappedKey:(id) sender
{
    self.text = m_textField.text;

	[self updateCountdownLabel];
}

- (void) setText:(NSString*) text
{
    if(m_valueText != text)
    {
        GtRelease(m_valueText);
        m_valueText = [[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] retain];
    
        if(self.textInputTraits.secureTextEntry)
        {
            NSMutableString* string = [NSMutableString string];
            for(int i = 0; i < m_valueText.length; i++)
            {
                [string appendString:@"•"];
            }
        
            [super setText: string];
        }
        else
        {
            [super setText: text];
        }
    }
}

- (void) createTextView
{
    NSString* text = self.text;

	m_textField = [GtAlloc(MyTextField) initWithFrame:CGRectZero];
	m_textField.delegate = self;
	m_textField.clearButtonMode = UITextFieldViewModeWhileEditing;
	m_textField.backgroundColor = [UIColor clearColor];
    m_textField.canResignFirstResponder = NO;
    
	[m_textField setFont:[UIFont standardTextFieldFont]];
	[m_textField setTextColor:[UIColor standardTextFieldColor]];
	
    [m_textField addTarget:self action:@selector(tappedKey:) forControlEvents:UIControlEventEditingChanged];
	
	[self.contentView addSubview:m_textField];
	
	self.selectionStyle = UITableViewCellSelectionStyleNone;
	
	[m_textField setText:text];
	
	[self setTextInputTraitsForControl:m_textField];

    if(self.nextRowToEdit)
    {
        m_textField.returnKeyType = UIReturnKeyNext;
    }
    else
    {
        m_textField.returnKeyType = UIReturnKeyDone;
    }

    [self updateCountdownLabel];

	[m_textField becomeFirstResponder];
}

- (void) beginEditing
{
#if DEBUG
	GtTrace(GtTraceTextEditing, @"singleline beginEditing");
#endif
	[super beginEditing];
	if(self.isLoaded && ![m_textField isFirstResponder])
	{
		[self.value removeFromSuperview];
		[self createTextView];
		[self setNeedsLayout];
    }
}

- (void) dealloc
{
    GtRelease(m_valueText);
	GtRelease(m_textField);
	[super dealloc];
}

- (void) removeTextEditCell
{
	if(m_textField)
	{
		m_textField.delegate = nil;
	
        m_textField.canResignFirstResponder = YES;
		[m_textField resignFirstResponder];
		[m_textField removeFromSuperview];
		
		[m_textField autorelease];
		m_textField = nil;
		
		[self.contentView addSubview:self.value];
	}
}

- (void) endEditing
{
#if DEBUG
	GtTrace(GtTraceTextEditing, @"singleline endEditing");
#endif

	[super endEditing];
	
	[self removeTextEditCell];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
	if(	m_textField.returnKeyType == UIReturnKeyDefault)
	{
		m_textField.returnKeyType = UIReturnKeyDone;
	}
	
	return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
#if DEBUG
	GtTrace(GtTraceTextEditing, @"singleline textFieldDidBeginEditing");
#endif
	if(textField.clearsOnBeginEditing)
	{
		textField.text = @"";
	}
	[super textDidBeginEditing];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
#if DEBUG
	GtTrace(GtTraceTextEditing, @"singleline textFieldDidEndEditing");
#endif

	[self removeTextEditCell];
	[super textDidEndEditing:self.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(self.nextRowToEdit)
    {
        [self onNext:nil];
    }
    else
    {
        [self onStopEditing:nil];
    }

	return NO;
}

- (CGFloat) cellHeight
{
	return GtSingleLingTextEditCellHeight;
}

- (void) setRowData:(GtDisplayDataRow*) rowData isLoaded:(BOOL) isLoaded
{
	[super setRowData:rowData isLoaded:isLoaded];
	
	if(m_textField)
	{
		m_textField.enabled = isLoaded;
	}
}

#define SHRINKAGE 6.0
#define VERT_ADJUST 9.0

#define LEFT 10.0

#define SINGLE_LINE_HEIGHT 20

- (void) layoutSubviews
{
	[super layoutSubviews];

/*
	if(self.rowData)
	{
		m_label.text = self.rowData.label;
		[m_textField setText:self.rowData.displayStringFromValue];
	}
*/
	CGRect myBounds = CGRectInset(self.contentView.bounds, LEFT, VERT_ADJUST);

	CGRect helpPromptFrame = myBounds;
	
	helpPromptFrame.size = [self.label.text 
			sizeWithFont:self.label.font
			constrainedToSize:myBounds.size
			lineBreakMode:UILineBreakModeClip
			];
	
	self.label.frame = helpPromptFrame; // GtCenterRectHorizontallyInRect(myBounds, helpPromptFrame);
	
	if(m_textField)
	{
		m_textField.textColor = self.isLoaded ? 
			[UIColor standardTextFieldColor] : [UIColor disabledControlColor];

		CGRect frame = myBounds;
		frame.origin.y = helpPromptFrame.size.height + VERT_ADJUST;
		frame.size.height = SINGLE_LINE_HEIGHT; // (helpPromptFrame.size.height + VERT_ADJUST);

		[m_textField setFrame: frame];
	}
}

@end
