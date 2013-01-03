//
//	FLTextDescriptor.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/1/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLTextDescriptor.h"

@implementation FLTextDescriptor

@synthesize enabledColor = _enabledColor;
@synthesize disabledColor = _disabledColor;
@synthesize highlightedColor = _highlightedColor;
@synthesize highlightedShadowColor = _highlightedShadowColor;
@synthesize enabledShadowColor = _enabledShadowColor;
@synthesize disabledShadowColor = _disabledShadowColor;
@synthesize selectedColor = _selectedColor;
@synthesize selectedShadowColor = _selectedShadowColor;
@synthesize shadowOffset = _shadowOffset;
@synthesize font = _font;

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
		self.font = font;
        self.enabledColor = enabledColor;
        self.enabledShadowColor = enabledShadowColor;
		self.disabledColor = disabledColor;
		self.disabledShadowColor = disabledShadowColor;
		self.highlightedColor = highlightedColor;
		self.highlightedShadowColor = highlightedShadowColor;
		self.selectedColor = selectedColor;
		self.selectedShadowColor = selectedShadowColor;
		self.shadowOffset = shadowOffset;
	}
	
	return self;
}

- (void) dealloc
{
	FLRelease(_enabledColor);
	FLRelease(_enabledShadowColor);
	FLRelease(_disabledColor);
	FLRelease(_disabledShadowColor);
	FLRelease(_highlightedColor);
	FLRelease(_highlightedShadowColor);
	FLRelease(_selectedColor);
	FLRelease(_selectedShadowColor);
	FLRelease(_font);
	FLSuperDealloc();
}

+ (FLTextDescriptor*) textDescriptor
{
	return FLAutorelease([[FLTextDescriptor alloc] init]);
}

+ (FLTextDescriptor*) textDescriptor:(UIFont*) font
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
	return FLAutorelease([[FLTextDescriptor alloc] initWithFont:font
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

- (UIColor*) textColorForState:(FLTextDescriptorState) state
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

- (UIColor*) shadowColorForState:(FLTextDescriptorState) state
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
	return [[FLTextDescriptor alloc] initWithFont:self.font 
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