//
//	GtLabelAndValueBaseCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/24/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtLabelAndValueBaseCell.h"

#import "GtGeometry.h"

@implementation GtLabelAndValueBaseCell

@synthesize valueLabel = m_value;
@synthesize spinner = m_spinner;

GtSynthesizeStructProperty(updateTextWithRowData, setUpdateTextWithRowData, BOOL, m_baseFlags);
GtSynthesizeStructProperty(autoShowSpinner, setAutoShowSpinner, BOOL, m_baseFlags);
GtSynthesizeStructProperty(trimWhiteSpace, setTrimWhiteSpace, BOOL, m_baseFlags);

- (UIView*) createValueLabel
{
	GtLabel* label = GtReturnAutoreleased([[GtLabel alloc] initWithFrame:CGRectZero]);
	label.backgroundColor = [UIColor clearColor];
	label.lineBreakMode = UILineBreakModeTailTruncation; 
	label.textAlignment = UITextAlignmentLeft; 
	label.adjustsFontSizeToFitWidth = NO;
	label.highlightedTextColor = [UIColor whiteColor];
	label.themeAction = @selector(applyThemeToTableViewCellValueLabel:);
	return label;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier		
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		self.trimWhiteSpace = YES;
		self.updateTextWithRowData = YES;
		m_value = [[GtTextViewProxy alloc] initWithView:[self createValueLabel]];
		[self addSubview:m_value.view];
	}
	
	return self;
}

- (NSString*) valueLabelText
{
	return [m_value text];
//	  self.trimWhiteSpace ? [[m_value text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
}

- (void) setValueLabelText:(NSString*) text
{
	[m_value setText:text];
	[self setNeedsLayout];
//	  [m_value setText:[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

- (void) enabledStateDidChange
{
	self.label.enabled = self.canEditData;

	if([m_value.view respondsToSelector:@selector(setEnabled:)])
	{
		[((id)m_value.view) setEnabled:self.canEditData];
	}
	[super enabledStateDidChange];
}

- (void) dealloc
{
	GtRelease(m_spinner);
	GtRelease(m_value);
	GtSuperDealloc();
}

- (void) startSpinnerInValueCell
{
	if(!m_spinner)
	{
		m_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[m_spinner startAnimating];
		m_spinner.hidesWhenStopped = YES;
		[self addSubview:m_spinner];
		m_value.view.hidden = YES;
	}
}

- (void) adjustSpinnerFrame
{
	m_spinner.newFrame = 
		GtRectCenterRectInRectVertically(self.bounds, GtRectCenterRectInRectHorizontally(m_value.view.frame, [m_spinner frame]));
}

- (void) updateCellState
{
	[super updateCellState];
	
	if(self.dataSource && self.updateTextWithRowData)
	{
		NSString* str = self.formattedDisplayString;
		if(GtStringIsNotEmpty(str))
		{
			[self setValueLabelText:str];
		}
	}
	
	if(GtStringIsNotEmpty(self.valueLabelText))
	{
		if(m_spinner)
		{
			[self stopSpinnerInValueCell];
		}
	}
	else if(self.autoShowSpinner)
	{
		[self startSpinnerInValueCell];
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(m_spinner)
	{
		[self adjustSpinnerFrame];
	}
}

- (void) stopSpinnerInValueCell
{
	if(m_spinner)
	{
		[m_spinner removeFromSuperview];
		GtReleaseWithNil(m_spinner);
		
		m_value.view.hidden = NO;
	}
}

- (CGSize) valueTextSizeForContentViewWidth:(CGFloat) width
{
	NSString* text = self.valueLabel.text;
	if(GtStringIsEmpty(text))
	{
		text = @"Ty"; // capitol + decender
	}

	CGSize size = [text sizeWithFont:self.valueLabel.font
						constrainedToSize:CGSizeMake(width,CGFLOAT_MAX)
						lineBreakMode:self.valueLabel.lineBreakMode];
	size.height += 2;
	return size;
}


@end

