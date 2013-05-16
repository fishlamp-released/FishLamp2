//
//  GtBusyView.m
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if IPHONE
#import <QuartzCore/QuartzCore.h>

#import "GtBusyView.h"
#import "GtGeometry.h"
#import "GtEventEaterView.h"
#import "GtViewUtilities.h"
#import "GtProgressHandler.h"

#define FADE_DURATION 0.1
#define POPINOUT_DURATION 0.05

@interface GtBusyView (PrivateMethods)

+ (void) recursiveDisable:(UIView*) view
	disabledList:(NSMutableArray*) disabledList;

- (UILabel*) createLabel:(CGRect) labelFrame;
	
@end

@implementation GtBusyView

#define DEFAULT_LABEL_WIDTH 100.0
#define DEFAULT_LABEL_HEIGHT 30.0
#define SPINNER_RIGHT_MARGIN 6.0
#define HEIGHT_BUFFER 16.0
#define WIDTH_BUFFER 40.0
#define SPINNER_TOP 8.0
#define TEXT_TOP 11.0
#define SPINNER_LEFT 10.0

- (void)doneAdding:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	if(m_progressView)
	{
		[self addSubview:m_progressView];
	}
	if(m_spinner)
	{
		[self addSubview:m_spinner];
	}
	[self addSubview:m_textLabel];

	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];
}

- (void)doneRemoving:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[self removeFromSuperview];
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];
}

- (void) resize:(UIView*) hostingView
{
	CGRect ourBounds = [hostingView bounds];
		
// setup our sizes, etc

	[m_textLabel sizeToFit];

	CGRect myFrame = ourBounds;
	CGRect textFrame = m_textLabel.frame;

	if(m_spinner)
	{
		CGRect spinnerFrame = m_spinner.frame;
		spinnerFrame.origin.y = SPINNER_TOP;
		spinnerFrame.origin.x = SPINNER_LEFT;
		
		textFrame.origin.y = TEXT_TOP;
		textFrame.origin.x = spinnerFrame.origin.x + spinnerFrame.size.width + SPINNER_RIGHT_MARGIN; 
		
		myFrame.size.height = MAX(spinnerFrame.size.height, textFrame.size.height) + HEIGHT_BUFFER;
		myFrame.size.width = m_textLabel.frame.size.width + m_spinner.frame.size.width + WIDTH_BUFFER;
		
		if(m_button)
		{
			CGRect buttonFrame = m_button.frame;
		
			myFrame.size.height += buttonFrame.size.height + HEIGHT_BUFFER;
			myFrame.size.width = buttonFrame.size.width + WIDTH_BUFFER;

			m_button.frame = GtCenterRectHorizontallyInRect(myFrame, buttonFrame);
		
			CGRect unionRect = CGRectUnion(spinnerFrame, textFrame);
			
			unionRect.origin.y += 4;
			
			unionRect = GtCenterRectHorizontallyInRect(myFrame, unionRect);
			
			spinnerFrame.origin.y += 4;
			spinnerFrame.origin.x = unionRect.origin.x;
			textFrame.origin.y += 4;
			textFrame.origin.x = unionRect.origin.x + spinnerFrame.size.width + SPINNER_RIGHT_MARGIN;
		}
		
		m_spinner.frame = spinnerFrame;
		m_textLabel.frame = textFrame;
	}
	else
	{
		CGRect progressFrame = m_progressView.frame;

		progressFrame.origin.y = SPINNER_TOP;
		progressFrame.origin.x = SPINNER_LEFT;
		progressFrame.size.height = 10;// 

		textFrame.origin.y = progressFrame.origin.y + progressFrame.size.height + 4;
		textFrame.origin.x = SPINNER_LEFT; 
		
		myFrame.size.height = textFrame.origin.y + textFrame.size.height;
		myFrame.size.width = textFrame.size.width + WIDTH_BUFFER;
		
		if(m_button)
		{
			CGRect buttonFrame = m_button.frame;
			buttonFrame.origin.y = myFrame.size.height + 10;
			
			myFrame.size.height = buttonFrame.origin.y + buttonFrame.size.height + 20;
			myFrame.size.width = MAX(myFrame.size.width, buttonFrame.size.width + WIDTH_BUFFER + 40);

			buttonFrame = GtCenterRectHorizontallyInRect(myFrame, buttonFrame);
            m_button.frame = GtBottomJustifyRectInRect(myFrame, buttonFrame);
		}
		
		textFrame.size.width = MAX(myFrame.size.width - (SPINNER_LEFT*2), textFrame.size.width);
		m_textLabel.textAlignment = UITextAlignmentCenter;
		
		myFrame.size.height += HEIGHT_BUFFER;
		
		progressFrame.size.width = myFrame.size.width - (SPINNER_LEFT*2);
		m_progressView.frame = progressFrame;
	}	
	m_textLabel.frame = textFrame;
	self.frame = myFrame;
    [self setNeedsDisplay];
    [self setNeedsLayout];
}

- (void) setBusyText:(NSString*) text
{
	m_textLabel.text = text;
	[self resize:self.superview];
}

- (id) init
{
	if(self = [super initWithFrame:CGRectZero])
	{
		
	}
	
	return self;
}

- (id) initWithProgressHandler:(GtProgressHandler*) info
{
	if(self = [super initWithFrame:CGRectZero])
	{
		[self setup:info];
	}
	
	return self;
}	
	

- (void) cleanup
{
	GtReleaseWithNil(m_shieldView);
	GtReleaseWithNil(m_button);
	GtReleaseWithNil(m_progressView);
	GtReleaseWithNil(m_spinner);
	GtReleaseWithNil(m_textLabel);
}

- (void)dealloc 
{   
    GtReleaseWithNil(m_info);
    [self cleanup];
    [super dealloc];
}

    
- (void) setup:(GtProgressHandler*) info
{
    if(!m_info)
    {
        m_info = [GtAlloc(GtWeakReference) init];
    }

	m_info.object = info;
	
    [m_shieldView removeFromSuperview];
    [m_progressView removeFromSuperview];
    [m_spinner removeFromSuperview];
    [m_textLabel removeFromSuperview];
    [m_button removeFromSuperview];
    
    [self cleanup];
    
    self.userInteractionEnabled = YES;
	self.autoresizesSubviews = NO;
	self.autoresizingMask = UIViewAutoresizingNone;

	GtAssertNotNil([m_info.object superview]);
	
	CGRect ourBounds = [m_info.object superview].frame;
	
	if([m_info.object wantsProgressBar])
	{
		m_progressView = [GtAlloc(UIProgressView) initWithProgressViewStyle:UIProgressViewStyleDefault];
		m_progressView.frame = CGRectMake(0,0, 100,100); // will change later
		m_progressView.autoresizingMask = UIViewAutoresizingNone;
        m_canDrag = YES;
	}
	else
	{
	// add spinner
		m_spinner = [GtAlloc(UIActivityIndicatorView) initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
		[m_spinner startAnimating];
		m_spinner.frame = CGRectMake(0,0,20,20);
		m_spinner.autoresizingMask = UIViewAutoresizingNone;
	}
	
	
// add text label	
	m_textLabel = [GtAlloc(UILabel) initWithFrame:CGRectMake(0,0, 100, 20)];
	m_textLabel.textColor = [UIColor whiteColor];
	m_textLabel.backgroundColor = [UIColor clearColor];
	m_textLabel.textAlignment = UITextAlignmentLeft;
	m_textLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]]; 
	m_textLabel.text = [m_info.object text];
	m_textLabel.autoresizingMask = UIViewAutoresizingNone;
	
// button	
	if([m_info.object buttonText])
	{
		m_button = [[UIButton buttonWithType:UIButtonTypeRoundedRect] retain];
		[m_button setTitle:[m_info.object buttonText] forState:UIControlStateNormal]; 
		
		[m_button addTarget:[m_info.object buttonTarget] 
			action:[m_info.object buttonAction] 
			forControlEvents:UIControlEventTouchUpInside];
		
		m_button.frame = CGRectMake(0,40,160,32);
		m_button.autoresizingMask = UIViewAutoresizingNone;

		[self addSubview:m_button];
	}
	
// setup our parent and animations
	if([m_info.object isModal])
	{
		self.backgroundOpacity = 1.0;
		self.borderOpacity = 1.0;
				
		m_shieldView = [GtAlloc(GtEventEaterView) initWithFrame:ourBounds];
		m_shieldView.backgroundColor = [UIColor grayColor];
		m_shieldView.alpha = 0.5;
	
		CATransition* anim = [CATransition animation];
		anim.timingFunction = UIViewAnimationCurveEaseInOut;
		anim.type = kCATransitionFade; 
		anim.duration = FADE_DURATION;
		
		CALayer* layer = [m_info.object superview].layer;
		
		[layer addAnimation:anim forKey:@"myAnim"];
	
		[[m_info.object superview] addSubview:m_shieldView];
		[[m_info.object superview] bringSubviewToFront:m_shieldView];
		
		[layer removeAnimationForKey:@"myAnim"];
	}

	if(m_progressView)
	{
		[self addSubview:m_progressView];
	}
	if(m_spinner)
	{
		[self addSubview:m_spinner];
	}
	[self addSubview:m_textLabel];
	
    if(!self.superview)
    {
        [[m_info.object superview] addSubview:self];
    }
	
	if([m_info.object opacity] >= 0)
	{
		self.backgroundOpacity = [m_info.object opacity];
		self.borderOpacity = [m_info.object opacity];
	}

// setup our sizes, etc

	[self resize:[m_info.object superview]];
    
	return;
/*
	CGRect destRect = self.frame;
	
	ourBounds = CGRectInset(ourBounds, 10, 0);
	
	if(m_info.isModal || m_info.nonModalProgressLocation == GtProgressLocationCentered)
	{
		destRect = GtCenterRectInRect(ourBounds, destRect);
	}
	else
	{
		destRect.origin.y = ourBounds.size.height - destRect.size.height;
		destRect.origin.x = ourBounds.size.width - destRect.size.width;
		
		if(m_info.nonModalProgressLocation == GtProgressLocationLowerRightAboveToolbar)
		{
			destRect.origin.y -= 42;
		}
	}
	
	self.frame = destRect;
	
	[m_info.superview addSubview:self];
	[m_info.superview bringSubviewToFront:self];
	
	return;
	
	CGRect smallRect = destRect;
	smallRect.size.width /= 100.0;
	smallRect.size.height /= 100.0;
	self.frame = GtCenterRectInRect(destRect, smallRect);
	
	[m_info.superview addSubview:self];
	[m_info.superview bringSubviewToFront:self];
	
	[UIView beginAnimations:@"viewout" context:nil];
	[UIView setAnimationDuration:POPINOUT_DURATION];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(doneAdding:finished:context:)];
	self.frame = destRect;
	[UIView commitAnimations];
*/
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
    if(!m_info.object)
    {
        GtLog(@"where is the object?");
    }
    
	CGRect destRect = self.frame;
	
	CGRect ourBounds = self.superview.bounds;
	
	if([m_info.object isModal] || [m_info.object location] == GtProgressLocationCentered)
	{
		destRect = GtCenterRectInRect(ourBounds, destRect);
		
		destRect.origin.y = (ourBounds.size.height / 3.0);
		
	}
	else
	{
		destRect.origin.y = ourBounds.size.height - destRect.size.height;
		destRect.origin.x = ourBounds.size.width - destRect.size.width;
		
		switch([m_info.object location])
		{
			case GtProgressLocationLowerRightAboveToolbar:
				destRect.origin.y -= GtToolBarHeight;
				break;
				
			case GtProgressLocationLowerRightAboveTabBar:
				destRect.origin.y -= GtTabBarHeight;
				break;
                
            case GtProgressLocationCurrentPosition:
                GtCenterRectHorizontallyInRect(ourBounds, destRect);
                break;
		}
	}
	
	self.frame = destRect;
	
    [self.superview bringSubviewToFront:self];
}

- (void) updateProgress:(CGFloat) value
{
	if(m_progressView)
	{
		m_progressView.progress = value;
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(m_canDrag)
    {
        UITouch* touch = [touches anyObject];
        if(touch.view == self)
        {
            m_opacity = self.alpha;
            self.alpha = 0.5;
            [self setNeedsDisplay];
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(m_canDrag)
    {
        UITouch* touch = [touches anyObject];
        if(touch.view == self)
        {
            CGPoint curPoint = [touch locationInView:self.superview];
            CGPoint prevPoint = [touch previousLocationInView:self.superview];
            
            CGRect frame = GtRectOffsetByPoint(self.frame, 
                CGPointMake(curPoint.x - prevPoint.x, curPoint.y - prevPoint.y));
            self.frame = frame;
        }
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(m_canDrag)
    {
        UITouch* touch = [touches anyObject];
        if(touch.view == self)
        {
            self.alpha = m_opacity;
            [self setNeedsDisplay];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(m_canDrag)
    {
        UITouch* touch = [touches anyObject];
        if(touch.view == self)
        {
            self.alpha = m_opacity;
            [self setNeedsDisplay];
        }
    }
}


- (void) deferredDone:(id) sender
{
	if(m_animateClose)
	{
		CATransition* anim = [CATransition animation];
		anim.timingFunction = UIViewAnimationCurveEaseInOut;
		anim.type = kCATransitionFade; 
		anim.duration = FADE_DURATION;
		
		CALayer* layer = self.superview.layer;

		[layer addAnimation:anim forKey:@"myAnim"];
		
		if(m_shieldView)
		{
			[m_shieldView removeFromSuperview];
		}

		[layer removeAnimationForKey:@"myAnim"];
		
		UIView* hostingView = self.superview.window ? self.superview.window : self.superview;
		CGRect ourBounds = [hostingView frame];
		
		CGRect smallRect = self.frame;
		smallRect.size.width /= 100.0;
		smallRect.size.height /= 100.0;
		
		[m_spinner removeFromSuperview];
		[m_textLabel removeFromSuperview];
		[m_progressView removeFromSuperview];
		
		[UIView beginAnimations:@"viewout" context:nil];
		[UIView setAnimationDuration:POPINOUT_DURATION];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
		[UIView setAnimationDelegate:self];
		[UIView setAnimationDidStopSelector:@selector(doneRemoving:finished:context:)];
		self.frame = GtCenterRectInRect(ourBounds, smallRect);
		[UIView commitAnimations];
	}
	else
	{
		if(m_shieldView)
		{
			[m_shieldView removeFromSuperview];
		}
		if(self.superview)
		{
			[self removeFromSuperview];
		}
	}
}

#if DEBUG
#define TEST_UI 0
#endif

- (void) setDone:(BOOL) animate
{
	m_animateClose = NO; // causing problems because host view is not necessarily still there if deferred.
	
#if TEST_UI	
	if(m_animateClose)
	{
		NSTimer* timer = [NSTimer timerWithTimeInterval:(FADE_DURATION*2) 
			target:self 
			selector:@selector(deferredDone:) 
			userInfo:nil 
			repeats:NO];
		[[NSRunLoop mainRunLoop] addTimer:timer 
			forMode:NSRunLoopCommonModes];
	}
	else
	{
		[self deferredDone:self];
	}
#else
	[self deferredDone:self];
#endif
}

#if DISABLE_CONTROLS
/*
+ (void) enableControls:(NSArray*) controls
{
	if(controls)
	{
		for(UIControl* control in controls)
		{
			[control setEnabled:YES];
		}
	}
}
+ (BOOL) canDisable:(id) item
{
	if(item != nil)
	{
		for(Class c in s_classArray)
		{
			if([item isKindOfClass:c])
			{
				return [item isEnabled];
			}
		}
	}
	return NO;
}

+ (void) possiblyDisableItem:(id) item
	disabledList:(NSMutableArray*) disabledList
{
	if( [self canDisable:item])
	{
		[item setEnabled:NO];
		[disabledList addObject:item]; 
	}
}


// This is problematic at best

+ (void) recursiveDisable:(UIView*) view
	disabledList:(NSMutableArray*) disabledList
{
	GtAssertNotNil(view);

	[self possiblyDisableItem:view disabledList:disabledList];
	
	NSArray* subviews = view.subviews; // COPY!
	if(subviews)
	{
		for(id subview in subviews)
		{
			if(	![subview isKindOfClass:[GtBusyView class]] )
			{
				if( [subview isKindOfClass:[UINavigationBar class]])
				{
					UINavigationBar* bar = (UINavigationBar*) subview;
				
					NSArray* items = [bar items];
					for(UINavigationItem* item in items)
					{
						[self possiblyDisableItem:[item leftBarButtonItem] disabledList:disabledList];
						[self possiblyDisableItem:[item rightBarButtonItem] disabledList:disabledList];
						[self possiblyDisableItem:[item backBarButtonItem] disabledList:disabledList];
					}
				
					// these are NOT uiviews
					[self possiblyDisableItem:[[subview topItem] leftBarButtonItem]  disabledList:disabledList];
					[self possiblyDisableItem:[[subview topItem] rightBarButtonItem]  disabledList:disabledList];
				}
				else if( [subview isKindOfClass:[UIToolbar class]] || 
						 [subview isKindOfClass:[UITabBar class]] )
				{
					// these are NOT uiviews
					for(UIBarButtonItem* item in [subview items])
					{
						[self possiblyDisableItem:item disabledList:disabledList];
					}
				}
				else if( [subview isKindOfClass:[UITableView class]])
				{
				// is this sufficient?
					for(UITableViewCell* cell in [subview visibleCells])
					{
						[self recursiveDisable:cell disabledList:disabledList];
					}
				}
				
				[self recursiveDisable:subview disabledList:disabledList];
			}
		}
	}
}
*/
#endif

@end

#endif