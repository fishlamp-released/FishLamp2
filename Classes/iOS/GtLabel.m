//
//	GtLabel.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtLabel.h"

@implementation GtLabel

@synthesize willUnderline = m_underline;

GtSynthesizeStructProperty(wasThemed, setWasThemed, BOOL, m_themeState);
GtSynthesizeStructProperty(themeAction, setThemeAction, SEL, m_themeState);

- (void)drawRect:(CGRect)rect 
{
	[super drawRect:rect];
	
	if(self.willUnderline)
	{
		[self drawUnderline:self.bounds withColor:self.textColor withLineWidth:1.0];
	}
}

- (void) _update
{
	if(m_textDescriptor)
	{
		[super setEnabled:YES];
		[super setHighlighted:NO];
		self.textColor = [m_textDescriptor textColorForState:m_state];
		self.shadowColor = [m_textDescriptor shadowColorForState:m_state];
		self.shadowOffset = m_textDescriptor.shadowOffset;
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

- (void) resize:(CGSize) newSize
{
	CGRect frame = self.frame;
	if(self.willUnderline)
	{
		frame.size.height += 2;
	}
	frame.size = newSize;
	self.frame = frame;
}

- (void) dealloc
{
	GtRelease(m_textDescriptor);
	GtSuperDealloc();
}

- (void) setEnabled:(BOOL) enabled
{
	m_state.disabled = !enabled;
	if(m_textDescriptor)
	{
		[self _update];
	}
	else
	{
		[super setEnabled:enabled];
	}
}

//- (BOOL) isEnabled
//{
//	  return m_textDescriptor ? !m_state.disabled : [super isEnabled];
//}

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
	[self _update];
}

- (BOOL) isSelected
{
	return m_state.selected;
}

//- (BOOL) isHighlighted
//{
//	  return m_textDescriptor ? m_state.highlighted : [super isHighlighted];
//}

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];
	if(self.superview)
	{
		[self applyTheme];
	}
}


#if DEBUG

- (void) setFrame:(CGRect) frame
{
	if(!GtRectIsOptimizedForView(frame))
	{
		GtLog(@"Warning setting non-optimal frame for label: %@", NSStringFromCGRect(frame));
	}
	
	[super setFrame:frame];
}

#endif

//- (void)drawTextInRect:(CGRect)rect
//{
//	  CGRect outRect = CGRectIntegral(rect);
//	  if(!GtRectWidthIsOptimizedForView(self.frame)) 
//	  {
//		  outRect.size.width += 1;
//	  }
//	  if(!GtRectHeightIsOptimizedForView(self.frame)) 
//	  {
//		  outRect.size.height += 1;
//	  }
//	  
//	  GtLog(@"text: %@, frame: %@, inRect: %@, outRect: %@", self.text, NSStringFromCGRect(self.frame), NSStringFromCGRect(rect),NSStringFromCGRect(outRect));
//
//	  [super drawTextInRect:outRect];
//}


@end


