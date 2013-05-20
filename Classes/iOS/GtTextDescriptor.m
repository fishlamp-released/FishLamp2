//
//	GtTextDescriptor.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/1/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTextDescriptor.h"

@implementation GtTextDescriptor

@synthesize enabledColor = m_enabledColor;
@synthesize disabledColor = m_disabledColor;
@synthesize highlightedColor = m_highlightedColor;
@synthesize highlightedShadowColor = m_highlightedShadowColor;
@synthesize enabledShadowColor = m_enabledShadowColor;
@synthesize disabledShadowColor = m_disabledShadowColor;

@synthesize selectedColor = m_selectedColor;
@synthesize selectedShadowColor = m_selectedShadowColor;

@synthesize shadowOffset = m_shadowOffset;
@synthesize font = m_font;

- (id) initWithFont:(UIFont*) font
	enabledColor:(UIColor*) enabledColor
	enabledShadowColor:(UIColor*) enabledShadowColor
	disabledColor:(UIColor*) disabledColor
	disabledShadowColor:(UIColor*) disabledShadowColor
	highlightedColor:(UIColor*) highlightedColor
	highlightedShadowColor:(UIColor*) highlightedShadowColor
	selectedColor:(UIColor*) selectedColor
	selectedShadowColor:(UIColor*) selectedShadowColor
	shadowOffset:(CGSize) shadowOffset
{
	if((self = [super init]))
	{
		m_font = GtRetain(font);
		
		m_enabledColor = GtRetain(enabledColor);
		m_enabledShadowColor = GtRetain(enabledShadowColor);
	
		m_disabledColor = GtRetain(disabledColor);
		m_disabledShadowColor = GtRetain(disabledShadowColor);
		
		m_highlightedColor = GtRetain(highlightedColor);
		m_highlightedShadowColor = GtRetain(highlightedShadowColor);
		
		m_selectedColor = GtRetain(selectedColor);
		m_selectedShadowColor = GtRetain(selectedShadowColor);
		
		m_shadowOffset = shadowOffset;
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_enabledColor);
	GtRelease(m_enabledShadowColor);

	GtRelease(m_disabledColor);
	GtRelease(m_disabledShadowColor);

	GtRelease(m_highlightedColor);
	GtRelease(m_highlightedShadowColor);
	
	GtRelease(m_selectedColor);
	GtRelease(m_selectedShadowColor);

	GtRelease(m_font);
	GtSuperDealloc();
}

+ (GtTextDescriptor*) textDescriptor
{
	return GtReturnAutoreleased([[GtTextDescriptor alloc] init]);
}

+ (GtTextDescriptor*) textDescriptor:(UIFont*) font
	enabledColor:(UIColor*) enabledColor
	enabledShadowColor:(UIColor*) enabledShadowColor
	disabledColor:(UIColor*) disabledColor
	disabledShadowColor:(UIColor*) disabledShadowColor
	highlightedColor:(UIColor*) highlightedColor
	highlightedShadowColor:(UIColor*) highlightedShadowColor
	selectedColor:(UIColor*) selectedColor
	selectedShadowColor:(UIColor*) selectedShadowColor
	shadowOffset:(CGSize) shadowOffset
{
	return GtReturnAutoreleased([[GtTextDescriptor alloc] initWithFont:font
		enabledColor:enabledColor
		enabledShadowColor:enabledShadowColor
		disabledColor:disabledColor
		disabledShadowColor:disabledShadowColor
		highlightedColor:highlightedColor
		highlightedShadowColor:highlightedShadowColor
		selectedColor:selectedColor
		selectedShadowColor:selectedShadowColor
		shadowOffset:shadowOffset
		] );
}

- (UIColor*) textColorForState:(GtTextDescriptorState) state
{
	if(state.selected)
	{
		return self.selectedColor;
	}
	if(state.highlighted)
	{
		return self.highlightedColor;
	}
	if(state.disabled)
	{
		return self.disabledColor;
	}
	
	return self.enabledColor;
}

- (UIColor*) shadowColorForState:(GtTextDescriptorState) state
{
	if(state.selected)
	{
		return self.selectedShadowColor;
	}
	if(state.highlighted)
	{
		return self.highlightedShadowColor;
	}
	if(state.disabled)
	{
		return self.disabledShadowColor;
	}
	
	return self.enabledShadowColor;
}

- (id) copyWithZone:(NSZone *)zone
{
	return [[GtTextDescriptor alloc] initWithFont:self.font 
		enabledColor:self.enabledColor 
		enabledShadowColor:self.enabledShadowColor 
		disabledColor:self.disabledColor 
		disabledShadowColor:self.disabledShadowColor 
		highlightedColor:self.highlightedColor 
		highlightedShadowColor:self.highlightedShadowColor 
		selectedColor:self.selectedColor 
		selectedShadowColor:self.selectedShadowColor 
		shadowOffset:self.shadowOffset];
}

@end