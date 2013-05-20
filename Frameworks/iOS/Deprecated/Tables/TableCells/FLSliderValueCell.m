//
//	FLOnOffSwitchCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/26/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSliderValueCell.h"
#import "FLGeometry.h"


@implementation FLSliderValueCell

@synthesize slider = _slider;
@synthesize sliderValueChangedCallback = _callback;

- (void) setValueText
{
	self.valueLabelText = [NSString stringWithFormat:(NSLocalizedString(@"%.0f seconds", nil)), _slider.value]; // TODO: USE THE FORMATTER
}

- (void) updateControl:(id) sender
{
	[self setValueText];
	
	self.dataSourceObject = [NSNumber numberWithFloat:_slider.value];
	
	if(_callback)
	{
		[_callback invoke:self];
	}
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		self.updateTextWithRowData = NO;
		self.cellHeight = 64;
		
		_slider = [[UISlider alloc] initWithFrame:CGRectZero];
		[_slider addTarget:self action:@selector(updateControl:) forControlEvents:UIControlEventValueChanged];
		
		[self addSubview:_slider];
		
	}
	
	return self;
}

- (void) calculateCellHeightInTable:(UITableView *)tableView
{
}

- (void)dealloc 
{
	FLReleaseWithNil(_slider);
	FLSuperDealloc();
}

- (void) updateValue:(BOOL) animated
{
	NSNumber* number = self.dataSourceObject;
	if(number)
	{
		[_slider setValue:[number floatValue]];
	}
	
	[self setValueText];
}

- (void) enabledStateDidChange
{
	_slider.enabled = self.canEditData;
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
	frame = FLRectInsetLeft(frame, -2);
	frame.size.height = 30;
	
	_slider.frameOptimizedForSize = 
			FLRectJustifyRectInRectBottom(layoutRect, frame);
	
	[_slider.superview bringSubviewToFront:_slider];
}

+ (FLSliderValueCell*) sliderCell:(NSString*) labelOrNil
{
	FLSliderValueCell* cell = FLAutorelease([[FLSliderValueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])]);
	if(FLStringIsNotEmpty(labelOrNil)) {
		cell.textLabelText = labelOrNil;
	}
	return cell;
}

+ (FLSliderValueCell*) sliderCell:(NSString*) label 
	minValue:(CGFloat) minValue 
	maxValue:(CGFloat) maxValue
	currentValue:(CGFloat) currentValue
	target:(id) target
	action:(SEL) action
{
	FLSliderValueCell* cell = [FLSliderValueCell sliderCell:label];
	cell.slider.minimumValue = minValue;
	cell.slider.maximumValue = maxValue;
	cell.slider.value = currentValue;
	
	if(target && action)
	{
		cell.sliderValueChangedCallback = [FLCallbackObject callback:target action:action];
	}

	return cell;
}

@end
