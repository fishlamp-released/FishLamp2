//
//	GtOnOffSwitchCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/26/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSliderValueCell.h"
#import "GtGeometry.h"


@implementation GtSliderValueCell

@synthesize slider = m_slider;
@synthesize sliderValueChangedCallback = m_callback;

- (void) setValueText
{
	self.valueLabelText = [NSString stringWithFormat:(NSLocalizedString(@"%.0f seconds", nil)), m_slider.value]; // TODO: USE THE FORMATTER
}

- (void) updateControl:(id) sender
{
	[self setValueText];
	
	self.dataSourceObject = [NSNumber numberWithFloat:m_slider.value];
	
	if(m_callback)
	{
		[m_callback invoke:self];
	}
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		self.updateTextWithRowData = NO;
		self.cellHeight = 64;
		
		m_slider = [[UISlider alloc] initWithFrame:CGRectZero];
		[m_slider addTarget:self action:@selector(updateControl:) forControlEvents:UIControlEventValueChanged];
		
		[self addSubview:m_slider];
		
	}
	
	return self;
}

- (void) calculateCellHeightInTable:(UITableView *)tableView
{
}

- (void)dealloc 
{
	GtReleaseWithNil(m_slider);
	GtSuperDealloc();
}

- (void) updateValue:(BOOL) animated
{
	NSNumber* number = self.dataSourceObject;
	if(number)
	{
		[m_slider setValue:[number floatValue]];
	}
	
	[self setValueText];
}

- (void) enabledStateDidChange
{
	m_slider.enabled = self.canEditData;
	[super enabledStateDidChange];
}

- (void) updateCellState
{
	[super updateCellState];
	[self updateValue:YES];
}

- (void) layoutLabels:(CGRect) contentViewBounds
{
	contentViewBounds.size.height = MAX(self.valueLabel.labelView.frame.size.height, 
		self.label.frame.size.height);
	contentViewBounds.origin.y = 10;
	[super layoutLabels:contentViewBounds];
}
- (void) layoutSubviews
{
	[super layoutSubviews];

	CGRect layoutRect = self.layoutRect;
	CGRect frame = layoutRect;
	frame = GtRectInsetLeft(frame, -2);
	frame.size.height = 30;
	
	m_slider.frameOptimizedForSize = 
			GtRectJustifyRectInRectBottom(layoutRect, frame);
	
	[m_slider.superview bringSubviewToFront:m_slider];
}

+ (GtSliderValueCell*) sliderCell:(NSString*) labelOrNil
{
	GtSliderValueCell* cell = GtReturnAutoreleased([[GtSliderValueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])]);
	if(GtStringIsNotEmpty(labelOrNil)) {
		cell.textLabelText = labelOrNil;
	}
	return cell;
}

+ (GtSliderValueCell*) sliderCell:(NSString*) label 
	minValue:(CGFloat) minValue 
	maxValue:(CGFloat) maxValue
	currentValue:(CGFloat) currentValue
	target:(id) target
	action:(SEL) action
{
	GtSliderValueCell* cell = [GtSliderValueCell sliderCell:label];
	cell.slider.minimumValue = minValue;
	cell.slider.maximumValue = maxValue;
	cell.slider.value = currentValue;
	
	if(target && action)
	{
		cell.sliderValueChangedCallback = [GtCallbackObject callback:target action:action];
	}

	return cell;
}

@end
