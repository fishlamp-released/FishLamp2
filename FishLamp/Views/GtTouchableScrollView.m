//
//  GtTouchableScrollView.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/26/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtTouchableScrollView.h"

@implementation GtTouchableScrollView


- (id) privateDelegate
{
    return (id) self.delegate;
}

- (BOOL)touchesShouldBegin:(NSSet *)touches withEvent:(UIEvent *)event inContentView:(UIView *)view
{
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    BOOL handled = NO;
    if(self.privateDelegate && [self.privateDelegate respondsToSelector:@selector(touchableScrollView:touchesBegan:withEvent:)])
    {
       handled = [self.privateDelegate touchableScrollView:self touchesBegan:touches withEvent:event];
    }

    if(!handled)
    {
        [super touchesBegan:touches withEvent:event];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	BOOL handled = NO;
    if(self.privateDelegate && [self.privateDelegate respondsToSelector:@selector(touchableScrollView:touchesMoved:withEvent:)])
    {
        handled = [self.privateDelegate touchableScrollView:self touchesMoved:touches withEvent:event];
    }

    if(!handled)
    {
        [super touchesMoved:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
	BOOL handled = NO;
    if(self.privateDelegate && [self.privateDelegate respondsToSelector:@selector(touchableScrollView:touchesCancelled:withEvent:)])
    {
        handled = [self.privateDelegate touchableScrollView:self touchesCancelled:touches withEvent:event];
    }

    if(!handled)
    {
        [super touchesCancelled:touches withEvent:event];
    }
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	

    BOOL handled = NO;
    if(self.privateDelegate && [self.privateDelegate respondsToSelector:@selector(touchableScrollView:touchesEnded:withEvent:)])
    {
        handled = [self.privateDelegate touchableScrollView:self touchesEnded:touches withEvent:event];
    }

    if(!handled)
    {   
        // Getting multiple calls here. bug is in sdk fixed in 3.0??
        [super touchesEnded: touches withEvent: event];

        if (!self.dragging && m_lastEventTimeStamp != event.timestamp) 
        {
            m_lastEventTimeStamp = event.timestamp;
            [self.nextResponder touchesEnded: touches withEvent:event]; 
        }
    
    }

}


@end
