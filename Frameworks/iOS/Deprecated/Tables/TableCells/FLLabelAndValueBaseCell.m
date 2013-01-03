//
//	FLLabelAndValueBaseCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/24/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLLabelAndValueBaseCell.h"

#import "FLGeometry.h"

@implementation FLLabelAndValueBaseCell

@synthesize valueLabel = _value;
@synthesize spinner = _spinner;

FLSynthesizeStructProperty(updateTextWithRowData, setUpdateTextWithRowData, BOOL, _baseFlags);
FLSynthesizeStructProperty(autoShowSpinner, setAutoShowSpinner, BOOL, _baseFlags);
FLSynthesizeStructProperty(trimWhiteSpace, setTrimWhiteSpace, BOOL, _baseFlags);

- (void) applyTheme:(FLTheme*) theme {
	self.backgroundColor = [UIColor clearColor];
//	field.textDescriptor = self.valueDescriptor;
}

- (UIView*) createValueLabel
{
	FLLabel* label = FLAutorelease([[FLLabel alloc] initWithFrame:CGRectZero]);
	label.backgroundColor = [UIColor clearColor];
	label.lineBreakMode = UILineBreakModeTailTruncation; 
	label.textAlignment = UITextAlignmentLeft; 
	label.adjustsFontSizeToFitWidth = NO;
	label.highlightedTextColor = [UIColor whiteColor];
	return label;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier		
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		self.wantsApplyTheme = YES;

		self.trimWhiteSpace = YES;
		self.updateTextWithRowData = YES;
		_value = [[FLDeprecatedTextViewProxy alloc] initWithView:[self createValueLabel]];
		[self addSubview:_value.view];
	}
	
	return self;
}

- (NSString*) valueLabelText
{
	return [_value text];
//	  self.trimWhiteSpace ? [[_value text] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
}

- (void) setValueLabelText:(NSString*) text
{
	[_value setText:text];
	[self setNeedsLayout];
//	  [_value setText:[text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
}

- (void) enabledStateDidChange
{
	self.label.enabled = self.canEditData;

	if([_value.view respondsToSelector:@selector(setEnabled:)])
	{
		[((id)_value.view) setEnabled:self.canEditData];
	}
	[super enabledStateDidChange];
}

- (void) dealloc
{
	FLRelease(_spinner);
	FLRelease(_value);
	FLSuperDealloc();
}

- (void) startSpinnerInValueCell
{
	if(!_spinner)
	{
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[_spinner startAnimating];
		_spinner.hidesWhenStopped = YES;
		[self addSubview:_spinner];
		_value.view.hidden = YES;
	}
}

- (void) adjustSpinnerFrame
{
	_spinner.newFrame = 
		FLRectCenterRectInRectVertically(self.bounds, FLRectCenterRectInRectHorizontally(_value.view.frame, [_spinner frame]));
}

- (void) updateCellState
{
	[super updateCellState];
	
	if(self.dataSource && self.updateTextWithRowData)
	{
		NSString* str = self.formattedDisplayString;
		if(FLStringIsNotEmpty(str))
		{
			[self setValueLabelText:str];
		}
	}
	
	if(FLStringIsNotEmpty(self.valueLabelText))
	{
		if(_spinner)
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
	
	if(_spinner)
	{
		[self adjustSpinnerFrame];
	}
}

- (void) stopSpinnerInValueCell
{
	if(_spinner)
	{
		[_spinner removeFromSuperview];
		FLReleaseWithNil(_spinner);
		
		_value.view.hidden = NO;
	}
}

- (CGSize) valueTextSizeForContentViewWidth:(CGFloat) width
{
	NSString* text = self.valueLabel.text;
	if(FLStringIsEmpty(text))
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

