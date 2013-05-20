//
//  GtExternalTouchViewCloser.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/15/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtExternalTouchViewCloser.h"

@implementation GtExternalTouchViewCloser

@synthesize delegate = m_delegate;

- (id) init
{
    if((self = [super init]))
    {
        m_views = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    return self;
}

+ (GtExternalTouchViewCloser*) externalTouchViewCloser
{
    return GtReturnAutoreleased([[GtExternalTouchViewCloser alloc] init]);
}

- (void) beginWatchingTouchesForView:(UIView*) view
{
    GtAssertNotNil(view);
    GtAssertNotNil(view.window);

    [self addPrimaryView:view];
    
    if(![[GtApplication sharedApplication] hasEventInterceptor:self])
    {
        [[GtApplication sharedApplication] addEventInterceptor:self];
    }
}

- (void) stopWatchingTouches
{
    if([[GtApplication sharedApplication] hasEventInterceptor:self])
    {
        [[GtApplication sharedApplication] removeEventInterceptor:self];
    }
}

- (void) dealloc
{
    if([[GtApplication sharedApplication] hasEventInterceptor:self])
    {
        [[GtApplication sharedApplication] removeEventInterceptor:self];
    }

    GtRelease(m_views);
    GtRelease(m_passThroughViews);
    GtSuperDealloc();
}

- (void) addPrimaryView:(UIView*) view
{
    [m_views addObject:view];
}

- (void) addPassthroughView:(UIView*) view
{
    if(!m_passThroughViews)
    {
        m_passThroughViews = [[NSMutableArray alloc] init];
    }
    
    [m_passThroughViews addObject:view];
}

- (BOOL) _isOurView:(UIView*) aView viewArray:(NSArray*) viewArray
{
    if(viewArray)
    {
        for(UIView* view in viewArray)
        {   
            if([aView isDescendantOfView:view])
            {
                return YES;
            }
        }
    }
    
    return NO;
}

- (void) sendCloseEvent
{
    [self.delegate externalTouchViewCloserShouldCloseView:self];
}

- (BOOL) didInterceptEvent:(UIEvent*) event
{
	if(event.type == UIEventTypeTouches)
	{
		NSSet* touches = [event allTouches];
		UITouch* touch = [touches anyObject];

        switch(touch.phase)
		{
			case UITouchPhaseBegan:
                m_touchedView = touch.view;
            
                m_touchIsInside = [self _isOurView:m_touchedView viewArray:m_views];
            
                if(!m_touchIsInside)
                {
                    [self sendCloseEvent];
                }
            break;
            
			case UITouchPhaseCancelled:
                m_touchedView = nil;
			break;
			
			case UITouchPhaseMoved:
			case UITouchPhaseStationary:
			break;
			
			case UITouchPhaseEnded:
                m_touchedView = nil;
			break;
        }
        return !m_touchIsInside && ![self _isOurView:touch.view viewArray:m_passThroughViews];
    }

    return NO;
}
@end
