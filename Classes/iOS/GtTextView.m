//
//	GtTextView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/1/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTextView.h"

@implementation GtTextView

GtSynthesizeStructProperty(wasThemed, setWasThemed, BOOL, m_themeState);
GtSynthesizeStructProperty(themeAction, setThemeAction, SEL, m_themeState);

@synthesize enforcedEdgeInsets = enforcedEdgeInsets;
@synthesize useEnforcedEdgeInsets = m_useEnforceEdgeInsets;
@synthesize placeholderTextLabel = m_placeholderTextLabel;
@synthesize viewLayoutMargins = m_viewLayoutMargins;

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
	GtRelease(m_textDescriptor);
	GtSuperDealloc();
}

- (void) _update
{
	if(m_textDescriptor)
	{
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

- (BOOL) isEnabled
{
	return [self isEditable];
}

- (void) setEnabled:(BOOL) enabled
{
	m_state.disabled = !enabled;
	self.editable = enabled;
	[self _update];
}

- (void) setEditable:(BOOL) editable
{
	m_state.disabled = !editable;
	[super setEditable:editable];
	[self _update];
}

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];
	if(self.superview)
	{
		[self applyTheme];
	}
}

- (void) setEnforcedEdgeInsets:(UIEdgeInsets) insets
{
	m_edgeInsets = insets;
	[super setContentInset:m_edgeInsets];
}

-(void)setContentInset:(UIEdgeInsets) insets
{
	if(!m_useEnforceEdgeInsets)
	{
		[super setContentInset:insets];
	}
}

- (void) updatePlaceholderTextVisibility
{
	m_placeholderTextLabel.hidden = GtStringIsNotEmpty(self.text);
}

- (void) setPlaceholderText:(NSString *) placeholderText
{
	if(GtStringIsNotEmpty(placeholderText) && !m_placeholderTextLabel)
	{
		m_placeholderTextLabel = [[GtLabel alloc] initWithFrame:CGRectMake(0,2,self.bounds.size.width, 16)];
		m_placeholderTextLabel.backgroundColor = [UIColor clearColor];
		m_placeholderTextLabel.font = [UIFont italicSystemFontOfSize:[UIFont systemFontSize]];
		m_placeholderTextLabel.textColor = [UIColor grayColor];
		[self addSubview:m_placeholderTextLabel];
	}
	m_placeholderTextLabel.text = placeholderText;
	[self setNeedsLayout];
}

- (NSString*) placeholderText
{
	return m_placeholderTextLabel ? m_placeholderTextLabel.text : nil;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(m_placeholderTextLabel)
	{
		[m_placeholderTextLabel sizeToFitFixedWidth:self.bounds.size.width - 2];
		m_placeholderTextLabel.frameOptimizedForSize = GtRectSetOrigin(m_placeholderTextLabel.frame, fabsf(self.contentInset.left) + 2.0f, fabsf(self.contentInset.top));
	}
	
	[self updatePlaceholderTextVisibility];
}

@end

@implementation UITextView (Extras)

- (void) insertStringAtSelection:(NSString*) string
{
	NSMutableString* text = GtReturnAutoreleased([self.text mutableCopy]);
	NSRange selection = self.selectedRange;
	[text insertString:string atIndex:selection.location];
	self.text = text;
}

@end