//
//  GtMultiLineTextEditCell.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/28/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtMultiLineTextEditCell.h"
#import "GtSingleLineTextEditCell.h"
#import "GtColors.h"
#import "GtGeometry.h"
#import "GtCustomButton.h"

#define MULTILINE_HEIGHT 60.0
//#define SPACE_BETWEEN_LABEL_AND_TEXT 0.0

@implementation MyTextView

- (void) setCanResignFirstResponder:(BOOL) canResign
{
    m_canResign = canResign;
}

- (BOOL) canResignFirstResponder
{
    return m_canResign;
}

@end

@implementation GtMultiLineTextEditCell

- (UITextView*) textView
{
	return m_textView;
}

#define INSET_VALUE -8
- (NSString*) text
{
	return m_textView ? m_textView.text : [super text];
}

- (void) createTextView
{
	NSString* startText = self.text;
	
	m_textView = [GtAlloc(MyTextView) initWithFrame:CGRectZero];
	m_textView.delegate = self;
	m_textView.showsVerticalScrollIndicator = YES;
	m_textView.scrollEnabled = YES;
	m_textView.backgroundColor = [UIColor clearColor];
	m_textView.font = [UIFont standardTextFieldFont];
	m_textView.textColor = [UIColor standardTextFieldColor];
	m_textView.autoresizingMask = UIViewAutoresizingNone;
	m_textView.contentInset = UIEdgeInsetsMake(INSET_VALUE,INSET_VALUE,ABS(INSET_VALUE),ABS(INSET_VALUE));
	m_textView.contentOffset = CGPointMake(0,0);
    m_textView.canResignFirstResponder = NO;
    
    [self.contentView addSubview:m_textView];

	[m_textView setText:startText];
	
    [self setTextInputTraitsForControl:m_textView];
	
	m_textView.returnKeyType = UIReturnKeyDefault;
	[m_textView becomeFirstResponder];
    
    [self updateCountdownLabel];
}

- (void) clear
{
	self.text = @"";
	if(m_textView)
	{
		m_textView.text = @"";
	}
}

- (void)textViewDidChange:(UITextView *)textView
{
	NSString* newText = textView.text;
	self.text = newText;
    [self updateCountdownLabel];
}

- (void) beginEditing
{
#if DEBUG
	GtTrace(GtTraceTextEditing, @"multiline beginEditing");
#endif
	[super beginEditing];
	if(self.isLoaded)
	{
		[self.value removeFromSuperview];
		[self createTextView];
        [self setNeedsLayout];
	}
}

- (BOOL) needsResizeOnEdit
{
	return self.frame.size.height < GT_TEXT_EDITING_SIZE;
}

- (void) removeTextEditCell
{
	if(m_textView)
	{
		m_textView.delegate = nil;
	
        m_textView.canResignFirstResponder = YES;
		[m_textView resignFirstResponder];
		[m_textView removeFromSuperview];
		
		[m_textView autorelease];
		m_textView = nil;
		
		[self.contentView addSubview:self.value];
	}
}

- (void) endEditing
{
#if DEBUG
	GtTrace(GtTraceTextEditing, @"multiline endEditing");
#endif

	[super endEditing];
	
	[self removeTextEditCell];
}

- (void) setRowData:(GtDisplayDataRow*) rowData isLoaded:(BOOL) isLoaded
{
	[super setRowData:rowData isLoaded:isLoaded];
	if(m_textView)
	{
		m_textView.editable = isLoaded;
	}
}

- (void) dealloc
{
	GtRelease(m_textView);
	[super dealloc];
}

- (BOOL) isEditing
{
	return m_textView != nil;
}	

- (BOOL)textViewShouldBeginEditing:(UITextView *)textField
{
	return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textField
{
#if DEBUG
	GtTrace(GtTraceTextEditing, @"multiline textViewDidBeginEditing");
#endif

	[super textDidBeginEditing];
}

- (void)textViewDidEndEditing:(UITextView *)textField
{
#if DEBUG
	GtTrace(GtTraceTextEditing, @"multiline textViewDidEndEditing");
#endif

	[super textDidEndEditing:textField.text];
	
	[self removeTextEditCell];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	if(m_textView)
	{
		CGRect superviewBounds = [self.label.superview bounds];
		CGRect frame = superviewBounds;
		frame.origin.y = LABEL_HEIGHT + LABEL_TOP + 2;
		frame.size.width += (ABS(INSET_VALUE)*2);
		frame.size.height = GT_TEXT_EDITING_SIZE; // MAX(GT_TEXT_EDITING_SIZE, [self cellHeight]) ;
		m_textView.frame = CGRectInset(frame, 10, 0);
		
		m_textView.textColor = self.isLoaded ? 
			[UIColor standardTextFieldColor] : [UIColor disabledControlColor];
	}
}

- (CGFloat) cellHeight
{
	CGFloat height = [super cellHeight];

	return [GtTextEditCell inGlobalEditingMode] ? 
		GT_EDITING_ROW_HEIGHT :
		MAX(GtSingleLingTextEditCellHeight, height);
}

@end

