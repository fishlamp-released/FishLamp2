//
//  FLExternalTouchViewCloser.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/15/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLExternalTouchViewCloser.h"

@implementation FLExternalTouchViewCloser

@synthesize delegate = _delegate;

- (id) init
{
    if((self = [super init]))
    {
        _views = [[NSMutableArray alloc] initWithCapacity:1];
    }
    
    return self;
}

+ (FLExternalTouchViewCloser*) externalTouchViewCloser
{
    return FLAutorelease([[FLExternalTouchViewCloser alloc] init]);
}

- (void) beginWatchingTouchesForView:(UIView*) view
{
    FLAssertIsNotNil(view);
    FLAssertIsNotNil(view.window);

    [self addPrimaryView:view];
    
    if(![[FLApplication sharedApplication] hasEventInterceptor:self])
    {
        [[FLApplication sharedApplication] addEventInterceptor:self];
    }
}

- (void) stopWatchingTouches
{
    if([[FLApplication sharedApplication] hasEventInterceptor:self])
    {
        [[FLApplication sharedApplication] removeEventInterceptor:self];
    }
}

- (void) dealloc
{
    if([[FLApplication sharedApplication] hasEventInterceptor:self])
    {
        [[FLApplication sharedApplication] removeEventInterceptor:self];
    }

    FLRelease(_views);
    FLRelease(_passThroughViews);
    FLSuperDealloc();
}

- (void) addPrimaryView:(UIView*) view
{
    [_views addObject:view];
}

- (void) addPassthroughView:(UIView*) view
{
    if(!_passThroughViews)
    {
        _passThroughViews = [[NSMutableArray alloc] init];
    }
    
    [_passThroughViews addObject:view];
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
                _touchedView = touch.view;
            
                _touchIsInside = [self _isOurView:_touchedView viewArray:_views];
            
                if(!_touchIsInside)
                {
                    [self sendCloseEvent];
                }
            break;
            
			case UITouchPhaseCancelled:
                _touchedView = nil;
			break;
			
			case UITouchPhaseMoved:
			case UITouchPhaseStationary:
			break;
			
			case UITouchPhaseEnded:
                _touchedView = nil;
			break;
        }
        return !_touchIsInside && ![self _isOurView:touch.view viewArray:_passThroughViews];
    }

    return NO;
}
@end
