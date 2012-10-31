//
//	FLOldNotificationView.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//

#import "FLOldNotificationView.h"
#import "FLGeometry.h"
#import <QuartzCore/QuartzCore.h>
#import "FLSimpleHtmlView.h"
#import "FLHtmlStringBuilder.h"

@interface FLOldNotificationView (PrivateMethods)


//+ (void) recursiveDisable:(UIView*) view
//	disabledList:(NSMutableArray*) disabledList;

- (UILabel*) createTitleLabel:(FLRect) labelFrame;
	
@end

@implementation FLOldNotificationView

#define DEFAULT_LABEL_WIDTH 100.0
#define DEFAULT_LABEL_HEIGHT 30.0
#define HEIGHT_BUFFER 12.0
#define WIDTH_BUFFER 14.0

#define TEXT_TOP 12.0
#define TEXT_LEFT 12.0

#define OFFSCREEN_DIST 10

#define FADE_DURATION 0.2
#define POPINOUT_DURATION 0.3

#define MARGIN 5

@synthesize padding = _padding;
@synthesize shouldAutoCloseAfterDelayDelay = _shouldAutoCloseAfterDelayDelay;
@synthesize maxTextHeight = _maxHeight;
@synthesize notificationViewDelegate = _notificationViewDelegate;
@synthesize shownTimestamp = _shownTimestamp;
@synthesize showDelay = _showDelay;

FLSynthesizeStructProperty(dismissStyle, setDismissStyle, FLOldNotificationViewDismissStyle, _notificationViewFlags);
FLSynthesizeStructProperty(isHtml, setIsHtml, BOOL, _notificationViewFlags);
FLSynthesizeStructProperty(animationType, setAnimationType, FLViewAnimationType, _notificationViewFlags);
FLSynthesizeStructProperty(shouldAutoCloseAfterDelay, setShouldAutoCloseAfterDelay, BOOL, _notificationViewFlags);
FLSynthesizeStructProperty(isModal, setIsModal, BOOL, _notificationViewFlags);
FLSynthesizeStructProperty(notificationViewStyle, setNotificationViewStyle, FLOldNotificationViewStyle, _notificationViewFlags);

@synthesize textColor = _textColor;
@synthesize iconView = _iconView;
@synthesize text = _text;
@synthesize title = _title;
@synthesize roundRectView = _roundRectView;

- (void) setValueLabelText:(NSString*) text
{
	FLRetainObject_(_text, text);
	_notificationViewFlags.textNeedsUpdate = YES;
}

- (void) setText:(NSString*) text
{
	[self setValueLabelText:text];
}

- (void) setTitle:(NSString*) text
{
	FLRetainObject_(_title, text);
	_titleLabel.text = text;
}

- (void) applyTheme:(FLTheme*) theme
{
	[self setNotificationViewStyle:FLOldNotificationViewStyleSquareCorners];
	[self roundRectView].borderAlpha = 1.0;
	[self roundRectView].fillColor = [UIColor blackColor];
	[self roundRectView].borderColor = [UIColor grayColor];
	[self roundRectView].fillAlpha = 0.85;

	self.wantsApplyTheme = YES;

    self.layer.shadowColor = [UIColor blackColor].CGColor;
	self.layer.shadowOpacity = 1.0;
	self.layer.shadowRadius = 10.0;
	self.layer.shadowOffset = FLSizeMake(0,3);
	
	[[self roundRectView] setCornerRadius:0];
	[[self roundRectView] setBorderLineWidth:1.0];

#if VIEW_AUTOLAYOUT
	if(FLContentModesAreEqual([object autoLayoutMode], FLContentModeNone))
	{
		[object setAutoLayoutMode:FLContentModeMake(FLContentModeHorizontalFill,FLContentModeVerticalBottom)];
	}
#endif
}

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		_notificationViewFlags.textNeedsUpdate = YES;
		self.dismissStyle = FLOldNotificationViewDismissStyleNone;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = NO;
		
		self.textColor = [UIColor whiteColor];
		self.userInteractionEnabled = YES;
		self.exclusiveTouch = YES;
		
		self.maxTextHeight = FLT_MAX;
		self.shouldAutoCloseAfterDelayDelay = FLDefaultAutoCloseDelay;
		self.shouldAutoCloseAfterDelay = NO;
		
		self.backgroundColor = [UIColor clearColor];
		
		_padding = DeviceIsPad() ? 20.0 : 10.0;
		
		_roundRectView = [[FLRoundRectView alloc] initWithFrame:CGRectZero];
		[self addSubview:_roundRectView];
	}
   
	return self;
}

- (id) init
{
	if((self = [self initWithFrame:CGRectZero]))
	{
	}
	
	return self;
}

- (void) cancelTimer
{
	if(_timer)
	{
		[_timer invalidate];
		_timer = nil;
	}
}

- (void) releaseViews
{
	FLReleaseWithNil_(_roundRectView);
	FLReleaseWithNil_(_titleLabel);
	FLReleaseWithNil_(_closeButton);
	FLReleaseWithNil_(_iconView);
	FLReleaseWithNil_(_htmlView);
	FLReleaseWithNil_(_textView);
	FLReleaseWithNil_(_timeLabel);
	FLReleaseWithNil_(_closeBoxX);
	FLReleaseWithNil_(_closeBoxImageView);
}

- (void) removeViews
{	
	[_roundRectView removeFromSuperview];
	[_titleLabel removeFromSuperview];
	[_closeButton removeFromSuperview];
	[_iconView removeFromSuperview];
	[_htmlView removeFromSuperview];
	[_textView removeFromSuperview];
	[_timeLabel removeFromSuperview];
	[_closeBoxX removeFromSuperview];
	[_closeBoxImageView removeFromSuperview];
	[self releaseViews];
}

- (void)dealloc 
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];


	[self cancelTimer];
	
    mrc_release_(_text);
	mrc_release_(_textColor);
	mrc_release_(_title);
	mrc_release_(_oldBackgroundColor);
	mrc_release_(_oldTextColor);
	
	[self releaseViews];
	
	mrc_super_dealloc_();
}

- (void) notifyWasTouched
{
	if(!_notificationViewFlags.notifiedWasTouched)
	{
		_notificationViewFlags.notifiedWasTouched = YES;
			
		if(_notificationViewDelegate && [_notificationViewDelegate respondsToSelector:@selector(notificationViewWasTouched:)])
		{
			[_notificationViewDelegate notificationViewWasTouched:self];
		}
	}
	
	[self cancelTimer];
}

- (void) onClose:(id) sender
{
//	_weakRefContainer.object = nil;
	
	if(self.dismissStyle == FLOldNotificationViewDismissStyleTapAnywhere)
	{
		_roundRectView.fillColor = _oldBackgroundColor;
		FLReleaseWithNil_(_oldBackgroundColor);
		[_roundRectView setNeedsDisplay];
		_closeBoxImageView.alpha = 1.0;
	}

	if(_notificationViewDelegate && [_notificationViewDelegate respondsToSelector:@selector(notificationViewUserClosed:)])
	{
		[_notificationViewDelegate notificationViewUserClosed:self];
	}
	
	[self hideNotification];
}

- (void) onStartClose:(id) sender
{
	FLReleaseWithNil_(_oldBackgroundColor);
	FLReleaseWithNil_(_oldTextColor);

	if(self.dismissStyle == FLOldNotificationViewDismissStyleTapAnywhere)
	{
		_oldBackgroundColor = retain_(self.backgroundColor);
		_closeBoxImageView.alpha = .3;
		_roundRectView.fillColor = [UIColor iPhoneBlueColor];
		[_roundRectView setNeedsDisplay];
	}

	[self notifyWasTouched];
}

+ (UIImage*) closeBoxIcon
{
	static UIImage* s_image = nil;
	if(!s_image)
	{
		s_image = [UIImage imageNamed:@"close-box-white-fill.png"];
        mrc_retain_(s_image);
	}
	
	return s_image;
}

- (void) setBoundsToHeight:(CGFloat) height
{
	FLRect frame = self.frame;
	frame.size.height = height;
	self.frameOptimizedForSize = frame;
}

- (void) startAutoCloseTimer
{
	if(_shouldAutoCloseAfterDelayDelay && self.shouldAutoCloseAfterDelay)
	{
		_timer = [NSTimer timerWithTimeInterval:_shouldAutoCloseAfterDelayDelay
			target:self 
			selector:@selector(hideNotification) 
			userInfo:nil 
			repeats:NO];
		[[NSRunLoop mainRunLoop] addTimer:_timer 
			forMode:NSRunLoopCommonModes];
	}
}

- (CGFloat) calculateArrangementSize
{
	CGFloat height = self.frame.size.height;

	if(_textView)
	{
		height = FLRectGetBottom(_textView.frame) + _padding; //6;
	}
	else if(_htmlView)
	{
		height = FLRectGetBottom(_htmlView.frame) + _padding; //6;
	}
	else if(_iconView)
	{
		height = FLRectGetBottom(_iconView.frame) + _padding; // 12
	}
	else if(_titleLabel)
	{
		height = FLRectGetBottom(_titleLabel.frame) + _padding; //6
	}

	return height;
}

- (BOOL) quickCheckForElements:(NSString*) possibleHtml
{
	NSInteger openBrace = [possibleHtml rangeOfString:@"<"].location;
	return openBrace >= 0 && openBrace < (NSInteger) [possibleHtml rangeOfString:@">"].location;
}

- (BOOL)simpleHtmlView:(FLSimpleHtmlView *)view 
	shouldStartLoadWithRequest:(NSURLRequest *)request 
				navigationType:(UIWebViewNavigationType)navigationType
{
	switch(navigationType)
    {
        case UIWebViewNavigationTypeLinkClicked:
        case UIWebViewNavigationTypeFormSubmitted:
        case UIWebViewNavigationTypeBackForward:
        case UIWebViewNavigationTypeReload:
        case UIWebViewNavigationTypeFormResubmitted:
            [[UIApplication sharedApplication] openUrlInSafari:request.URL errorMessage:NSLocalizedString(@"There may be a problem with the URL or access to Safari may be restricted", nil)];
            return NO;
            break;
        
        
        case UIWebViewNavigationTypeOther:
            return YES;
            break;

    }
    
	return NO;
}

- (UIFont*) textViewFont
{
// watch out for hardcoding of bold in css below
	if(DeviceIsPad())
	{
		return [UIFont systemFontOfSize:[UIFont systemFontSize]];
	}

	return [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
}

- (NSString*) htmlDocument
{
	UIFont* font = self.textViewFont;
	NSString* colorHex = [self.textColor toHexString:YES];
	NSString* linkColorHex = [[UIColor lightSkyBlueColor] toHexString:YES];
	
	FLHtmlStringBuilder* builder = [FLHtmlStringBuilder htmlStringBuilder:FLXmlDocTypeHtml4_01Strict];
    [builder.htmlElement appendLine:@"<meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no\">"];
//    <meta name='viewport' content='width=device-width; initial-scale=1.0; maximum-scale=1.0;'>"];
//	  text-shadow: #6374AB 20px -12px 2px

    FLXmlElement* style = [builder.headElement addElement:@"style"];
    [style setAttribute:@"text/css" forKey:@"type"];
    [style appendFormat:@"body { color: %@; font-family:'%@'; font-size:%dpx;", colorHex, font.familyName, (int) (font.pointSize)];
    if(!DeviceIsPad()) {
        [style appendFormat:@" font-weight:bold;"]; //font-weight:bold;
    }
    [style appendFormat:@"-webkit-text-size-adjust: none; padding: 0px; margin: 0px; text-shadow: black 0px 0px 0px; }"];
    [style appendFormat:@"a:link { color:%@; }", linkColorHex];
    [style appendFormat:@"a:visited { color:%@; }", linkColorHex];

    FLXmlElement* div = [builder.bodyElement addDiv];
    [div appendString:[self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
  
	return [builder buildString];
}

- (void) createViews
{
	if(_iconView && _iconView.superview != self)
	{
		[self addSubview:_iconView];
	}
	
	if(self.dismissStyle != FLOldNotificationViewDismissStyleNone)
	{
		_closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        mrc_retain_(_closeButton);
        
		_closeButton.backgroundColor = [UIColor clearColor];
		[_closeButton addTarget:self action:@selector(onStartClose:) forControlEvents:UIControlEventTouchDown];
		[_closeButton addTarget:self action:@selector(onClose:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
		_closeButton.showsTouchWhenHighlighted = 
			self.dismissStyle == FLOldNotificationViewDismissStyleCloseBox;
		[self addSubview:_closeButton];
		
		_closeBoxX = [[UILabel alloc] initWithFrame:CGRectZero];
		_closeBoxX.text = @"x";
		_closeBoxX.font = [UIFont systemFontOfSize:[UIFont buttonFontSize]];
		_closeBoxX.backgroundColor = [UIColor clearColor];
		_closeBoxX.textColor = [UIColor whiteColor];
		[self insertSubview:_closeBoxX aboveSubview:_roundRectView];
		[_closeBoxX sizeToFitText];
	}
	
	if(!FLStringIsEmpty(_title))
	{
		_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		_titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
		_titleLabel.textColor = [UIColor whiteColor];
		_titleLabel.shadowColor = [UIColor blackColor];
		_titleLabel.shadowOffset	 = FLSizeMake (0.0, 0.0);
		_titleLabel.backgroundColor = [UIColor clearColor];
		_titleLabel.textAlignment = UITextAlignmentLeft;
		_titleLabel.font = [self textViewFont];
		_titleLabel.numberOfLines = 1;

		[self addSubview:_titleLabel];
	}	  
	
	if(FLStringIsNotEmpty(self.text))
	{
		if(self.isHtml /* && [self quickCheckForElements:self.text]*/)
		{
			_htmlView = [[FLSimpleHtmlView alloc] initWithFrame:CGRectZero];
				
			[_htmlView setIsTransparent];
			_htmlView.simpleHtmlViewDelegate = self;
			[self addSubview:_htmlView];
								
			_htmlView.clipsToBounds = YES; // draws out of bounds on rotate
		}
		else
		{
			_textView = [[UILabel alloc] initWithFrame:CGRectZero];
			_textView.lineBreakMode = UILineBreakModeWordWrap;
			_textView.textColor = self.textColor;
			_textView.backgroundColor = [UIColor clearColor];
			_textView.textAlignment = UITextAlignmentLeft;
			_textView.numberOfLines = 0;
			_textView.font	 = [self textViewFont];
			_textView.shadowOffset	   = FLSizeMake (0.0, 0.0);
			_textView.shadowColor = [UIColor blackColor];
			_textView.autoresizingMask = UIViewAutoresizingNone;
			[self addSubview:_textView];
		}
	} 

	if(_closeButton)
	{
		[_closeButton.superview bringSubviewToFront:_closeButton];
	}

	[self setNeedsLayout];
}

- (BOOL) updateSize
{
    return NO;

#if VIEW_AUTOLAYOUT

	FLRect containerBounds = FLViewContentsDescriptorCalculateContainerRect(self.superview.bounds, self.superviewContentsDescriptor);
	FLRect newFrame = self.frame;
	
	if(newFrame.size.width == 0)
	{
		newFrame = FLRectSetWidth(self.frame, containerBounds.size.width);
	}
	
	if(self.notificationViewStyle == FLOldNotificationViewStyleRoundedCorners)
	{
		newFrame.size.width -= (MARGIN*2);
	}
	
	FLRect textFrame = CGRectIntegral(FLRectSetHeight(FLRectMakeWithSize(newFrame.size), 10));
	
	if(_titleLabel)
	{
		_titleLabel.text = _title;
		
		[_titleLabel sizeToFitText:FLSizeMake(newFrame.size.width, CGFLOAT_MAX)];
		FLRect labelFrame = _titleLabel.frame;
		labelFrame = FLRectSetOrigin(labelFrame, 0,0);
		labelFrame.size.width = newFrame.size.width;
		
		if(_iconView)
		{
			_iconView.newFrame = FLRectSetOrigin(_iconView.frame, _padding, 10);
			
			labelFrame = FLRectInsetLeft(labelFrame, FLRectGetRight(_iconView.frame));
			labelFrame = FLRectAlignRectsHorizonally(_iconView.frame, labelFrame);
			labelFrame = FLRectInsetLeft(labelFrame, 5);
			labelFrame = FLRectSetTop(labelFrame, 12);
		}
		else
		{
			labelFrame = CGRectInset(labelFrame, 10, 0);
			labelFrame = FLRectSetTop(labelFrame, 6);
		}
		
		_titleLabel.frameOptimizedForSize = labelFrame;
		textFrame.origin.y = FLRectGetBottom(_titleLabel.frame);
	}
	else
	{
		textFrame.origin.y = 6;
	}
	
	textFrame = CGRectIntegral(CGRectInset(textFrame, _padding, 0));
	textFrame.origin.y += 4;
	
	if(DeviceIsPad())
	{
		textFrame.origin.y += 10;
	}
	
	CGFloat titleHeight = (_titleLabel ? _titleLabel.frame.size.height : 0);
	CGFloat maxHeight = containerBounds.size.height - titleHeight - 16;
	
	textFrame.size.height = maxHeight;
	
	// update text/htmlElement view
	if(_textView)
	{
		_textView.frameOptimizedForSize = textFrame;
		_textView.text = [self.text trimmedString];
		[_textView sizeToFit];
	}
	else if(_htmlView)
	{
		if(_notificationViewFlags.textNeedsUpdate)
		{
			[_htmlView beginLoadingHtmlStringDocument:self.htmlDocument spinnerStyle:UIActivityIndicatorViewStyleWhite];
		}
	
		if(_htmlView.isLoaded)
		{
			[_htmlView setSizeToLoadedSizeWithMaxSize:FLSizeMake(textFrame.size.width, maxHeight)];
		}
		else
		{
			// 18 will be changed upon loading callback, so hardcoding ok for now.
			textFrame.size.height = MAX(18, _htmlView.frame.size.height);
			_htmlView.frameOptimizedForSize = textFrame;
		}
	}
	
	_notificationViewFlags.textNeedsUpdate = NO;
	
	// did height change? if so resize.	   
	newFrame.size.height = [self calculateArrangementSize];
	
	BOOL changedFrame = [self setFrameIfChanged:newFrame];
	
	// close box image
	if(_closeBoxImageView)
	{
		_closeBoxImageView.frameOptimizedForSize = FLRectCenterOnPoint(_closeBoxImageView.frame, 
			CGPointMake(self.bounds.size.width-8, 6));
	}
	
	if(_closeBoxX)
	{
		if(DeviceIsPad())
		{
			_closeBoxX.frameOptimizedForSize = FLRectMove(FLRectJustifyRectInRectTopRight(self.bounds, _closeBoxX.frame), -6, 2);
		}
		else
		{
			_closeBoxX.frameOptimizedForSize = FLRectMove(FLRectJustifyRectInRectTopRight(self.bounds, _closeBoxX.frame), -2, -3);
		}
	}
	
	if(self.dismissStyle == FLOldNotificationViewDismissStyleCloseBox)
	{
		_closeButton.frameOptimizedForSize = FLRectCenterOnPoint(CGRectMake(0, 0, 120, 120), FLRectGetCenter(_closeBoxX.frame));
	}
	else if(self.dismissStyle == FLOldNotificationViewDismissStyleTapAnywhere)
	{
		_closeButton.frameOptimizedForSize = self.bounds;
	}
	
	_roundRectView.newFrame = self.bounds;


	return changedFrame;
#endif
}

- (void) showSelf:(id) sender
{	
	self.hidden = NO;
	[self updateSize];
#if VIEW_AUTOLAYOUT
	FLViewSetPositionInSuperview(self);
#endif
	
//	  [self updateSizeAndPositionInContainerView:self.findContainerView];
	[self animateOntoScreen:self.animationType duration:0.25f finishedBlock:nil];

	[self startAutoCloseTimer];

	if(_notificationViewDelegate && [_notificationViewDelegate respondsToSelector:@selector(notificationViewDidShow:)])
	{
		[_notificationViewDelegate notificationViewDidShow:self];
	}

	_shownTimestamp = [NSDate timeIntervalSinceReferenceDate];
}

- (void) simpleHtmlView:(FLSimpleHtmlView*) view didFinishLoading:(NSError*) error
{
	if(!error)
	{
		[self updateSize];
#if VIEW_AUTOLAYOUT
		FLViewSetPositionInSuperview(self);
#endif        
	//	  [self updateSizeAndPositionInContainerView:self.findContainerView];
	}
#if DEBUG
	else
	{
		FLLog(@"htmlElement view failed to load: %@", error);
	}
#endif 
}

#if VIEW_AUTOLAYOUT
- (void) layoutSubviews
{
	[super layoutSubviews];
	if([self updateSize])
	{
		FLViewSetPositionInSuperview(self);
	}
}
#endif

- (void)didMoveToSuperview
{
	if(self.superview)
	{
		[self applyThemeIfNeeded];
		
		if(self.frame.size.width == 0.0f)
		{
			FLRect rect = self.frame;
			rect.size.height = 32; // non zero starting point only, will be recaculated later.
			rect.size.width = self.superview.bounds.size.width - (MARGIN*2);
			self.frame = rect;
		}
		
		if(!_notificationViewFlags.created)
		{
			_notificationViewFlags.created = YES;

			[self applyThemeIfNeeded];
			
			[self createViews];
			
			self.hidden = YES;
		
			if(_showDelay > 0)
			{
				[self performSelector:@selector(showSelf:) withObject:nil afterDelay:_showDelay];	  
			}
			else
			{
				[self showSelf:nil];
			}
		}
	} 
	else if(_htmlView)
	{
		[_htmlView stopLoading];
	}
	
	[super didMoveToSuperview];
}

- (void) hideNotification
{
	if(self.superview)
	{
		if(_htmlView)
		{
			[_htmlView stopLoading];
		}
	
		if(_notificationViewDelegate && [_notificationViewDelegate respondsToSelector:@selector(notificationViewWillHide:)])
		{
			[_notificationViewDelegate notificationViewWillHide:self];
		}
		_notificationViewDelegate = nil;

		[self cancelTimer];
		
		[self removeFromSuperviewWithAnimationType:self.animationType duration:0.25f finishedBlock:nil];
	}
}

//- (void) close
//{
//	  [self hide];
//}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self notifyWasTouched];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void)touchesCancelled:(NSSet *)touches 
	withEvent:(UIEvent *)event
{
}

- (void) webViewTouchesBegan:(UIWebView*) webView touches:(NSSet *)touches withEvent:(UIEvent *)event
{
	[self notifyWasTouched];
}

- (void) webViewTouchesMoved:(UIWebView*) webView touches:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void) webViewTouchesEnded:(UIWebView*) webView touches:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void) webViewTouchesCancelled:(UIWebView*) webView touches:(NSSet *)touches withEvent:(UIEvent *)event
{
}

- (void) webViewTouchesStationaryTouch:(UIWebView*) webView touches:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end

