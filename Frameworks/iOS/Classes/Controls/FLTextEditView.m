//
//  FLTextEditView.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/4/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTextEditView.h"
#import "FLThemeManager.h"
#import "UIColor+FLMoreColors.h"

@implementation FLTextEditView

@synthesize textViewFrameView = _roundRectView;
@synthesize maxSize = _maxSize;
@synthesize countdownView = _countdownView;
@synthesize delegate = _delegate;
@synthesize dissallowReturnKey = _dissallowReturnKey;

- (void) _didChangeText:(id) sender
{
	[self handleTextDidChange];
}

- (void) applyTheme:(FLTheme*) theme {
//	view.textViewFrameView.fillColor = self.cellBackgroundColor;
//	view.textViewFrameView.borderColor = [UIColor darkGrayColor];
//	view.textDescriptor = self.valueDescriptor;
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
        self.wantsApplyTheme = YES;

		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		self.backgroundColor = [UIColor clearColor];
	
		_roundRectView = [[FLRoundRectView alloc] initWithFrame:frame];
		_roundRectView.borderAlpha = 1.0;
		_roundRectView.fillAlpha = 1.0;
		_roundRectView.fillColor = [UIColor whiteColor];
		_roundRectView.borderColor = [UIColor grayColor];
		[self addSubview:_roundRectView];

		_textView = [[FLTextView alloc] initWithFrame:frame];
		_textView.enforcedEdgeInsets = UIEdgeInsetsMake(-8, -8,8, 8);
		_textView.useEnforcedEdgeInsets = YES;
		_textView.autoresizingMask = UIViewAutoresizingNone;
		_textView.showsVerticalScrollIndicator = NO;
		_textView.scrollEnabled = YES;
		_textView.backgroundColor = [UIColor clearColor];
		_textView.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
		_textView.textColor = [UIColor blackColor];
		_textView.returnKeyType = UIReturnKeyDone;
//		_textView.dataDetectorTypes = UIDataDetectorTypeLink;
		_textView.placeholderText = nil;
		_textView.delegate = self;
        [self addSubview:_textView];

        _countdownView = [[FLLabel alloc] initWithFrame:CGRectMake(0,0,100, 14)];
		_countdownView.autoresizingMask = UIViewAutoresizingNone;
		_countdownView.textColor = [UIColor grayColor];
		_countdownView.backgroundColor = [UIColor clearColor];
		_countdownView.shadowColor = [UIColor blackColor];
		_countdownView.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
		_countdownView.textAlignment = UITextAlignmentRight;
		_countdownView.hidden = YES;
		[self addSubview:_countdownView];
	}
	
	return self;
}

- (void) startEditing
{
    [_textView becomeFirstResponder];
}

- (void) stopEditing
{
   if([_textView isFirstResponder])
   {
      [_textView resignFirstResponder];
   }
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self handleTextDidChange];
}

- (void) setPlaceholderText:(NSString*) placeholderText
{
	_textView.placeholderText = placeholderText;
}

- (NSString*) placeholderText
{
    return _textView.placeholderText;
}

- (void) setMaxSize:(NSInteger) maxSize
{	
	_maxSize = maxSize;
	_countdownView.hidden = _maxSize == 0;
}

- (void) handleTextDidChange
{
    NSString* newText = _textView.text;

	NSInteger remaining = _maxSize - newText.length;
	if(remaining == -1 && _remaining == 0)
	{
		FLSetObjectWithRetain(_countdownColor, _countdownView.textColor);
		_countdownView.textColor = [UIColor fireEngineRed];
	}
	else if(remaining == 0 && _remaining == -1)
	{
		_countdownView.textColor = _countdownColor;
		FLReleaseWithNil(_countdownColor);
	}

	_remaining = remaining;

	_countdownView.text = [NSString stringWithFormat:@"%d", _remaining];
	
    [_textView updatePlaceholderTextVisibility];

    if(self.dissallowReturnKey && newText.length > 0 && [newText characterAtIndex:newText.length - 1] == '\n')
    {
        newText = [newText substringToIndex:newText.length - 1];
        _textView.text = newText;
    
        [_delegate textEditView:self userTappedReturnKey:newText];
    }
    else
    {
        [_delegate textEditView:self textDidChange:newText];
    }

}

- (void) dealloc
{
	FLRelease(_countdownView);
	FLRelease(_roundRectView);
	_textView.delegate = nil;
    FLRelease(_textView);
	FLSuperDealloc();
}

#define kInset 5.0f

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	_roundRectView.frameOptimizedForLocation = self.bounds;
	_textView.frameOptimizedForLocation = CGRectInset(self.bounds, kInset, kInset);
	_countdownView.frameOptimizedForLocation = FLRectJustifyRectInRectBottomRight(_textView.frame, _countdownView.frame);
	
	[self handleTextDidChange];
}

- (NSString*) text
{
    return _textView.text;
}

- (void) setText:(NSString*) text
{
    _textView.delegate = nil;

    if(text)
    {
        _textView.text = text;
    }
    else
    {
        _textView.text = @"";
    }
    
    _textView.delegate = self;
    [self handleTextDidChange];
}

- (void) setTextDescriptor:(FLTextDescriptor *)textDescriptor
{
    _textView.textDescriptor = textDescriptor;
}

- (FLTextDescriptor*) textDescriptor
{
    return _textView.textDescriptor;
}




@end
