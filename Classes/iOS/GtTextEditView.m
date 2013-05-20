//
//  GtTextEditView.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/4/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTextEditView.h"
#import "GtThemeManager.h"
#import "UIColor+GtMoreColors.h"

@implementation GtTextEditView

@synthesize textViewFrameView = m_roundRectView;
@synthesize maxSize = m_maxSize;
@synthesize countdownView = m_countdownView;
@synthesize delegate = m_delegate;
@synthesize dissallowReturnKey = m_dissallowReturnKey;

- (void) _didChangeText:(id) sender
{
	[self handleTextDidChange];
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleEverything;
		self.backgroundColor = [UIColor clearColor];
		
		self.themeAction = @selector(applyThemeToTextEditView:);
	
		m_roundRectView = [[GtRoundRectView alloc] initWithFrame:frame];
		m_roundRectView.borderAlpha = 1.0;
		m_roundRectView.fillAlpha = 1.0;
		m_roundRectView.fillColor = [UIColor whiteColor];
		m_roundRectView.borderColor = [UIColor grayColor];
		[self addSubview:m_roundRectView];

		m_textView = [[GtTextView alloc] initWithFrame:frame];
		m_textView.enforcedEdgeInsets = UIEdgeInsetsMake(-8, -8,8, 8);
		m_textView.useEnforcedEdgeInsets = YES;
		m_textView.autoresizingMask = UIViewAutoresizingNone;
		m_textView.showsVerticalScrollIndicator = NO;
		m_textView.scrollEnabled = YES;
		m_textView.backgroundColor = [UIColor clearColor];
		m_textView.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
		m_textView.textColor = [UIColor blackColor];
		m_textView.returnKeyType = UIReturnKeyDone;
//		m_textView.dataDetectorTypes = UIDataDetectorTypeLink;
		m_textView.placeholderText = nil;
		m_textView.delegate = self;
        [self addSubview:m_textView];

        m_countdownView = [[GtLabel alloc] initWithFrame:CGRectMake(0,0,100, 14)];
		m_countdownView.autoresizingMask = UIViewAutoresizingNone;
		m_countdownView.textColor = [UIColor grayColor];
		m_countdownView.backgroundColor = [UIColor clearColor];
		m_countdownView.shadowColor = [UIColor blackColor];
		m_countdownView.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
		m_countdownView.textAlignment = UITextAlignmentRight;
		m_countdownView.hidden = YES;
		[self addSubview:m_countdownView];
	}
	
	return self;
}

- (void) startEditing
{
    [m_textView becomeFirstResponder];
}

- (void) stopEditing
{
   if([m_textView isFirstResponder])
   {
      [m_textView resignFirstResponder];
   }
}

- (void)textViewDidChange:(UITextView *)textView
{
    [self handleTextDidChange];
}

- (void) setPlaceholderText:(NSString*) placeholderText
{
	m_textView.placeholderText = placeholderText;
}

- (NSString*) placeholderText
{
    return m_textView.placeholderText;
}

- (void) setMaxSize:(NSInteger) maxSize
{	
	m_maxSize = maxSize;
	m_countdownView.hidden = m_maxSize == 0;
}

- (void) handleTextDidChange
{
    NSString* newText = m_textView.text;

	NSInteger remaining = m_maxSize - newText.length;
	if(remaining == -1 && m_remaining == 0)
	{
		GtAssignObject(m_countdownColor, m_countdownView.textColor);
		m_countdownView.textColor = [UIColor fireEngineRed];
	}
	else if(remaining == 0 && m_remaining == -1)
	{
		m_countdownView.textColor = m_countdownColor;
		GtReleaseWithNil(m_countdownColor);
	}

	m_remaining = remaining;

	m_countdownView.text = [NSString stringWithFormat:@"%d", m_remaining];
	
    [m_textView updatePlaceholderTextVisibility];

    if(self.dissallowReturnKey && newText.length > 0 && [newText characterAtIndex:newText.length - 1] == '\n')
    {
        newText = [newText substringToIndex:newText.length - 1];
        m_textView.text = newText;
    
        [m_delegate textEditView:self userTappedReturnKey:newText];
    }
    else
    {
        [m_delegate textEditView:self textDidChange:newText];
    }

}

- (void) dealloc
{
	GtRelease(m_countdownView);
	GtRelease(m_roundRectView);
	m_textView.delegate = nil;
    GtRelease(m_textView);
	GtSuperDealloc();
}

#define kInset 5.0f

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	m_roundRectView.frameOptimizedForLocation = self.bounds;
	m_textView.frameOptimizedForLocation = CGRectInset(self.bounds, kInset, kInset);
	m_countdownView.frameOptimizedForLocation = GtRectJustifyRectInRectBottomRight(m_textView.frame, m_countdownView.frame);
	
	[self handleTextDidChange];
}

- (NSString*) text
{
    return m_textView.text;
}

- (void) setText:(NSString*) text
{
    m_textView.delegate = nil;

    if(text)
    {
        m_textView.text = text;
    }
    else
    {
        m_textView.text = @"";
    }
    
    m_textView.delegate = self;
    [self handleTextDidChange];
}

- (void) setTextDescriptor:(GtTextDescriptor *)textDescriptor
{
    m_textView.textDescriptor = textDescriptor;
}

- (GtTextDescriptor*) textDescriptor
{
    return m_textView.textDescriptor;
}




@end
