//
//	FLTextField.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/18/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLTextField.h"


@implementation FLTextField

@synthesize placeholderTextDescriptor = _placeholderTextDescriptor;
@synthesize viewLayoutMargins = _viewLayoutMargins;

- (void) _update
{
	if(_textDescriptor)
	{
		[super setHighlighted:NO];
		[super setSelected:NO];
		self.textColor = [_textDescriptor textColorForState:_state];
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

- (void) setPlaceholderTextDescriptor:(FLTextDescriptor*) textDescriptor
{
	FLSetObjectWithRetain(_placeholderTextDescriptor, textDescriptor);
}

- (id) init
{
	if((self = [super init]))
	{	
		_canResign = YES;
	}
	return self;
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		_canResign = YES;
	}
	return self;
}

- (void) setCanResignFirstResponder:(BOOL) canResign
{
	_canResign = canResign;
}

- (BOOL) canResignFirstResponder
{
	return _canResign;
}

- (void) dealloc
{
	FLRelease(_placeholderTextDescriptor);
	FLRelease(_textDescriptor);
	super_dealloc_();
}

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
	if(_textDescriptor)
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
	_state.disabled = !enabled;
	if(_textDescriptor)
	{
		[self _update];
	}
}

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];
	if(self.superview)
	{
		[self applyThemeIfNeeded];
	}
}



@end
