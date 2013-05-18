//
//  GtTextEditCell.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/15/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtTextEditCell.h"
#import "GtGeometry.h"
#import "GtColors.h"
#import "GtWindow.h"
#import "GtViewAnimator.h"
#import "GtCustomButton.h"
#import "GtDisplayDataGroup.h"

@interface GtTextEditCell (Private)
- (void) hideHelpText;
- (void) showHelpText;
- (BOOL) wantsHelpText;
- (void) showEditingBar;
- (void) hideEditingBar;
@end

@implementation GtTextEditCell

GtSynthesizeStructProperty(isEditing, setIsEditing, BOOL, m_editFlags);
GtSynthesizeStructProperty(wantsEditingBar, setWantsEditingBar, BOOL, m_editFlags);

@synthesize delegate = m_delegate;
@synthesize nextRowToEdit = m_nextRowToEdit;
@synthesize prevRowToEdit = m_prevRowToEdit;

@synthesize maxLength = m_maxLength;

GtSynthesizeSetter(setTextInputTraits, GtTextInputTraits*, m_traits);
GtSynthesizeSetter(setNextRowToEdit, id, m_nextRowToEdit);

@synthesize helpText = m_helpText;

static BOOL s_editingMode;

+ (void) setGlobalEditingMode:(BOOL) canStop
{
	s_editingMode = canStop;
}

+ (BOOL) inGlobalEditingMode
{
	return s_editingMode;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
		self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.wantsEditingBar = YES;
    }
	
	return self;
}

- (void) dealloc
{
    [self hideWarningLabel];

    GtRelease(m_warningIcon);
    GtRelease(m_warningLabel);
    GtRelease(m_helpText);
    GtRelease(m_helpTextLabel);
    GtRelease(m_traits);
	GtRelease(m_countDownLabel);
    GtRelease(m_viewAnimator);
    GtRelease(m_editingBar);
    GtRelease(m_next);
    GtRelease(m_prev);
    GtRelease(m_stop);
    
	[super dealloc];
}

- (void) clear
{
}

- (void) beginEditing
{
}

- (BOOL) wantsHelpText
{
    return !self.isEditing &&
            m_helpText && 
            m_helpText.length && 
            self.text.length == 0;
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
    if( [self wantsHelpText])
    {
        if(!m_helpTextLabel)
        {
            m_helpTextLabel = [GtAlloc(UILabel) initWithFrame:CGRectZero];
        }
        m_helpTextLabel.font = self.value.font;
        m_helpTextLabel.textColor = [UIColor grayColor];
        m_helpTextLabel.lineBreakMode = UILineBreakModeTailTruncation; 
        m_helpTextLabel.textAlignment = UITextAlignmentLeft; 
        m_helpTextLabel.backgroundColor = [UIColor clearColor];
        m_helpTextLabel.text = m_helpText;
        m_helpTextLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:m_helpTextLabel];
        
        [self setNeedsLayout];
    }
    else
    {
        [self hideHelpText];
    }
}

- (void) setHelpText:(NSString*) helpText
{
    if(m_helpText != helpText)
    {
        GtRelease(m_helpText);
        m_helpText = [helpText retain];
    }
    
    [self showHelpText];
}

- (void) setText:(NSString*) text
{
    [super setText:text];
    [self showHelpText];
    [self showWarningIcon];
}

- (void) shutDownEditing
{
    self.isEditing = NO;
    
    [self hideCountdownLabel];
    [self showHelpText];
    [self hideWarningLabel];
    [self showWarningIcon];
    [self hideEditingBar];
}

- (void) endEditing
{
	if(self.rowData)
	{
		[self.rowData setValueWithDisplayString:[[self text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
		self.rowData.editing = NO;
	}

    [self shutDownEditing];
    
}

- (void) cancelEditing
{
	self.delegate = nil;
	[self endEditing];
}

- (void)textDidBeginEditing
{
	if(self.rowData)
	{
		self.rowData.editing = YES;
	}
    self.isEditing = YES;

	[self.delegate textEditCellDidBeginEditing:self];
    [self showEditingBar];
    [self updateCountdownLabel];
    [self hideHelpText];
    [self hideWarningIcon];
}

- (void) setRowData:(GtDisplayDataRow*) rowData isLoaded:(BOOL) isLoaded
{
	[super setRowData:rowData isLoaded:isLoaded];

    if(self.rowData)
    {
        self.prevRowToEdit = [self.rowData.parentGroup findPrevCellToEdit:self];
        self.nextRowToEdit = [self.rowData.parentGroup findNextCellToEdit:self];

        self.maxLength = self.rowData.maxDataSize;
        self.helpText = self.rowData.helpText;
        self.text = [self.rowData displayStringFromValue];
    }
    
    [self showHelpText];
    [self showWarningIcon];
}

- (void)textDidEndEditing:(NSString*) text
{
	if(self.rowData)
	{
		[self.rowData setValueWithDisplayString:[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
		self.rowData.editing = NO;
	}

    [self shutDownEditing];
}

- (GtTextInputTraits*) textInputTraits
{
	if(!m_traits)
	{
		m_traits = [GtAlloc(GtTextInputTraits) init];
	}
	
	return m_traits;
}

- (void) setTextInputTraitsForControl:(id<UITextInputTraits>) control
{
	if(m_traits)
	{	
		[m_traits copyTextInputTraitsToControl:control];
	}

	id cellData = self.rowData.cellData;

	if(cellData && [cellData isKindOfClass:[GtTextEditCellData class]])
	{
		GtTextEditCellData* data = cellData;
		self.textInputTraits = data.textInputTraits;
		[self.textInputTraits copyTextInputTraitsToControl:control];
	}
}

- (void) showCountdownLabel
{
    if(!m_countDownLabel)
    {
        m_countDownLabel = [GtAlloc(UILabel) initWithFrame:CGRectMake(0,0, 60, 12)];
        m_countDownLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        m_countDownLabel.backgroundColor = [UIColor clearColor];
        m_countDownLabel.textColor = [UIColor blackColor];
        m_countDownLabel.textAlignment = UITextAlignmentRight;
        [self.contentView addSubview:m_countDownLabel];
        
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
    return m_maxLength - self.text.length;
}


- (void) showWarningIcon
{
    if( m_maxLength > 0 &&
        !self.isEditing &&
        !m_warningIcon && 
        self.remainingSize < 0)
    {
        m_warningIcon = [GtAlloc(UIImageView) initWithImage:[UIImage imageNamed:@"warning-20.png"]];
        [m_warningIcon sizeToFit]; 
        [self setNeedsLayout];
        
        [self.contentView addSubview:m_warningIcon];
        [self setNeedsLayout];
    }
    
}

- (void) hideWarningIcon
{
    if(m_warningIcon)
    {
        [m_warningIcon removeFromSuperview];
        GtReleaseWithNil(m_warningIcon);
    }
}

#define Height 16
- (void) showWarningLabel
{
    if(!m_warningLabel)
    {
        NSInteger top = GtStatusBarHeight + GtNavigationBarHeight - 4;
           
        m_warningLabel = [GtAlloc(UILabel) initWithFrame:CGRectMake(0, top, [GtWindow topWindow].bounds.size.width, Height)];
        m_warningLabel.backgroundColor = [UIColor paleYellowColor];
        m_warningLabel.textColor = [UIColor grayColor];
        m_warningLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        m_warningLabel.text = @"Warning: your text is too long and will be truncated";
        m_warningLabel.textAlignment = UITextAlignmentCenter;
        m_warningLabel.alpha = 1.0;
        
        if(!m_viewAnimator)
        {
            m_viewAnimator = [GtAlloc(GtViewAnimator) initWithStartPosition:GtAnimationPositionTop];
        }
        
        [m_viewAnimator addSubview:m_warningLabel
                superview:[GtWindow topWindow]];
    }
}

- (void) hideWarningLabel
{
    if(m_warningLabel)
    {
        [m_viewAnimator removeFromSuperview:m_warningLabel];
            
        GtReleaseWithNil(m_warningLabel);
    }
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
            
            if(!m_warningLabel)
            {
                [self showWarningLabel];
            }
            if(!m_warningIcon)
            {
                [self showWarningIcon];
            }
        }
        else
        {
            m_countDownLabel.textColor = [UIColor grayColor];
            
            if(m_warningLabel)
            {
                [self hideWarningLabel];
            }
            if(m_warningIcon)
            {
                [self hideWarningIcon];
            }
        }
        
        m_countDownLabel.text = [NSString stringWithFormat:@"%d", self.remainingSize];
    }
}

- (void) positionCountdownView:(UILabel*) label
{
    CGRect r = GtRightJustifyRectInRect(self.contentView.bounds, label.frame);
    r.origin.y = 10;
    r.origin.x -= 18;
    label.frame = r;
}

- (void) onPrevious:(id) sender
{
    if(m_delegate && m_prevRowToEdit)
	{
        GtAssert(m_prevRowToEdit != self, @"set self as prev row to edit");
   
        [m_delegate textEditCellBeginEditingCell:m_prevRowToEdit];
	}
}

- (void) onNext:(id) sender
{
    if(m_delegate && m_nextRowToEdit)
	{
        GtAssert(m_nextRowToEdit != self, @"set self as prev row to edit");
    
        [m_delegate textEditCellBeginEditingCell:m_nextRowToEdit];
	}
}

- (void) onStopEditing:(id) sender
{
    if(self.delegate)
	{
		[self.delegate textEditCellDidEndEditing:self];
	}
}

- (void) showEditingBar
{
    if(self.wantsEditingBar && !m_editingBar)
    {
        m_editingBar = [GtAlloc(UIToolbar) initWithFrame:CGRectZero];
        m_editingBar.barStyle = UIBarStyleBlack; 
        m_editingBar.translucent = YES;
        
        CGRect barFrame = m_editingBar.frame;
        barFrame.size.width = [GtWindow topWindow].bounds.size.width;
        barFrame.size.height = GtToolBarHeight - 6;
        barFrame.origin.y = [GtWindow topWindow].bounds.size.height - GtKeyboardHeight - barFrame.size.height;
        
        m_editingBar.frame = barFrame;
        
        m_next = [GtAlloc(UIBarButtonItem) initWithImage:[UIImage imageNamed:@"arrow_down.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onNext:)];
        m_next.enabled = m_nextRowToEdit != nil;
        
        m_prev = [GtAlloc(UIBarButtonItem) initWithImage:[UIImage imageNamed:@"arrow_up.png"] style:UIBarButtonItemStylePlain target:self action:@selector(onPrevious:)];
        m_prev.enabled = m_prevRowToEdit != nil;

        m_stop = [GtAlloc(UIBarButtonItem) initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(onStopEditing:)];
        
        UIBarButtonItem* space = [GtAlloc(UIBarButtonItem) initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        space.width = 40;
        
        m_editingBar.items = [NSArray arrayWithObjects:
            m_prev, 
            space, 
            m_next, 
            [[GtAlloc(UIBarButtonItem) initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease], 
            m_stop, 
            nil];
        
        GtRelease(space);
        
        [[GtWindow topWindow] addSubview:m_editingBar];
    }
}

- (void) hideEditingBar
{
    if(m_editingBar)
    {
        [m_editingBar removeFromSuperview];
        GtReleaseWithNil(m_editingBar);
    }
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
        m_helpTextLabel.font = self.value.font;
        m_helpTextLabel.frame = self.value.frame; 
    }
    
    if(m_warningIcon)
    {
        CGRect rect = m_warningIcon.frame;
        rect = GtRightJustifyRectInRect(self.contentView.bounds, rect);
        rect.origin.y = 10;
        rect.origin.x -= 10;
        m_warningIcon.frame = rect;
    }
}

@end
