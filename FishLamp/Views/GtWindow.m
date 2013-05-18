//
//  GtWindow.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/14/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtWindow.h"


@implementation GtWindow

static GtWindow* s_currentWindow = nil;

+ (GtWindow*) topWindow
{
	return s_currentWindow;
}

- (void)becomeKeyWindow
{	
	[super becomeKeyWindow];
	m_prevWindow = s_currentWindow;
	s_currentWindow = self;
}

- (void)resignKeyWindow
{	
	[super resignKeyWindow];
}

- (void) dealloc
{
	s_currentWindow = m_prevWindow;
	[super dealloc];
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
	if(self == s_currentWindow)
	{
		if (event.type == UIEventSubtypeMotionShake) 
		{
			[[NSNotificationCenter defaultCenter] postNotificationName:GtDeviceWasShakenNotification object:[UIApplication sharedApplication]];
		}
	}
	
	if ( [super respondsToSelector:@selector(motionEnded:withEvent:)] )
	{
        [super motionEnded:motion withEvent:event];
	}
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
	if ( [super respondsToSelector:@selector(motionCancelled:withEvent:)] )
	{
        [super motionCancelled:motion withEvent:event];
	}
}


- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if ( [super respondsToSelector:@selector(motionBegan:withEvent:)] )
	{
        [super motionBegan:motion withEvent:event];
	}

}

- (void) startObservingWebView:(id<GtWebViewTouchDelegate>) controller 
    forWebView:(UIWebView*) webView
{
    m_viewController = controller;
    m_webView = webView;
}

- (void) stopObservingWebView
{
    m_viewController = nil;
    m_webView = nil;
}

- (void) touchesBeganTap:(id) event
{
    [m_viewController webViewTouchesBegan:m_webView touches:[event allTouches] withEvent:event];
}

- (void) touchesEndedTap:(id) event 
{
    [m_viewController webViewTouchesEnded:m_webView touches:[event allTouches] withEvent:event];
}

- (void) touchesMoved:(id) event
{
    [m_viewController webViewTouchesMoved:m_webView touches:[event allTouches] withEvent:event];
}

- (void)sendEvent:(UIEvent *)event 
{
    [super sendEvent:event];

    if (m_viewController == nil || m_webView == nil)
    {
        return;
    }
    
    // TODO: mimic all four touch events!?
    
    NSSet* touches = [event allTouches];
    if (touches.count != 1)
    {
        return;
    }

    UITouch *touch = touches.anyObject;
    if ([touch.view isDescendantOfView:m_webView] == NO)
    {
        return;
    }
    
    switch(touch.phase)
    {
        case UITouchPhaseBegan:
            [m_viewController webViewTouchesBegan:m_webView touches:[event allTouches] withEvent:event];

        /*
                [self performSelector:@selector(touchesBeganTap:)  
                           withObject:event 
                           afterDelay:0.25];
        */    
        break;
        
        case UITouchPhaseEnded:
            [m_viewController webViewTouchesEnded:m_webView touches:[event allTouches] withEvent:event];

/*
            if (touch.tapCount == 1) 
            {
                [self performSelector:@selector(touchesEndedTap:)  
                           withObject:event 
                           afterDelay:0.25];
            }
            else if (touch.tapCount > 1) 
            {
                [NSObject cancelPreviousPerformRequestsWithTarget:self 
                            selector:@selector(touchesEndedTap :)  
                              object:event];
            }
        */
        break;
        
        case UITouchPhaseMoved:
            [m_viewController webViewTouchesMoved:m_webView touches:[event allTouches] withEvent:event];

        break;
        
        case UITouchPhaseCancelled:
            [m_viewController webViewTouchesCancelled:m_webView touches:[event allTouches] withEvent:event];
        break;
        
        case UITouchPhaseStationary:
            [m_viewController webViewTouchesStationaryTouch:m_webView touches:[event allTouches] withEvent:event];
        break;
    }
    
   
}

@end
