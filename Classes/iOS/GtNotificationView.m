//
//	GtNotificationView.m
//	FishLamp
//
//	Created by Mike Fullerton on 5/22/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtNotificationView.h"
#import "GtGeometry.h"
#import <QuartzCore/QuartzCore.h>
#import "GtSimpleHtmlView.h"
#import "GtViewFader.h"
#import "GtMobileNotificationDisplayManager.h"

@interface GtNotificationView (PrivateMethods)


//+ (void) recursiveDisable:(UIView*) view
//	disabledList:(NSMutableArray*) disabledList;

- (UILabel*) createTitleLabel:(CGRect) labelFrame;
	
@end

@implementation GtNotificationView

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

@synthesize padding = m_padding;
@synthesize shouldAutoCloseAfterDelayDelay = m_shouldAutoCloseAfterDelayDelay;
@synthesize maxTextHeight = m_maxHeight;
@synthesize notificationViewDelegate = m_notificationViewDelegate;
@synthesize shownTimestamp = m_shownTimestamp;
@synthesize showDelay = m_showDelay;

GtSynthesizeStructProperty(dismissStyle, setDismissStyle, GtNotificationViewDismissStyle, m_notificationViewFlags);
GtSynthesizeStructProperty(isHtml, setIsHtml, BOOL, m_notificationViewFlags);
GtSynthesizeStructProperty(animationType, setAnimationType, GtViewAnimationType, m_notificationViewFlags);
GtSynthesizeStructProperty(shouldAutoCloseAfterDelay, setShouldAutoCloseAfterDelay, BOOL, m_notificationViewFlags);
GtSynthesizeStructProperty(isModal, setIsModal, BOOL, m_notificationViewFlags);
GtSynthesizeStructProperty(notificationViewStyle, setNotificationViewStyle, GtNotificationViewStyle, m_notificationViewFlags);

@synthesize textColor = m_textColor;
@synthesize iconView = m_iconView;
@synthesize text = m_text;
@synthesize title = m_title;
@synthesize roundRectView = m_roundRectView;

- (void) setValueLabelText:(NSString*) text
{
	if(GtAssignObject(m_text, text))
	{
		m_notificationViewFlags.textNeedsUpdate = YES;
	}
}

- (void) setText:(NSString*) text
{
	[self setValueLabelText:text];
}

- (void) setTitle:(NSString*) text
{
	if(GtAssignObject(m_title, text) && m_titleLabel)
	{
		m_titleLabel.text = text;
	}
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.themeAction = @selector(applyThemeToNotificationViewController:);
		m_notificationViewFlags.textNeedsUpdate = YES;
		self.dismissStyle = GtNotificationViewDismissStyleNone;
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = NO;
		
		self.textColor = [UIColor whiteColor];
		self.userInteractionEnabled = YES;
		self.exclusiveTouch = YES;
		
		self.maxTextHeight = INT_MAX;
		self.shouldAutoCloseAfterDelayDelay = GtDefaultAutoCloseDelay;
		self.shouldAutoCloseAfterDelay = NO;
		
		self.backgroundColor = [UIColor clearColor];
		
		m_padding = DeviceIsPad() ? 20.0 : 10.0;
		
		m_roundRectView = [[GtRoundRectView alloc] initWithFrame:CGRectZero];
		[self addSubview:m_roundRectView];
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
	if(m_timer)
	{
		[m_timer invalidate];
		m_timer = nil;
	}
}

- (void) releaseViews
{
	GtReleaseWithNil(m_roundRectView);
	GtReleaseWithNil(m_titleLabel);
	GtReleaseWithNil(m_closeButton);
	GtReleaseWithNil(m_iconView);
	GtReleaseWithNil(m_htmlView);
	GtReleaseWithNil(m_textView);
	GtReleaseWithNil(m_timeLabel);
	GtReleaseWithNil(m_closeBoxX);
	GtReleaseWithNil(m_closeBoxImageView);
}

- (void) removeViews
{	
	[m_roundRectView removeFromSuperview];
	[m_titleLabel removeFromSuperview];
	[m_closeButton removeFromSuperview];
	[m_iconView removeFromSuperview];
	[m_htmlView removeFromSuperview];
	[m_textView removeFromSuperview];
	[m_timeLabel removeFromSuperview];
	[m_closeBoxX removeFromSuperview];
	[m_closeBoxImageView removeFromSuperview];
	[self releaseViews];
}

- (void)dealloc 
{
	[NSObject cancelPreviousPerformRequestsWithTarget:self];


	[self cancelTimer];
	
    GtRelease(m_text);
	GtRelease(m_textColor);
	GtRelease(m_title);
	GtRelease(m_oldBackgroundColor);
	GtRelease(m_oldTextColor);
	
	[self releaseViews];
	
	GtSuperDealloc();
}

- (void) notifyWasTouched
{
	if(!m_notificationViewFlags.notifiedWasTouched)
	{
		m_notificationViewFlags.notifiedWasTouched = YES;
			
		if(m_notificationViewDelegate && [m_notificationViewDelegate respondsToSelector:@selector(notificationViewWasTouched:)])
		{
			[m_notificationViewDelegate notificationViewWasTouched:self];
		}
	}
	
	[self cancelTimer];
}

- (void) onClose:(id) sender
{
//	m_weakRefContainer.object = nil;
	
	if(self.dismissStyle == GtNotificationViewDismissStyleTapAnywhere)
	{
		m_roundRectView.fillColor = m_oldBackgroundColor;
		GtReleaseWithNil(m_oldBackgroundColor);
		[m_roundRectView setNeedsDisplay];
		m_closeBoxImageView.alpha = 1.0;
	}

	if(m_notificationViewDelegate && [m_notificationViewDelegate respondsToSelector:@selector(notificationViewUserClosed:)])
	{
		[m_notificationViewDelegate notificationViewUserClosed:self];
	}
	
	[self hideNotification];
}

- (void) onStartClose:(id) sender
{
	GtReleaseWithNil(m_oldBackgroundColor);
	GtReleaseWithNil(m_oldTextColor);

	if(self.dismissStyle == GtNotificationViewDismissStyleTapAnywhere)
	{
		m_oldBackgroundColor = GtRetain(self.backgroundColor);
		m_closeBoxImageView.alpha = .3;
		m_roundRectView.fillColor = [UIColor iPhoneBlueColor];
		[m_roundRectView setNeedsDisplay];
	}

	[self notifyWasTouched];
}

+ (UIImage*) closeBoxIcon
{
	static UIImage* s_image = nil;
	if(!s_image)
	{
		s_image = [[UIImage imageNamed:@"close-box-white-fill.png"] retain];
	}
	
	return s_image;
}

- (void) setBoundsToHeight:(CGFloat) height
{
	CGRect frame = self.frame;
	frame.size.height = height;
	self.frameOptimizedForSize = frame;
}

- (void) startAutoCloseTimer
{
	if(m_shouldAutoCloseAfterDelayDelay && self.shouldAutoCloseAfterDelay)
	{
		m_timer = [NSTimer timerWithTimeInterval:m_shouldAutoCloseAfterDelayDelay
			target:self 
			selector:@selector(hideNotification) 
			userInfo:nil 
			repeats:NO];
		[[NSRunLoop mainRunLoop] addTimer:m_timer 
			forMode:NSRunLoopCommonModes];
	}
}

- (CGFloat) calculateHeight
{
	CGFloat height = self.frame.size.height;

	if(m_textView)
	{
		height = GtRectGetBottom(m_textView.frame) + m_padding; //6;
	}
	else if(m_htmlView)
	{
		height = GtRectGetBottom(m_htmlView.frame) + m_padding; //6;
	}
	else if(m_iconView)
	{
		height = GtRectGetBottom(m_iconView.frame) + m_padding; // 12
	}
	else if(m_titleLabel)
	{
		height = GtRectGetBottom(m_titleLabel.frame) + m_padding; //6
	}

	return height;
}

- (BOOL) quickCheckForElements:(NSString*) possibleHtml
{
	NSInteger openBrace = [possibleHtml rangeOfString:@"<"].location;
	return openBrace >= 0 && openBrace < (NSInteger) [possibleHtml rangeOfString:@">"].location;
}

- (BOOL)simpleHtmlView:(GtSimpleHtmlView *)view 
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
	
	GtHtmlBuilder* builder = [[GtHtmlBuilder alloc] initWithPrettyPrint:NO];
	
	NSString* colorHex = [self.textColor toHexString:YES];
	NSString* linkColorHex = [[UIColor lightSkyBlueColor] toHexString:YES];

	[builder openDocument];
	
	[builder openHeadElement];
	[builder appendString:@"<meta name = \"viewport\" content = \"initial-scale = 1.0, user-scalable = no\">"];
//    <meta name='viewport' content='width=device-width; initial-scale=1.0; maximum-scale=1.0;'>"];
	
	//	  text-shadow: #6374AB 20px -12px 2px
	
	[builder pushAttributeString:@"text/css" attributeName:@"type"];
	[builder openElement:@"style"];
	[builder appendFormat:@"body { color: %@; font-family:'%@'; font-size:%dpx;", colorHex, font.familyName, (int) (font.pointSize)];
	if(!DeviceIsPad())
	{
		[builder appendFormat:@" font-weight:bold;"]; //font-weight:bold;
	}
	
	[builder appendFormat:@"-webkit-text-size-adjust: none; padding: 0px; margin: 0px; text-shadow: black 0px 0px 0px; }"];
	[builder appendFormat:@"a:link { color:%@; }", linkColorHex];
	[builder appendFormat:@"a:visited { color:%@; }", linkColorHex];
	[builder closeElement];
	
	[builder closeElement];
	[builder openBodyElement];
	[builder openDivElement];
	[builder appendString:[self.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
	[builder closeElement];
	
	[builder closeElement]; // body
	
	[builder closeDocument];
	NSString* document = [builder buildString];
	GtRelease(builder);
	
	return document;
}

- (void) createViews
{
	if(m_iconView && m_iconView.superview != self)
	{
		[self addSubview:m_iconView];
	}
	
	if(self.dismissStyle != GtNotificationViewDismissStyleNone)
	{
		m_closeButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
		m_closeButton.backgroundColor = [UIColor clearColor];
		[m_closeButton addTarget:self action:@selector(onStartClose:) forControlEvents:UIControlEventTouchDown];
		[m_closeButton addTarget:self action:@selector(onClose:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
		m_closeButton.showsTouchWhenHighlighted = 
			self.dismissStyle == GtNotificationViewDismissStyleCloseBox;
		[self addSubview:m_closeButton];
		
		m_closeBoxX = [[UILabel alloc] initWithFrame:CGRectZero];
		m_closeBoxX.text = @"x";
		m_closeBoxX.font = [UIFont systemFontOfSize:[UIFont buttonFontSize]];
		m_closeBoxX.backgroundColor = [UIColor clearColor];
		m_closeBoxX.textColor = [UIColor whiteColor];
		[self insertSubview:m_closeBoxX aboveSubview:m_roundRectView];
		[m_closeBoxX sizeToFitText];
	}
	
	if(!GtStringIsEmpty(m_title))
	{
		m_titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		m_titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
		m_titleLabel.textColor = [UIColor whiteColor];
		m_titleLabel.shadowColor = [UIColor blackColor];
		m_titleLabel.shadowOffset	 = CGSizeMake (0.0, 0.0);
		m_titleLabel.backgroundColor = [UIColor clearColor];
		m_titleLabel.textAlignment = UITextAlignmentLeft;
		m_titleLabel.font = [self textViewFont];
		m_titleLabel.numberOfLines = 1;

		[self addSubview:m_titleLabel];
	}	  
	
	if(GtStringIsNotEmpty(self.text))
	{
		if(self.isHtml /* && [self quickCheckForElements:self.text]*/)
		{
			m_htmlView = [[GtSimpleHtmlView alloc] initWithFrame:CGRectZero];
				
			[m_htmlView setIsTransparent];
			m_htmlView.simpleHtmlViewDelegate = self;
			[self addSubview:m_htmlView];
								
			m_htmlView.clipsToBounds = YES; // draws out of bounds on rotate
		}
		else
		{
			m_textView = [[UILabel alloc] initWithFrame:CGRectZero];
			m_textView.lineBreakMode = UILineBreakModeWordWrap;
			m_textView.textColor = self.textColor;
			m_textView.backgroundColor = [UIColor clearColor];
			m_textView.textAlignment = UITextAlignmentLeft;
			m_textView.numberOfLines = 0;
			m_textView.font	 = [self textViewFont];
			m_textView.shadowOffset	   = CGSizeMake (0.0, 0.0);
			m_textView.shadowColor = [UIColor blackColor];
			m_textView.autoresizingMask = UIViewAutoresizingNone;
			[self addSubview:m_textView];
		}
	} 

	if(m_closeButton)
	{
		[m_closeButton.superview bringSubviewToFront:m_closeButton];
	}

	[self setNeedsLayout];
}

- (BOOL) updateSize
{
    return NO;

#if VIEW_AUTOLAYOUT

	CGRect containerBounds = GtViewContentsDescriptorCalculateContainerRect(self.superview.bounds, [self.viewDelegate viewGetSuperviewContentsDescriptor:self]);
	CGRect newFrame = self.frame;
	
	if(newFrame.size.width == 0)
	{
		newFrame = GtRectSetWidth(self.frame, containerBounds.size.width);
	}
	
	if(self.notificationViewStyle == GtNotificationViewStyleRoundedCorners)
	{
		newFrame.size.width -= (MARGIN*2);
	}
	
	CGRect textFrame = CGRectIntegral(GtRectSetHeight(GtRectMakeWithSize(newFrame.size), 10));
	
	if(m_titleLabel)
	{
		m_titleLabel.text = m_title;
		
		[m_titleLabel sizeToFitText:CGSizeMake(newFrame.size.width, CGFLOAT_MAX)];
		CGRect labelFrame = m_titleLabel.frame;
		labelFrame = GtRectSetOrigin(labelFrame, 0,0);
		labelFrame.size.width = newFrame.size.width;
		
		if(m_iconView)
		{
			m_iconView.newFrame = GtRectSetOrigin(m_iconView.frame, m_padding, 10);
			
			labelFrame = GtRectInsetLeft(labelFrame, GtRectGetRight(m_iconView.frame));
			labelFrame = GtRectAlignRectsHorizonally(m_iconView.frame, labelFrame);
			labelFrame = GtRectInsetLeft(labelFrame, 5);
			labelFrame = GtRectSetTop(labelFrame, 12);
		}
		else
		{
			labelFrame = CGRectInset(labelFrame, 10, 0);
			labelFrame = GtRectSetTop(labelFrame, 6);
		}
		
		m_titleLabel.frameOptimizedForSize = labelFrame;
		textFrame.origin.y = GtRectGetBottom(m_titleLabel.frame);
	}
	else
	{
		textFrame.origin.y = 6;
	}
	
	textFrame = CGRectIntegral(CGRectInset(textFrame, m_padding, 0));
	textFrame.origin.y += 4;
	
	if(DeviceIsPad())
	{
		textFrame.origin.y += 10;
	}
	
	CGFloat titleHeight = (m_titleLabel ? m_titleLabel.frame.size.height : 0);
	CGFloat maxHeight = containerBounds.size.height - titleHeight - 16;
	
	textFrame.size.height = maxHeight;
	
	// update text/html view
	if(m_textView)
	{
		m_textView.frameOptimizedForSize = textFrame;
		m_textView.text = [self.text trimmedString];
		[m_textView sizeToFit];
	}
	else if(m_htmlView)
	{
		if(m_notificationViewFlags.textNeedsUpdate)
		{
			[m_htmlView beginLoadingHtmlStringDocument:self.htmlDocument spinnerStyle:UIActivityIndicatorViewStyleWhite];
		}
	
		if(m_htmlView.isLoaded)
		{
			[m_htmlView setSizeToLoadedSizeWithMaxSize:CGSizeMake(textFrame.size.width, maxHeight)];
		}
		else
		{
			// 18 will be changed upon loading callback, so hardcoding ok for now.
			textFrame.size.height = MAX(18, m_htmlView.frame.size.height);
			m_htmlView.frameOptimizedForSize = textFrame;
		}
	}
	
	m_notificationViewFlags.textNeedsUpdate = NO;
	
	// did height change? if so resize.	   
	newFrame.size.height = [self calculateHeight];
	
	BOOL changedFrame = [self setFrameIfChanged:newFrame];
	
	// close box image
	if(m_closeBoxImageView)
	{
		m_closeBoxImageView.frameOptimizedForSize = GtRectCenterOnPoint(m_closeBoxImageView.frame, 
			CGPointMake(self.bounds.size.width-8, 6));
	}
	
	if(m_closeBoxX)
	{
		if(DeviceIsPad())
		{
			m_closeBoxX.frameOptimizedForSize = GtRectMove(GtRectJustifyRectInRectTopRight(self.bounds, m_closeBoxX.frame), -6, 2);
		}
		else
		{
			m_closeBoxX.frameOptimizedForSize = GtRectMove(GtRectJustifyRectInRectTopRight(self.bounds, m_closeBoxX.frame), -2, -3);
		}
	}
	
	if(self.dismissStyle == GtNotificationViewDismissStyleCloseBox)
	{
		m_closeButton.frameOptimizedForSize = GtRectCenterOnPoint(CGRectMake(0, 0, 120, 120), GtRectGetCenter(m_closeBoxX.frame));
	}
	else if(self.dismissStyle == GtNotificationViewDismissStyleTapAnywhere)
	{
		m_closeButton.frameOptimizedForSize = self.bounds;
	}
	
	m_roundRectView.newFrame = self.bounds;


	return changedFrame;
#endif
}

- (void) showSelf:(id) sender
{	
	self.hidden = NO;
	[self updateSize];
#if VIEW_AUTOLAYOUT
	GtViewSetPositionInSuperview(self);
#endif
	
//	  [self updateSizeAndPositionInContainerView:self.findContainerView];
	[self animateOntoScreen:self.animationType duration:0.25f finishedBlock:nil];

	[self startAutoCloseTimer];

	if(m_notificationViewDelegate && [m_notificationViewDelegate respondsToSelector:@selector(notificationViewDidShow:)])
	{
		[m_notificationViewDelegate notificationViewDidShow:self];
	}

	m_shownTimestamp = [NSDate timeIntervalSinceReferenceDate];
}

- (void) simpleHtmlView:(GtSimpleHtmlView*) view didFinishLoading:(NSError*) error
{
	if(!error)
	{
		[self updateSize];
#if VIEW_AUTOLAYOUT
		GtViewSetPositionInSuperview(self);
#endif        
	//	  [self updateSizeAndPositionInContainerView:self.findContainerView];
	}
#if DEBUG
	else
	{
		GtLog(@"Html view failed to load: %@", error);
	}
#endif 
}

#if VIEW_AUTOLAYOUT
- (void) layoutSubviews
{
	[super layoutSubviews];
	if([self updateSize])
	{
		GtViewSetPositionInSuperview(self);
	}
}
#endif

- (void)didMoveToSuperview
{
	if(self.superview)
	{
		[self applyTheme];
		
		if(self.frame.size.width == 0)
		{
			CGRect rect = self.frame;
			rect.size.height = 32; // non zero starting point only, will be recaculated later.
			rect.size.width = self.superview.bounds.size.width - (MARGIN*2);
			self.frame = rect;
		}
		
		if(!m_notificationViewFlags.created)
		{
			m_notificationViewFlags.created = YES;

			[self applyTheme];
			
			[self createViews];
			
			self.hidden = YES;
		
			if(m_showDelay > 0)
			{
				[self performSelector:@selector(showSelf:) withObject:nil afterDelay:m_showDelay];	  
			}
			else
			{
				[self showSelf:nil];
			}
		}
	} 
	else if(m_htmlView)
	{
		[m_htmlView stopLoading];
	}
	
	[super didMoveToSuperview];
}

- (void) hideNotification
{
	if(self.superview)
	{
		if(m_htmlView)
		{
			[m_htmlView stopLoading];
		}
	
		if(m_notificationViewDelegate && [m_notificationViewDelegate respondsToSelector:@selector(notificationViewWillHide:)])
		{
			[m_notificationViewDelegate notificationViewWillHide:self];
		}
		m_notificationViewDelegate = nil;

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


@interface GtDeferShowNotification : GtFunctor {
@private
    GtNotificationViewController* _notification;
    GtViewController* _viewController;
}

+ (id) deferShowNotificationInViewController:(GtViewController*) viewController 
                                notification:(GtNotificationViewController*) notification;
@end


@implementation GtDeferShowNotification

- (void) doPerformCallback:(id) sender
{
    [_notification showNotificationInViewController:_viewController];
}

- (id) initWithViewController:(GtViewController*) viewController 
                 notification:(GtNotificationViewController*) notification {	
                 
	self = [super init];
	if(self) {
		_viewController = viewController;
        _notification = [notification retain];
	}
	return self;
}

- (void) dealloc {
	[_notification release];
	[super dealloc];
}


+ (id) deferShowNotificationInViewController:(GtViewController*) viewController 
                                notification:(GtNotificationViewController*) notification {
   return [[[GtDeferShowNotification alloc] initWithViewController:viewController notification:notification] autorelease];
}

@end


@implementation GtNotificationViewController    
- (id) initWithNotificationView:(GtNotificationView*) view {
    return [super initWithView:view];
}
+ (id) notificationViewController:(GtNotificationView*) view {
    return [[[[self class] alloc] init] autorelease];
}
- (GtNotificationView*) notificationView {
    return (GtNotificationView*) self.view;
}

- (void) setTitle:(NSString*) title {
    [super setTitle:title];
    self.notificationView.title = title;
}

// FIXME
- (void) showNotification {
}

- (void) hideNotification {
}

- (void) showNotificationInViewController:(UIViewController*) viewControllerOrNil {
    
    if(!viewControllerOrNil)
	{
		viewControllerOrNil = [[GtMobileNotificationDisplayManager defaultDisplayManager] defaultViewController];
	}

	[viewControllerOrNil.view addSubview:self.view];

// FIXME - add child view controller
}

- (void) showDeferredNotificationInViewController:(GtViewController*) viewControllerOrNil
{
    if(!viewControllerOrNil)
	{
		viewControllerOrNil = [[GtMobileNotificationDisplayManager defaultDisplayManager] defaultViewController];
	}
	
	GtAssertNotNil(viewControllerOrNil);

	GtViewController* controller = (GtViewController*) [viewControllerOrNil.navigationController parentControllerForController:viewControllerOrNil];
	GtAssertNotNil(controller);
	
	[controller addDidAppearCallback:[GtDeferShowNotification deferShowNotificationInViewController:controller notification:self]];
}


@end