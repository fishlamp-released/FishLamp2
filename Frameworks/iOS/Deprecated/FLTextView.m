//
//	FLTextView.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/1/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTextView.h"

@implementation FLTextView

@synthesize enforcedEdgeInsets = enforcedEdgeInsets;
@synthesize useEnforcedEdgeInsets = _useEnforceEdgeInsets;
@synthesize placeholderTextLabel = _placeholderTextLabel;
@synthesize viewLayoutMargins = _viewLayoutMargins;

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
	FLRelease(_textDescriptor);
	FLSuperDealloc();
}

- (void) _update
{
	if(_textDescriptor)
	{
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

- (BOOL) isEnabled
{
	return [self isEditable];
}

- (void) setEnabled:(BOOL) enabled
{
	_state.disabled = !enabled;
	self.editable = enabled;
	[self _update];
}

- (void) setEditable:(BOOL) editable
{
	_state.disabled = !editable;
	[super setEditable:editable];
	[self _update];
}

- (void) didMoveToSuperview
{
	[super didMoveToSuperview];
	if(self.superview)
	{
		[self applyThemeIfNeeded];
	}
}

- (void) setEnforcedEdgeInsets:(UIEdgeInsets) insets
{
	_edgeInsets = insets;
	[super setContentInset:_edgeInsets];
}

-(void)setContentInset:(UIEdgeInsets) insets
{
	if(!_useEnforceEdgeInsets)
	{
		[super setContentInset:insets];
	}
}

- (void) updatePlaceholderTextVisibility
{
	_placeholderTextLabel.hidden = FLStringIsNotEmpty(self.text);
}

- (void) setPlaceholderText:(NSString *) placeholderText
{
	if(FLStringIsNotEmpty(placeholderText) && !_placeholderTextLabel)
	{
		_placeholderTextLabel = [[FLLabel alloc] initWithFrame:CGRectMake(0,2,self.bounds.size.width, 16)];
		_placeholderTextLabel.backgroundColor = [UIColor clearColor];
		_placeholderTextLabel.font = [UIFont italicSystemFontOfSize:[UIFont systemFontSize]];
		_placeholderTextLabel.textColor = [UIColor grayColor];
		[self addSubview:_placeholderTextLabel];
	}
	_placeholderTextLabel.text = placeholderText;
	[self setNeedsLayout];
}

- (NSString*) placeholderText
{
	return _placeholderTextLabel ? _placeholderTextLabel.text : nil;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(_placeholderTextLabel)
	{
		[_placeholderTextLabel sizeToFitWidth:self.bounds.size.width - 2];
		_placeholderTextLabel.frameOptimizedForSize = FLRectSetOrigin(_placeholderTextLabel.frame, fabsf(self.contentInset.left) + 2.0f, fabsf(self.contentInset.top));
	}
	
	[self updatePlaceholderTextVisibility];
}

@end

@implementation UITextView (Extras)

- (void) insertStringAtSelection:(NSString*) string
{
	NSMutableString* text = FLAutorelease([self.text mutableCopy]);
	NSRange selection = self.selectedRange;
	[text insertString:string atIndex:selection.location];
	self.text = text;
}

@end