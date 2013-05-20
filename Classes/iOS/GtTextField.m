//
//	GtTextField.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTextField.h"


@implementation GtTextField

@synthesize placeholderTextDescriptor = m_placeholderTextDescriptor;
GtSynthesizeStructProperty(wasThemed, setWasThemed, BOOL, m_themeState);
GtSynthesizeStructProperty(themeAction, setThemeAction, SEL, m_themeState);
@synthesize viewLayoutMargins = m_viewLayoutMargins;

- (void) _update
{
	if(m_textDescriptor)
	{
		[super setHighlighted:NO];
		[super setSelected:NO];
		self.textColor = [m_textDescriptor textColorForState:m_state];
		self.font = m_textDescriptor.font;
	}
}

- (GtTextDescriptor*) textDescriptor
{
	return GtReturnAutoreleased([m_textDescriptor copy]);
}

- (void) setTextDescriptor:(GtTextDescriptor*) textDescriptor
{
	if(GtCopyObject(m_textDescriptor, textDescriptor))
	{
		[self _update];
	}
}

- (void) setPlaceholderTextDescriptor:(GtTextDescriptor*) textDescriptor
{
	if(GtAssignObject(m_placeholderTextDescriptor, textDescriptor))
	{
	}
}

- (id) init
{
	if((self = [super init]))
	{	
		m_canResign = YES;
	}
	return self;
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		m_canResign = YES;
	}
	return self;
}

- (void) setCanResignFirstResponder:(BOOL) canResign
{
	m_canResign = canResign;
}

- (BOOL) canResignFirstResponder
{
	return m_canResign;
}

- (void) dealloc
{
	GtRelease(m_placeholderTextDescriptor);
	GtRelease(m_textDescriptor);
	GtSuperDealloc();
}

- (void) setHighlighted:(BOOL) highlighted
{
	m_state.highlighted = highlighted;
	if(m_textDescriptor)
	{
		[self _update];
	}
	else
	{
		[super setHighlighted:highlighted];
	}
}

- (void) setSelected:(BOOL) selected
{
	m_state.selected = selected;
	if(m_textDescriptor)
	{
		[self _update];
	}
	else
	{
		[super setSelected:selected];
	}
}

- (void) setEnabled:(BOOL) enabled
{
	[super setEnabled:enabled];
	m_state.disabled = !enabled;
	if(m_textDescriptor)
	{
		[self _update];
	}
}

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];
	if(self.superview)
	{
		[self applyTheme];
	}
}



@end
