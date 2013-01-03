//
//	FLLabel.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLLabel.h"

@implementation FLLabel

@synthesize willUnderline = _underline;

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
	if(_textDescriptor)
	{
		[super setEnabled:YES];
		[super setHighlighted:NO];
		self.textColor = [_textDescriptor textColorForState:_state];
		self.shadowColor = [_textDescriptor shadowColorForState:_state];
		self.shadowOffset = _textDescriptor.shadowOffset;
		self.font = _textDescriptor.font;
	}
}

- (FLTextDescriptor*) textDescriptor
{
	return FLAutorelease([_textDescriptor copy]);
}

- (void) setTextDescriptor:(FLTextDescriptor*) textDescriptor
{
    FLCopyObject_(_textDescriptor, textDescriptor);
    [self _update];
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
	FLRelease(_textDescriptor);
	FLSuperDealloc();
}

- (void) setEnabled:(BOOL) enabled
{
	_state.disabled = !enabled;
	if(_textDescriptor)
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
//	  return _textDescriptor ? !_state.disabled : [super isEnabled];
//}

- (void) setHighlighted:(BOOL) highlighted
{
	_state.highlighted = highlighted;
	if(_textDescriptor)
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
	_state.selected = selected;
	[self _update];
}

- (BOOL) isSelected
{
	return _state.selected;
}

//- (BOOL) isHighlighted
//{
//	  return _textDescriptor ? _state.highlighted : [super isHighlighted];
//}

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];
	if(self.superview)
	{
		[self applyThemeIfNeeded];
	}
}


#if DEBUG

- (void) setFrame:(CGRect) frame
{
	if(!FLRectIsOptimizedForView(frame))
	{
		FLLog(@"Warning setting non-optimal frame for label: %@", NSStringFromCGRect(frame));
	}
	
	[super setFrame:frame];
}

#endif

//- (void)drawTextInRect:(CGRect)rect
//{
//	  CGRect outRect = CGRectIntegral(rect);
//	  if(!FLRectWidthIsOptimizedForView(self.frame)) 
//	  {
//		  outRect.size.width += 1;
//	  }
//	  if(!FLRectHeightIsOptimizedForView(self.frame)) 
//	  {
//		  outRect.size.height += 1;
//	  }
//	  
//	  FLLog(@"text: %@, frame: %@, inRect: %@, outRect: %@", self.text, NSStringFromCGRect(self.frame), NSStringFromCGRect(rect),NSStringFromCGRect(outRect));
//
//	  [super drawTextInRect:outRect];
//}


@end


