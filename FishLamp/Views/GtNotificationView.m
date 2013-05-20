//
//  GtNotificationView.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtNotificationView.h"
#import "GtGeometry.h"
#import "GtEventEaterView.h"
#import "GtViewUtilities.h"
#import "GtCallback.h"
#import "GtProgressHandler.h"
#import "GtColors.h"
#import <QuartzCore/QuartzCore.h>
#import "GtWindow.h"
#import "GtSimpleHtmlView.h"
#import "GtViewFader.h"

@interface GtNotificationView (PrivateMethods)


//+ (void) recursiveDisable:(UIView*) view
//	disabledList:(NSMutableArray*) disabledList;

- (UILabel*) createLabel:(CGRect) labelFrame;
	
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

#define GetCenter(r) CGPointMake(r.origin.x + (r.size.width/2), r.origin.y + (r.size.height/2))

GtSynthesizeWeakRefProperty();

@synthesize autoCloseDelay = m_autoCloseDelay;
@synthesize customLocation = m_customLocation;
@synthesize maxTextHeight = m_maxHeight;
@synthesize delegate = m_delegate;

GtSynthesizeStructProperty(isModal, setIsModal, BOOL, m_notificationViewFlags);
GtSynthesizeStructProperty(canDismiss, setCanDismiss, BOOL, m_notificationViewFlags);
GtSynthesizeStructProperty(isHtml, setIsHtml, BOOL, m_notificationViewFlags);
GtSynthesizeStructProperty(location, setLocation, GtNotificationViewLocation, m_notificationViewFlags);
GtSynthesizeStructProperty(animationType, setAnimationType, GtNotificationViewAnimationType, m_notificationViewFlags);

GtSynthesize(textColor, setTextColor, UIColor, m_textColor);
GtSynthesize(customView, setCustomView, UIView, m_customView);
GtSynthesize(icon, setIcon, UIImage, m_icon);
GtSynthesizeString(title, setTitle);
GtSynthesizeString(errorCode, setErrorCode);

- (GtStringBuilder*) text
{
	if(!m_text)
	{
		m_text = [GtAlloc(GtHtmlBuilder) initWithPrettyPrint:YES];
	}
	return m_text;
}

- (id) init
{
	if(self = [self initWithFrame:CGRectZero])
	{
		self.canDismiss = YES;
		self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
		
		self.textColor = [UIColor whiteColor];
		self.userInteractionEnabled = YES;
		self.exclusiveTouch = YES;
        
        self.maxTextHeight = NSUIntegerMax;
        
        [self setNeedsLayout];
	}
	
	return self;
}

- (UIColor*) color
{
	return self.optionalBackgroundColor;
}

- (void) setColor:(UIColor*) color
{
	self.optionalBackgroundColor = color;
}

- (void) cancelTimer
{
	if(m_timer)
	{
		[m_timer invalidate];
		m_timer = nil;
	}
}

+ (UIColor*) modalColor
{
	return [UIColor darkBlueColor];
}

- (void) releaseViews
{
    GtReleaseWithNil(m_titleLabel);
    GtReleaseWithNil(m_closeBox);
    GtReleaseWithNil(m_iconView);
    GtReleaseWithNil(m_htmlView);
    GtReleaseWithNil(m_textView);
    GtReleaseWithNil(m_timeLabel);
    GtReleaseWithNil(m_errorLabel);
    GtReleaseWithNil(m_shieldView);

}

- (void) removeViews
{
    [m_titleLabel removeFromSuperview];
    [m_closeBox removeFromSuperview];
    [m_iconView removeFromSuperview];
    [m_htmlView removeFromSuperview];
    [m_textView removeFromSuperview];
    [m_timeLabel removeFromSuperview];
    [m_errorLabel removeFromSuperview];
    [m_shieldView removeFromSuperview];
    
    [self releaseViews];

}


- (void)dealloc 
{
    [[GtWindow topWindow] stopObservingWebView];

	[self cancelTimer];
	GtReleaseWeakRef();
	GtRelease(m_customView);
	GtRelease(m_text);
	GtRelease(m_textColor);
	GtRelease(m_icon);
	GtRelease(m_title);
	GtRelease(m_errorCode);
    GtRelease(m_oldBackgroundColor);
    GtRelease(m_oldTextColor);
    GtRelease(m_viewAnimator);
	
    [self releaseViews];
    
    [super dealloc];
}

- (void) setErrorCodeWithInteger:(NSInteger) errorCode
{
	self.errorCode = [NSString stringWithFormat:@"%d", errorCode];
}

- (void) animateOntoScreen
{
    GtReleaseWithNil(m_viewAnimator);
    switch(self.animationType)
    {
        case GtNotificationViewAnimationTypeSlide:
        {
            GtAnimationPosition startPosition = GtAnimationPositionBottom;
    
            if(m_customLocation > 0)
            {
                if(m_customLocation < self.superview.bounds.size.height / 2)
                {
                    startPosition = GtAnimationPositionTop;
                }
            }
            else if(self.location == GtNotificationViewLocationTop || 
                    self.location == GtNotificationViewLocationCentered)
            {
                startPosition = GtAnimationPositionTop;
            }
            
            m_viewAnimator = [GtAlloc(GtViewAnimator) initWithStartPosition:startPosition];
        }
        break;
        
        case GtNotificationViewAnimationTypeFade:
            m_viewAnimator = [GtAlloc(GtViewFader) init];
        break;
    }
    
    [m_viewAnimator showView:self];    
}

- (void) notifyWasTouched
{
    if(m_delegate && !m_notificationViewFlags.notifiedWasTouched)
    {
        m_notificationViewFlags.notifiedWasTouched = YES;
        [m_delegate notificationViewWasTouched:self];
    }
    
    [self cancelTimer];
}

- (void) onClose:(id) sender
{
    self.optionalBackgroundColor = m_oldBackgroundColor;
    GtReleaseWithNil(m_oldBackgroundColor);
    [self setNeedsDisplay];
    [self hide];
}

- (void) onStartClose:(id) sender
{
    GtReleaseWithNil(m_oldBackgroundColor);
    GtReleaseWithNil(m_oldTextColor);

    if(!self.isModal && self.canDismiss)
    {
        m_oldBackgroundColor = [self.backgroundColor retain];

        self.optionalBackgroundColor = [UIColor iPhoneBlueColor];
        [self setNeedsDisplay];
    }
    
    [self notifyWasTouched];
}


- (void) createViews
{
    if(m_icon)
    {
        m_iconView = [GtAlloc(UIImageView) initWithImage:m_icon];
        [self addSubview:m_iconView];
    }
    
    if(m_title)
    {
        m_titleLabel = [GtAlloc(UILabel) initWithFrame:CGRectZero];
        m_titleLabel.lineBreakMode = UILineBreakModeTailTruncation;
        m_titleLabel.textColor = self.textColor;
        m_titleLabel.backgroundColor = [UIColor clearColor];
        m_titleLabel.textAlignment = UITextAlignmentLeft;
        m_titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        m_titleLabel.text = m_title;
        m_titleLabel.numberOfLines = 1;
        [self addSubview:m_titleLabel];
    }   
    
    NSString* text = [self.text toString];
    if(text && text.length)
    {
        if(self.isHtml)
        {
            UIFont* textFont = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
                
            m_htmlView = [GtAlloc(GtSimpleHtmlView) initWithFrame:CGRectZero];
                
            [m_htmlView setIsTransparent];
            [m_htmlView.html openStyleAttribute];
            [m_htmlView.html addStyleFont:textFont];
            [m_htmlView.html addStyleColor:self.textColor];
            [m_htmlView.html addStyleClearBackgroundColor];
            [m_htmlView.html closeStyleAttribute];
            
            [m_htmlView.html openBodyElement];
            [m_htmlView.html appendString:text];
            [m_htmlView.html closeElement];
            [m_htmlView setLoadedCallback:self action:@selector(onLoadedHtml:)];
            [m_htmlView renderHtml];  
            [self addSubview:m_htmlView];
            
            [[GtWindow topWindow] startObservingWebView:self 
                    forWebView:m_htmlView];
        }
        else
        {
            UIFont* textFont = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]+1];

            m_textView = [GtAlloc(UILabel) initWithFrame:CGRectZero];
    
            m_textView.lineBreakMode = UILineBreakModeWordWrap;
            m_textView.textColor = self.textColor;
            m_textView.backgroundColor = [UIColor clearColor];
            m_textView.textAlignment = UITextAlignmentLeft;
            m_textView.text = text;
            m_textView.numberOfLines = 0;
            m_textView.font  = textFont;
            [self addSubview:m_textView];
            
        }
    }
    
    if(m_errorCode && m_errorCode.length > 0)
    {
        m_errorLabel = [GtAlloc(UILabel) initWithFrame:CGRectZero];
        m_errorLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        m_errorLabel.textColor = self.textColor;
        m_errorLabel.backgroundColor = [UIColor clearColor];
        m_errorLabel.numberOfLines = 1;
        m_errorLabel.text = m_errorCode;
        [self addSubview:m_errorLabel];
        
        NSDate* date = [GtAlloc(NSDate) init];
        NSDateFormatter* dateFormatter = [GtAlloc(NSDateFormatter) init];

        m_timeLabel = [GtAlloc(UILabel) initWithFrame:CGRectZero];

        m_timeLabel.font = [UIFont systemFontOfSize:[UIFont smallSystemFontSize]];
        m_timeLabel.textColor = self.textColor;
        m_timeLabel.backgroundColor = [UIColor clearColor];
        m_timeLabel.numberOfLines = 1;
        [dateFormatter setTimeStyle:kCFDateFormatterShortStyle];

        m_timeLabel.text = [dateFormatter stringFromDate:date];
        
        [self addSubview:m_timeLabel];
        
        GtRelease(dateFormatter);
        GtRelease(date);
    }   

    if(self.canDismiss && !self.isModal)
    {
    /* 
        m_closeBox = [GtAlloc(UILabel) initWithFrame:CGRectZero];
        m_closeBox.text = @"x";
        m_closeBox.backgroundColor = [UIColor clearColor];
        m_closeBox.textColor = m_textColor;
        m_closeBox.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
     */   
        m_closeBox = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        UIImage* img = [UIImage imageNamed:@"icon_delete_small.png"];
        [m_closeBox setImage:img forState:UIControlStateNormal];
        CGRect frame = m_closeBox.frame;
        frame.size = img.size;
        frame.size.width *= 2;
        frame.size.height *= 2;
        
        
        [m_closeBox addTarget:self action:@selector(onStartClose:) forControlEvents:UIControlEventTouchDown];
        [m_closeBox addTarget:self action:@selector(onClose:) forControlEvents:UIControlEventTouchUpInside|UIControlEventTouchUpOutside];
        m_closeBox.frame = frame;
        [self addSubview:m_closeBox];
        
	}

    if(m_autoCloseDelay)
	{
		m_timer = [NSTimer timerWithTimeInterval:m_autoCloseDelay
			target:self 
			selector:@selector(hide) 
			userInfo:nil 
			repeats:NO];
		[[NSRunLoop mainRunLoop] addTimer:m_timer 
			forMode:NSRunLoopCommonModes];
	}
}

- (void) updateSizeAndLocation
{
    CGRect superviewBounds = self.superview.bounds;
	CGRect myFrame = superviewBounds;
	myFrame.size.width -= 8;
    myFrame.size.height = 100;
	
	// set up text label
	CGRect textFrame = myFrame;
	textFrame.origin.y = TEXT_TOP;
	textFrame.origin.x = TEXT_LEFT; 
	textFrame.size.width -= (TEXT_LEFT + WIDTH_BUFFER);

	if(m_customView)
	{
		CGRect customViewRect = m_customView.frame;
		[self addSubview:m_customView];
		myFrame.size.height = customViewRect.origin.y + customViewRect.size.height + HEIGHT_BUFFER;
	}
	else
	{
		CGRect titleRect = superviewBounds;
		titleRect.size.height = 18;
		titleRect.origin.y = 10;
		titleRect.origin.x = 10;
				
		if(m_closeBox)
		{
			CGRect newFrame = m_closeBox.frame;
			
		//	newFrame.size.width = 14;
		//	newFrame.size.height = 14;
			
			newFrame = GtRightJustifyRectInRect(myFrame, newFrame);
		//	newFrame.origin.x -= 3;
		//	newFrame.origin.y = 3;
		
            m_closeBox.frame = newFrame;
			
			titleRect.size.width -= newFrame.size.width - 5;
		}
		
		if(m_iconView)
		{
			m_iconView.frame = CGRectMake(10,10,m_icon.size.width, m_icon.size.height);
			
            textFrame.origin.y += 25;
			titleRect.size.width -= m_iconView.frame.size.width - 10;
			titleRect.origin.x = m_iconView.frame.origin.x + m_iconView.frame.size.width + 5;
		}
		
		if(m_titleLabel)
		{
            m_titleLabel.frame = titleRect;
			myFrame.size.height = titleRect.origin.y + titleRect.size.height + HEIGHT_BUFFER;
		}
		
        NSString* text = [self.text toString];
        if(text && text.length)
        {
            if(m_htmlView)
            {
                CGSize size = m_htmlView.loadedSize;

                textFrame.size.height = MIN(size.height, self.maxTextHeight);
                textFrame.size.height = MAX(textFrame.size.height, 32);

                m_htmlView.frame = textFrame;
                
            }
            else if(m_textView)
            {
                CGSize size = [text sizeWithFont:m_textView.font
                    constrainedToSize:CGSizeMake(textFrame.size.width, 1000)
                    lineBreakMode:UILineBreakModeWordWrap];
                textFrame.size.height = MIN(size.height, self.maxTextHeight);
                
                m_textView.frame = textFrame;
            }

            myFrame.size.height = textFrame.origin.y + textFrame.size.height + HEIGHT_BUFFER;
        }

          
		if(m_errorCode && m_errorCode.length > 0)
		{
			CGRect errorFrame = myFrame;
			errorFrame.size.height = 14;
			
			errorFrame.size = [m_errorCode sizeWithFont:m_errorLabel.font
				constrainedToSize:CGSizeMake(errorFrame.size.width, 1000)
				lineBreakMode:UILineBreakModeTailTruncation];
			
			myFrame.size.height += errorFrame.size.height;
			
			errorFrame = GtRightJustifyRectInRect(myFrame, errorFrame);
			errorFrame = GtBottomJustifyRectInRect(myFrame, errorFrame);
			
			errorFrame.origin.x -= 6;
			errorFrame.origin.y -= 3;
			
			m_errorLabel.frame = errorFrame;
            
            errorFrame.origin.x = 12;
            
            errorFrame.size = [m_timeLabel.text sizeWithFont:m_timeLabel.font
				constrainedToSize:CGSizeMake(superviewBounds.size.width, 1000)
				lineBreakMode:UILineBreakModeTailTruncation];
			
            m_timeLabel.frame = errorFrame;
        }
	}
	
    if(m_customLocation > 0)
	{
		myFrame.origin.y = m_customLocation;
	}
	else
	{
		switch(self.location)
		{
			case GtNotificationViewLocationBottom:
			case GtNotificationViewLocationBottomAboveToolBar:
			case GtNotificationViewLocationBottomAboveTabBar:
					myFrame.origin.y = superviewBounds.size.height - myFrame.size.height - 2 - 42.0;
				break;
				
			case GtNotificationViewLocationCentered:
				// center in top 3rd so it shows if keyboard is visible
				myFrame.origin.y = (superviewBounds.size.height / 3) - (myFrame.size.height/2);
				break;
				
			case GtNotificationViewLocationTop:
				myFrame.origin.y = GtNavigationBarHeight + 4 + 20;
				break;
				
		}
	}	
	
	self.frame = GtCenterRectHorizontallyInRect(superviewBounds, myFrame);
	
	UIView* hostView = self.superview;
	
	GtAssertNotNil(hostView);
	
	if(self.isModal)
	{
		CGRect ourBounds = hostView.frame;
        
        [m_shieldView removeFromSuperview];
        GtReleaseWithNil(m_shieldView);

        m_shieldView = [GtAlloc(GtEventEaterView) initWithFrame:ourBounds];
    
    /*
		CATransition* anim = [CATransition animation];
		anim.timingFunction = UIViewAnimationCurveEaseInOut;
		anim.type = kCATransitionFade; 
		anim.duration = FADE_DURATION;
		
		CALayer* layer = self.superview.layer;
		[layer addAnimation:anim forKey:@"myAnim"];
	*/
        [hostView addSubview:m_shieldView];
		[hostView bringSubviewToFront:m_shieldView];
      
    /*
		[layer removeAnimationForKey:@"myAnim"];
	*/	
		self.optionalBackgroundColor = [GtNotificationView modalColor];
		self.backgroundOpacity = 1.0;
	}
	
	[hostView bringSubviewToFront:self];
}

- (void) onLoadedHtml:(id) sender
{
    [self updateSizeAndLocation];
    [self setNeedsDisplay];
}

- (void) show
{
    GtAssert(self.superview != nil, @"needs to be in a view first");

    if(!m_notificationViewFlags.visible)
    {
        m_notificationViewFlags.visible = YES; 
        [self createViews];
        [self updateSizeAndLocation];
        [self animateOntoScreen];
    }
}

- (void) layoutSubviews
{
	[super layoutSubviews];
    
    [self show];
}	

- (void) hide
{
    if(m_notificationViewFlags.visible)
    {
        m_notificationViewFlags.visible = NO; 

        [self cancelTimer];
        
        if(self.isModal)
        {
    /*		CATransition* anim = [CATransition animation];
            anim.timingFunction = UIViewAnimationCurveEaseInOut;
            anim.type = kCATransitionFade; 
            anim.duration = FADE_DURATION;

            CALayer* layer = self.superview.layer;
            [layer addAnimation:anim forKey:@"myAnim"];
    */
            [m_shieldView removeFromSuperview];
    /*        
            [layer removeAnimationForKey:@"myAnim"];
    */
        }
        
        [m_viewAnimator removeFromSuperview:self];
    }
}

- (void) close
{
    [self hide];
}


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

+ (UIView*) defaultSuperview
{
	return [GtWindow topWindow];
}

- (void) showInDefaultWindow
{
	[[GtWindow topWindow] addSubview:self];
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

